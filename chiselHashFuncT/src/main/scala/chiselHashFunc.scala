   
package example

import org.scalatest.{FreeSpec, Matchers}

import math.{pow, sqrt}
import scala.util.Random
import scala.io.Source
import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.internal.firrtl.KnownBinaryPoint
import chisel3.iotesters.PeekPokeTester


/**
  * This class creates a hash function for keys of a particular size and depth
  * It creates a fixed table at construction time of a keySize X tableRows of doubles
  * @param keySize     number of doubles in the key
  * @param tableRows   depth of the hash
  * @param w           divisor
  * @param b           offset
  * @param weights     coefficients used for hash calculations
  */
class HashMaker(keySize: Int, tableRows: Int, w: Double, b: Double, weights: Array[Array[Double]]) {
  /**
    * compute key for hash
    * multiplies x element wise against each row of weights, scales each of these sums then adds them together
    * @param key  the key to compute a hash for
    * @return
    */
  def apply(key: Array[Double]): Double = {
    assert(key.length == keySize, s"Error: HashMaker with keySize $keySize got key ${key.mkString(",")}")

    val intermediateSums = weights.indices.map { rowNum =>
      val rowSum = key.zip(weights(rowNum)).foldLeft(0.0) { case (accumulator, (xAtIndex, vectorAtIndex)) =>
        accumulator + (xAtIndex * vectorAtIndex)
      }
      (rowSum + b) / w
    }
    intermediateSums.reduce(_ + _)
  }
}

/**
   * This is a simple hardware version of the above HashMaker
   */ 
class HardwareHashMaker(val fixedType: FixedPoint,
                        val keySize: Int,
                        val hashDepth: Int,
                        val w: Double,
                        val b: Double,
                        val weights: Array[Array[Double]]) extends Module {
  val io = IO(new Bundle {
    val x   = Input(Vec(keySize, fixedType))
    val out = Output(fixedType)
  })

  // convert the divisor into a settable binary point, kind of like a shift

  assert((math.log(w) / math.log(2)).toInt.toDouble == (math.log(w) / math.log(2)), "w $w is not a power of 2")
  private val shiftDivider = (math.log(w) / math.log(2)).toInt
  private val newBinaryPoint = fixedType.binaryPoint match {
    case KnownBinaryPoint(n) => n + shiftDivider + 4
    case _ => throw new Exception(s"binary point of fixedPoint for HashFunction must be known")
  }
  println(s"Shift divider $shiftDivider newBinaryPoint $newBinaryPoint")

  // create a hashDepth X keySize table of random numbers with a gaussian distribution

  private val tabHash0 = weights.map(_.map(_.F(fixedType.getWidth.W, fixedType.binaryPoint)))

  private val offset = b.F(fixedType.binaryPoint)

  private val intermediateSums = (0 until hashDepth).map { ind1 =>
    val sum: FixedPoint = io.x.zip(tabHash0(ind1)).foldLeft(0.F(fixedType.binaryPoint)) { case (accum, (x, t)) =>
      accum + (x * t)
    }

    (sum + offset).setBinaryPoint(newBinaryPoint)
//    ((sum + offset).asUInt() >> shiftDivider).asFixedPoint(fixedType.binaryPoint)
  }

  io.out := intermediateSums.reduce(_ + _)

}

class HashFunctionTester(c: HardwareHashMaker) extends PeekPokeTester(c) {
  def pokeFixedPoint(signal: FixedPoint, value: Double): Unit = {
    val bigInt = value.F(signal.binaryPoint).litValue()
    poke(signal, bigInt)
  }
  def peekFixedPoint(signal: FixedPoint): Double = {
    val bigInt = peek(signal)
    signal.binaryPoint match {
      case KnownBinaryPoint(bp) => FixedPoint.toDouble(bigInt, bp)
      case _ => throw new Exception("Cannot peekFixedPoint with unknown binary point location")
    }
  }

  val hashMaker = new HashMaker(c.keySize, c.hashDepth, c.w, c.b, c.weights)

  def oneTest(key: Array[Double]) {
    key.zipWithIndex.foreach { case (v, i) => pokeFixedPoint(c.io.x(i), v) }
    step(1)

    println(f"hash of (${key.mkString(",")}) is ${peekFixedPoint(c.io.out)}%20.10f scala says ${hashMaker(key)}%20.10f")
  }

  oneTest(Array.fill(c.keySize)(0.0))
  oneTest(Array.fill(c.keySize)(0.5))
  oneTest(Array.fill(c.keySize)(1.0))

}

class HashFunctionSpec extends FreeSpec with Matchers {
  Random.setSeed(0L)

  def weightGenerator(rows: Int, cols: Int, makeDouble: () => Double): Array[Array[Double]] = {
    Array.fill(rows, cols)(makeDouble())
  }

  def runTest(
               w: Double,
               b: Double,
               keySize: Int,
               hashDepth: Int,
               fixedWidth: Int,
               binaryPoint: Int,
               weightMaker: () => Double
             ): Boolean = {
    val weights = weightGenerator(hashDepth, keySize, weightMaker )

    iotesters.Driver.execute(
      Array.empty[String],
      () => new HardwareHashMaker(FixedPoint(fixedWidth.W, binaryPoint.BP), keySize, hashDepth, w, b, weights)
    ) { c =>
      new HashFunctionTester(c)
    }
  }

  "Trivial example" in {
    runTest(
      w = 1.0, b = 0.0,
      keySize = 1, hashDepth = 1,
      fixedWidth = 16, binaryPoint = 8,
      () => 0.125
    ) should be (true)
  }

  "A slightly bigger example" in {
    runTest(
      w = 1.0, b = 0.0,
      keySize = 4, hashDepth = 5,
      fixedWidth = 16, binaryPoint = 8,
      () => 0.125
    ) should be (true)
  }

  "Foutse's example 4.0, 6.2, 4, 5 (w changed to be power of 2)" in {
    runTest(
      w = 4.0, b = 0.0,
      keySize = 4, hashDepth = 5,
      fixedWidth = 64, binaryPoint = 32,
      Random.nextGaussian _
//      () => 0.125
    ) should be (true)
  }
}






