`timescale 1ns / 1ps

module test;

	// Inputs
	reg clk;
	reg rst;
	integer sinus, cosinus;
	 reg [53:0] i=0;
	// Outputs
	wire [23:0] data_sqrt;
	wire [15:0] data_cos;
	wire [15:0] data_sin;
	wire [31:0] out_cos, out_sin;
	wire i_k;
	// Instantiate the Unit Under Test (UUT)
	sborka uut (
		.clk(clk), 
		.rst(rst), 
		.data_sqrt(data_sqrt),
		.data_cos(data_cos),
		.data_sin(data_sin),
		.out_cos(out_cos),
		.out_sin(out_sin)
	);

	initial begin
		sinus = $fopen("out_sin.txt","w");
		cosinus = $fopen("out_cos.txt","w");
   end
	
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
    #30;
    rst = 0;
  end
  
  initial begin
	#130;
		while (i < 2921411) begin
		$fwrite(sinus,"%b\n",out_sin);
		$fwrite(cosinus,"%b\n",out_cos);
		i = i + 1;
		#40;
		end
		$fclose(sinus);
		$fclose(cosinus);
	end
  
endmodule

