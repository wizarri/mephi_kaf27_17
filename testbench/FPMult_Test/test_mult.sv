`timescale 1ns / 1ps

module test_mult;

	//Inputs
	reg [47:0] mn1;
	reg [15:0] mn2;

	// Outputs
	wire [31:0] result;  //ИЗМЕНИТЬ
	wire ovr;
	
	// Instantiate the Unit Under Test (UUT)
	mult  uut (
		.mn1(mn1), 
		.mn2(mn2), 
		.result(result),
		.ovr(ovr)
	);

	initial begin
 		mn1 = 48'b100001001111101101110000110100001111111000100100;	
		mn2 = 16'b0011010111011010;    
		#23
		mn1 = 48'b100001001111101101110000110100001111111000100100;	
		mn2 = 16'b1011010111011010;    
		#23
		$finish;
	end

endmodule