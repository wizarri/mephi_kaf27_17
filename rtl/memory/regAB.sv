`timescale 1ns / 1ps
module rom_AxB
	
	#(parameter A=32, width=4, depth=16 )
	(
	input clk,
	output [A-1:0] data
	);

	reg [width-1:0] memory [0:depth-1];
	integer i;

	function [width-1:0] fx;
		input [depth-1:0] mem;	
		  begin
			fx = 0; 
			for (i = 0; i<depth ; i=i+1)
				fx[i] = i; 	
		end
	endfunction 
	
	initial begin
		for (i = 0; 0 < depth; i=i+1) 
			begin
				memory[i] = fx[i]; 
			end
	end
endmodule