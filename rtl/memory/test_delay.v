module test; 
     	reg clk; 
 	reg shift; 
 	reg [7:0] sr_in; 
 	wire [7:0] sr_tap_one; 
 	wire [7:0] sr_tap_two; 
 	wire [7:0] sr_tap_three; 
 	wire [7:0] sr_out; 
// Instantiate the Unit Under Test (UUT) 
       delay_8x256 _mod uut
   	( 
       	.clk(clk), 
       	.shift(shift), 
 	.sr_in(sr_in), 
 	.sr_tap_one(sr_tap_one), 
 	.sr_tap_two(sr_tap_two), 
 	.sr_tap_three(sr_tap_three), 
 	.sr_out(sr_out) 
  	); 
 	initial begin 
 		sr_in = 8'b00001111; 
 		shift = 1'b1; 
 		#100 
 		clk = 0; 
 		forever begin 
 		#10 clk = ~clk; 
 		end 
 	end 
    endmodule
