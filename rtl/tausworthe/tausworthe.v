module tausworthe
(
  input clk, rst,
  output [31:0] generator_out
);
  
  generator_part 
  #(
  	.SEED(32'hE761B9DB), .CONST(32'hE4B4D358), .SHIFT_L1(4'hD), .SHIFT_L2(4'hC), .SHIFT_R(8'h13)
  )
  part_1
  (
    .clk(clk),
    .rst(rst),
    .out(out1) 
  );

  generator_part 
  #(
  	.SEED(32'hB4B4D15C), .CONST(32'h84B4D155), .SHIFT_L1(4'h2), .SHIFT_L2(4'h4), .SHIFT_R(8'h19)
  )
  part_2
  (
    .clk(clk),
    .rst(rst),
    .out(out2) 
  );

  generator_part 
  #(
  	.SEED(32'hC0B4DD55), .CONST(32'h86B4C155), .SHIFT_L1(4'h3), .SHIFT_L2(8'h11), .SHIFT_R(4'hB)
  )
  part_3
  (
    .clk(clk),
    .rst(rst),
    .out(out3) 
  );

  assign generator_out = out1 ^ out2 ^ out3;

endmodule // tausworthe