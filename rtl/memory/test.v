`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:27:21 12/21/2017
// Design Name:   rom_AxB
// Module Name:   D:/ICEwebPack/XProjekt/ROM_1/test.v
// Project Name:  ROM_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rom_AxB
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg [7:0] address;
	reg read_one;
	reg read_two;

	// Outputs
	wire [7:0] data;
	integer i;
	// Instantiate the Unit Under Test (UUT)
	rom_AxB uut (
		.address(address), 
		.data(data), 
		.read_one(read_one),
		.read_two(read_two)
	);

	initial begin
		// Initialize Inputs
		address = 0;
		read_en = 0;
#10 $monitor ("address = %h, data = %h, read_en = %b, ce = %b", address, data, read_en, ce);
   for (i = 0; i <18; i = i +1 )begin
     #5 address = i;
     read_one = 1;
     read_two = 1;
     #5 read_one = 0;
     read_two = 0;
     address = 0;
   end
 end
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
      
endmodule

