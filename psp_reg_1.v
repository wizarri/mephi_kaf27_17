`timescale 1ns / 1ps


module psp_reg_1
	#(parameter reset = 3'b100)
	(
	 input clk,
	 input rst,
	 output out
	);

	reg [2:0] d_reg; 
	wire res ; 

	always @(posedge clk, posedge rst) 
		begin
			if(rst)
				d_reg <= reset;
			else begin
				d_reg[1]<=d_reg[0];
				d_reg[2]<=d_reg[1];
				d_reg[0]<=res ;
			 end 	
		end
	

	assign res =  d_reg[2] ^ d_reg[0]^ d_reg[1] ;
	assign out = d_reg[2];
endmodule // psp_reg_1
