module tausworthe_mod
(
  input         clk,
                rst,

  output [31:0] generator_out
);

  wire [31:0] out1, out2, out3;

  tausworthe
  #(
    .SEED(32'hffffffff), .CONST(32'hfffffffe), 
    .SHIFT_L1(8'd13), .SHIFT_L2(8'd12), .SHIFT_R(8'd19)
  )
  part_1
  (
    .clk(clk),
    .rst(rst),
    .out(out1) 
  );

  tausworthe 
  #(
    .SEED(32'hcccccccc), .CONST(32'hfffffff8), 
    .SHIFT_L1(4'd2), .SHIFT_L2(4'd4), .SHIFT_R(8'd25)
  )
  part_2
  (
    .clk(clk),
    .rst(rst),
    .out(out2) 
  );

  tausworthe 
  #(
    .SEED(32'h00ff00ff), .CONST(32'hfffffff0), 
    .SHIFT_L1(4'd3), .SHIFT_L2(8'd17), .SHIFT_R(8'd11)
  )
  part_3
  (
    .clk(clk),
    .rst(rst),
    .out(out3) 
  );

  assign generator_out = out1 ^ out2 ^ out3;

endmodule // tausworthe