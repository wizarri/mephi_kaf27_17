module tausworthe
(
  input clk, rst,
  output [31:0] generator_out
);
  
  generator_part 
  #(
  	.SEED(3881941467), .CONST(3837055832), .SHIFT_L1(13), .SHIFT_L2(12), SHIFT_R(19)
  )
  part_1
  (
    .clk(clk),
    .rst(rst),
    .out(out1) 
  );

  generator_part 
  #(
  	.SEED(3031748956), .CONST(2226442581), .SHIFT_L1(2), .SHIFT_L2(4), SHIFT_R(25)
  )
  part_2
  (
    .clk(clk),
    .rst(rst),
    .out(out2) 
  );

  generator_part 
  #(
  	.SEED(3233078613), .CONST(2259992917), .SHIFT_L1(3), .SHIFT_L2(17), SHIFT_R(11)
  )
  part_3
  (
    .clk(clk),
    .rst(rst),
    .out(out3) 
  );

  assign generator_out = out1 ^ out2 ^ out3;

endmodule // tausworthe