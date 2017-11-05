 
module reg31

(input [31:0] data,
input reset, clk,
output [31:0] out);
 
reg8 regA(out[7:0], data[7:0], reset, clk);

reg8 regB(.rst(reset), .clk(clk), .out(out[15:8]),   .in(data[15:8]));

reg8 regC(.rst(reset), .clk(clk), .out(out[23:16]), .in(data[23:16]));

reg8 regD(.rst(reset), .clk(clk), .out(out[31:24]), .in(data[31:24]));

endmodule

