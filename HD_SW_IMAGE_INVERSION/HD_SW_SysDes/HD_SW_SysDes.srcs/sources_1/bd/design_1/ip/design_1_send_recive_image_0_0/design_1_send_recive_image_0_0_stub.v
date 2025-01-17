// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Fri Jan 17 09:18:06 2025
// Host        : Atef running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Xilinx/Projects/HD_SW_SysDes/HD_SW_SysDes.srcs/sources_1/bd/design_1/ip/design_1_send_recive_image_0_0/design_1_send_recive_image_0_0_stub.v
// Design      : design_1_send_recive_image_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "send_recive_image,Vivado 2018.2" *)
module design_1_send_recive_image_0_0(axi_clk, axi_reset_n, s_axis_valid, 
  s_axis_data, s_axis_ready, m_axis_ready, m_axis_valid, m_axis_data)
/* synthesis syn_black_box black_box_pad_pin="axi_clk,axi_reset_n,s_axis_valid,s_axis_data[31:0],s_axis_ready,m_axis_ready,m_axis_valid,m_axis_data[31:0]" */;
  input axi_clk;
  input axi_reset_n;
  input s_axis_valid;
  input [31:0]s_axis_data;
  output s_axis_ready;
  input m_axis_ready;
  output m_axis_valid;
  output [31:0]m_axis_data;
endmodule
