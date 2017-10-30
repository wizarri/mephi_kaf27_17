module generator_part 
#(
  parameter SEED     = 4294967295,
  parameter CONST    = 4294967295,
  parameter SHIFT_L1 = 4294967295,
  parameter SHIFT_L2 = 4294967295,
  parameter SHIFT_R  = 4294967295
)

(
  input clk, rst,
  output [31:0] out
);

  reg [31:0] reg_s;
  wire [31:0] wire_s, shift_l1, bit_and, xor1, shift_r, shift_l2, xor2;
  
  always @(posedge clk or posedge rst) 
    begin
  	  if (rst)
  		  reg_s <= SEED;
  	  else begin
  		  reg_s <= xor2;
  	  end
    end

  assign wire_s   = reg_s;
  assign shift_l1 = wire_s << SHIFT_L1;
  assign bit_and  = wire_s & CONST;
  assign xor1     = shift_l1 ^ wire_s;
  assign shift_r  = xor1 >> SHIFT_R;
  assign shift_l2 = bit_and << SHIFT_L2;
  assign xor2     = shift_r ^ shift_l2;
  assign out      = xor2;
  
endmodule // generator_part  