`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif

module sqdist(
  input         clock,
  input         reset,
  input  [63:0] io_in1_0,
  input  [63:0] io_in1_1,
  input  [63:0] io_in1_2,
  input  [63:0] io_in1_3,
  input  [63:0] io_in1_4,
  input  [63:0] io_in2_0,
  input  [63:0] io_in2_1,
  input  [63:0] io_in2_2,
  input  [63:0] io_in2_3,
  input  [63:0] io_in2_4,
  output [63:0] io_out
);
  wire [64:0] _T_20;
  wire [63:0] _T_21;
  wire [63:0] _T_22;
  wire [127:0] _T_26;
  wire [64:0] _T_27;
  wire [63:0] _T_28;
  wire [63:0] _T_29;
  wire [127:0] _T_33;
  wire [64:0] _T_34;
  wire [63:0] _T_35;
  wire [63:0] _T_36;
  wire [127:0] _T_40;
  wire [64:0] _T_41;
  wire [63:0] _T_42;
  wire [63:0] _T_43;
  wire [127:0] _T_47;
  wire [64:0] _T_48;
  wire [63:0] _T_49;
  wire [63:0] _T_50;
  wire [127:0] _T_54;
  wire [128:0] _T_55;
  wire [127:0] _T_56;
  wire [127:0] _T_57;
  wire [128:0] _T_58;
  wire [127:0] _T_59;
  wire [127:0] _T_60;
  wire [128:0] _T_61;
  wire [127:0] _T_62;
  wire [127:0] _T_63;
  wire [128:0] _T_64;
  wire [127:0] _T_65;
  wire [127:0] _T_66;
  wire [95:0] _GEN_0;
  wire [63:0] _GEN_1;
  assign io_out = $signed(_GEN_1);
  assign _T_20 = $signed(io_in2_0) - $signed(io_in1_0);
  assign _T_21 = _T_20[63:0];
  assign _T_22 = $signed(_T_21);
  assign _T_26 = $signed(_T_22) * $signed(_T_22);
  assign _T_27 = $signed(io_in2_1) - $signed(io_in1_1);
  assign _T_28 = _T_27[63:0];
  assign _T_29 = $signed(_T_28);
  assign _T_33 = $signed(_T_29) * $signed(_T_29);
  assign _T_34 = $signed(io_in2_2) - $signed(io_in1_2);
  assign _T_35 = _T_34[63:0];
  assign _T_36 = $signed(_T_35);
  assign _T_40 = $signed(_T_36) * $signed(_T_36);
  assign _T_41 = $signed(io_in2_3) - $signed(io_in1_3);
  assign _T_42 = _T_41[63:0];
  assign _T_43 = $signed(_T_42);
  assign _T_47 = $signed(_T_43) * $signed(_T_43);
  assign _T_48 = $signed(io_in2_4) - $signed(io_in1_4);
  assign _T_49 = _T_48[63:0];
  assign _T_50 = $signed(_T_49);
  assign _T_54 = $signed(_T_50) * $signed(_T_50);
  assign _T_55 = $signed(_T_26) + $signed(_T_33);
  assign _T_56 = _T_55[127:0];
  assign _T_57 = $signed(_T_56);
  assign _T_58 = $signed(_T_57) + $signed(_T_40);
  assign _T_59 = _T_58[127:0];
  assign _T_60 = $signed(_T_59);
  assign _T_61 = $signed(_T_60) + $signed(_T_47);
  assign _T_62 = _T_61[127:0];
  assign _T_63 = $signed(_T_62);
  assign _T_64 = $signed(_T_63) + $signed(_T_54);
  assign _T_65 = _T_64[127:0];
  assign _T_66 = $signed(_T_65);
  assign _GEN_0 = _T_66[127:32];
  assign _GEN_1 = _GEN_0[63:0];
endmodule
