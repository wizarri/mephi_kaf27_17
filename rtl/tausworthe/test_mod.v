`timescale 1ns / 1ps

module test;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire out;
	
	// Instantiate the Unit Under Test (UUT)
	psp #( 
		.RESET_VALUE(8'b10101010)
		) 

  uut 
  (
		.clk(clk), 
		.rst(rst), 
		.out(out)
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
    #100;
    $finish; 
  end
    
endmodule : test