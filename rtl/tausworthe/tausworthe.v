`timescale 1ns / 1ps

module tausworthe
(
  input clk, rst,
  output [31:0] generator_out,
  output out_val_s, out_val_lr
);
  wire [31:0] out1, out2, out3;
  wire out_valid_s1, out_valid_s2, out_valid_s3;
  wire out_valid_lr1, out_valid_lr2, out_valid_lr3;
  tausworthe_part
  #(
  	.SEED(32'hE761B9DB), .CONST(32'hfffffffe), 
  	.SHIFT_L1(8'd13), .SHIFT_L2(8'd12), .SHIFT_R(8'd19)
  )
  part_1
  (
    .clk(clk),
    .rst(rst),
    .out(out1),
    .out_valid_s(out_valid_s1),
    .out_valid_lr(out_valid_lr1)	 
  );

  tausworthe_part 
  #(
  	.SEED(32'hB4B4D15C), .CONST(32'hfffffff8), 
  	.SHIFT_L1(4'd2), .SHIFT_L2(4'd4), .SHIFT_R(8'd25)
  )
  part_2
  (
    .clk(clk),
    .rst(rst),
    .out(out2),
    .out_valid_s(out_valid_s2),
    .out_valid_lr(out_valid_lr2) 
  );

  tausworthe_part 
  #(
  	.SEED(32'hC0B4DD55), .CONST(32'hfffffff0), 
  	.SHIFT_L1(4'd3), .SHIFT_L2(8'd17), .SHIFT_R(8'd11)
  )
  part_3
  (
    .clk(clk),
    .rst(rst),
    .out(out3),
    .out_valid_s(out_valid_s3),
    .out_valid_lr(out_valid_lr3) 
  );

  assign generator_out = out1 ^ out2 ^ out3;
  assign out_val_s     = out_valid_s1 & out_valid_s2 & out_valid_s3;
  assign out_val_lr    = out_valid_lr1 & out_valid_lr2 & out_valid_lr3;

endmodule // tausworthe