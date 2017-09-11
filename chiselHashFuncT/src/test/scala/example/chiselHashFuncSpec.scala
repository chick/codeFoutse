// See LICENSE for license details.

package example

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.iotesters
import org.scalatest.{FreeSpec, Matchers}

import scala.util.Random

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
