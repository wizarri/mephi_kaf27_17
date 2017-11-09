`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:40:13 11/09/2017
// Design Name:   tausworthe
// Module Name:   C:/Xilinx/Xilinx_pojects/tausworthe_generator/test_tausworthe.v
// Project Name:  tausworthe_generator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: tausworthe
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_tausworthe;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] generator_out;

	// Instantiate the Unit Under Test (UUT)
	tausworthe uut (
		.clk(clk), 
		.rst(rst),
      .out_val_s(out_val_s),
      .out_val_lr(out_val_lr),		
		.generator_out(generator_out)
	);

	initial begin
   clk = 0;
    forever begin
    	#10 clk = ~clk;
    end
  end

  initial begin
    rst = 0;
    #2;
    rst = 1;
    #3;
    rst = 0;
    #1000;
    $finish; 
  end

endmodule

