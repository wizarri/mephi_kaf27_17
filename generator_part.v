module generator_part 
#(
  parameter SEED     = 32'hFFFFFFFF,
  parameter CONST    = 32'hFFFFFFFF,
  parameter SHIFT_L1 = 4'hB,
  parameter SHIFT_L2 = 4'hB,
  parameter SHIFT_R  = 4'hB
)

(
  input clk, rst,
  output [31:0] out
);

  reg [31:0] reg_s, reg_l, reg_r;
  wire [31:0] wire_s, wire_l, wire_r, shift_l1, bit_and, xor1, shift_r, shift_l2, xor2;
  
  always @(posedge clk or posedge rst) 
    begin
  	  if (rst) begin
  		  reg_s <= SEED;
		  reg_l <= 32'h0;
		  reg_r <= 32'h0;
	  end  
  	  else begin
  		  reg_s <= xor2;
		  reg_l <= xor1;
		  reg_r <= bit_and;
  	  end
    end
	 
  assign wire_s   = reg_s;
  assign wire_r   = reg_r;
  assign wire_l   = reg_l; 
  assign shift_l1 = wire_s <<< SHIFT_L1;
  assign bit_and  = wire_s & CONST;
  assign xor1     = shift_l1 ^ wire_s;
  assign shift_r  = wire_r >>> SHIFT_R;
  assign shift_l2 = wire_l <<< SHIFT_L2;
  assign xor2     = shift_r ^ shift_l2;
  assign out      = xor2;
  
endmodule // generator_part  