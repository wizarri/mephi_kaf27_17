`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:11:03 10/24/2017
// Design Name:   psp_reg_1
// Module Name:   D:/ICEwebPack/XProjekt/psp_reg_1/Tee.v
// Project Name:  psp_reg_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: psp_reg_1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Tee;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	psp_reg_1 uut (
		.clk(clk), 
		.rst(rst), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 1'b0;
		rst = 1'b1;
		#100;
		
		clk = 1'b1;
		rst = 1'b0;
		#100 
		
        
		clk = 1'b0;
		rst = 1'b0;
		#100;
 
		clk = 1'b1;
		rst = 1'b0;
		#100;
		
		clk = 1'b0;
		rst = 1'b0;
		#100;
		
		
		clk = 1'b1;
		rst = 1'b0;
		#100;
		
		
		clk = 1'b0;
		rst = 1'b0;
		#100;
		
		
		clk = 1'b1;
		rst = 1'b0;
		#100;
		
		clk = 1'b0;
		rst = 1'b0;
		#100;
	end
      
endmodule

