`timescale 1ns / 1ps
module rom_AxB
	
	#(parameter A=32, width=16, depth=16, C=4'b0001 )
	(
	input clk,
	output [A-1:0] data
	);

	reg [width-1:0] memory [0:depth-1];
	integer i;

	initial begin 
		$readmemh ("mem.txt", memory);
	/*function [depth-1:0] fx;
		input mem;	
		 
		  begin
		//	mem = 4'b0
			for (i = 0; i<depth ; i=i+1)
				fx[i] = 4'b0 + C; 	
		end
	endfunction 
	
	initial begin
		for (i = 0; i < depth; i=i+1) 
			begin
				memory[i] = fx[i]; 
			end*/
	end
endmodule 