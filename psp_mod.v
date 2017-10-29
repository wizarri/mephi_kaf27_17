module psp
#(
	parameter RESET_VALUE = 8'b10110100
)
(
	input clk, rst,
	output out
);
	 
	reg [7:0] d_reg;
	wire xor1, xor2, xor3;
	 
	always @(posedge clk, posedge rst)
	  begin
		  if (rst)
				d_reg <= RESET_VALUE;
			else 
				begin
				  d_reg[0] <= d_reg[7];
				  d_reg[1] <= d_reg[0];
				  d_reg[2] <= xor1;
				  d_reg[3] <= xor2;
				  d_reg[4] <= xor3;
				  d_reg[5] <= d_reg[4];
				  d_reg[6] <= d_reg[5];
				  d_reg[7] <= d_reg[6];
				end;
		end;
		  
  assign xor1 = d_reg[1] ^ d_reg[7];
  assign xor2 = d_reg[2] ^ d_reg[7];
  assign xor3 = d_reg[3] ^ d_reg[7];
  assign out  = d_reg[7];
	 
endmodule : psp