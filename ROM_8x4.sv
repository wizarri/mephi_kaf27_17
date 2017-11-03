module reg8
#(parameter RESS = 8'b0)
	(	 
	output reg [7:0] out,
	input [7:0] in,
	input rst, clk
	);

	always @(posedge clk)
		if (rst) 
			out <= RESS;
		else begin 
			out <= in;
		end
endmodule
