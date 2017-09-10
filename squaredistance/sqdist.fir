;buildInfoPackage: chisel3, version: 3.0-SNAPSHOT, scalaVersion: 2.11.11, sbtVersion: 0.13.15, builtAtString: 2017-08-25 22:51:12.887, builtAtMillis: 1503701472887
circuit sqdist : 
  module sqdist : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip in1 : Fixed<64><<32>>[5], flip in2 : Fixed<64><<32>>[5], out : Fixed<64><<32>>}
    
    clock is invalid
    reset is invalid
    io is invalid
    node _T_20 = sub(io.in2[0], io.in1[0]) @[sqdist.scala 20:60]
    node _T_21 = tail(_T_20, 1) @[sqdist.scala 20:60]
    node _T_22 = asFixedPoint(_T_21, 32) @[sqdist.scala 20:60]
    node _T_23 = sub(io.in2[0], io.in1[0]) @[sqdist.scala 20:66]
    node _T_24 = tail(_T_23, 1) @[sqdist.scala 20:66]
    node _T_25 = asFixedPoint(_T_24, 32) @[sqdist.scala 20:66]
    node _T_26 = mul(_T_22, _T_25) @[sqdist.scala 20:63]
    node _T_27 = sub(io.in2[1], io.in1[1]) @[sqdist.scala 20:60]
    node _T_28 = tail(_T_27, 1) @[sqdist.scala 20:60]
    node _T_29 = asFixedPoint(_T_28, 32) @[sqdist.scala 20:60]
    node _T_30 = sub(io.in2[1], io.in1[1]) @[sqdist.scala 20:66]
    node _T_31 = tail(_T_30, 1) @[sqdist.scala 20:66]
    node _T_32 = asFixedPoint(_T_31, 32) @[sqdist.scala 20:66]
    node _T_33 = mul(_T_29, _T_32) @[sqdist.scala 20:63]
    node _T_34 = sub(io.in2[2], io.in1[2]) @[sqdist.scala 20:60]
    node _T_35 = tail(_T_34, 1) @[sqdist.scala 20:60]
    node _T_36 = asFixedPoint(_T_35, 32) @[sqdist.scala 20:60]
    node _T_37 = sub(io.in2[2], io.in1[2]) @[sqdist.scala 20:66]
    node _T_38 = tail(_T_37, 1) @[sqdist.scala 20:66]
    node _T_39 = asFixedPoint(_T_38, 32) @[sqdist.scala 20:66]
    node _T_40 = mul(_T_36, _T_39) @[sqdist.scala 20:63]
    node _T_41 = sub(io.in2[3], io.in1[3]) @[sqdist.scala 20:60]
    node _T_42 = tail(_T_41, 1) @[sqdist.scala 20:60]
    node _T_43 = asFixedPoint(_T_42, 32) @[sqdist.scala 20:60]
    node _T_44 = sub(io.in2[3], io.in1[3]) @[sqdist.scala 20:66]
    node _T_45 = tail(_T_44, 1) @[sqdist.scala 20:66]
    node _T_46 = asFixedPoint(_T_45, 32) @[sqdist.scala 20:66]
    node _T_47 = mul(_T_43, _T_46) @[sqdist.scala 20:63]
    node _T_48 = sub(io.in2[4], io.in1[4]) @[sqdist.scala 20:60]
    node _T_49 = tail(_T_48, 1) @[sqdist.scala 20:60]
    node _T_50 = asFixedPoint(_T_49, 32) @[sqdist.scala 20:60]
    node _T_51 = sub(io.in2[4], io.in1[4]) @[sqdist.scala 20:66]
    node _T_52 = tail(_T_51, 1) @[sqdist.scala 20:66]
    node _T_53 = asFixedPoint(_T_52, 32) @[sqdist.scala 20:66]
    node _T_54 = mul(_T_50, _T_53) @[sqdist.scala 20:63]
    node _T_55 = add(_T_26, _T_33) @[sqdist.scala 21:34]
    node _T_56 = tail(_T_55, 1) @[sqdist.scala 21:34]
    node _T_57 = asFixedPoint(_T_56, 64) @[sqdist.scala 21:34]
    node _T_58 = add(_T_57, _T_40) @[sqdist.scala 21:34]
    node _T_59 = tail(_T_58, 1) @[sqdist.scala 21:34]
    node _T_60 = asFixedPoint(_T_59, 64) @[sqdist.scala 21:34]
    node _T_61 = add(_T_60, _T_47) @[sqdist.scala 21:34]
    node _T_62 = tail(_T_61, 1) @[sqdist.scala 21:34]
    node _T_63 = asFixedPoint(_T_62, 64) @[sqdist.scala 21:34]
    node _T_64 = add(_T_63, _T_54) @[sqdist.scala 21:34]
    node _T_65 = tail(_T_64, 1) @[sqdist.scala 21:34]
    node _T_66 = asFixedPoint(_T_65, 64) @[sqdist.scala 21:34]
    io.out <= _T_66 @[sqdist.scala 34:16]
    
