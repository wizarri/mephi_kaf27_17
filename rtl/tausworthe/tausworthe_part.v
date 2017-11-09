`timescale 1ns / 1ps

module tausworthe_part 
#(
  parameter SEED     = 32'hffffffff,
  parameter SHIFT_L1 = 8'd13,
  parameter SHIFT_L2 = 8'd12,
  parameter SHIFT_R  = 8'd19,
  parameter CONST    = 32'hfffffffe
)
(
  input clk, rst,
  output [31:0] out,
  output out_valid_s, out_valid_lr
);

  reg [31:0] reg_s, reg_l, reg_r;
  reg valid_s, valid_lr;
  wire [31:0] wire_s, wire_l, wire_r;

  always @(posedge clk or posedge rst)
    begin
	   if (rst) begin 
		  valid_s <= 1'b1;
		  valid_lr <= 1'b0;
		end
      else begin
        valid_s  <= valid_lr;
        valid_lr <= valid_s;
      end
    end

  always @(posedge clk or posedge rst)
    begin
	   if (rst) begin
		  reg_s <= SEED;
		end
		else if (valid_s == 1'b1) begin
		  reg_l <= wire_l;
		  reg_r <= wire_r;
		end
		else if (valid_lr == 1'b1) begin
		  reg_s <= wire_s;
		end
    end
	 
  assign wire_l = (reg_s << SHIFT_L1) ^ reg_s;
  assign wire_r = reg_s & CONST;
  assign wire_s = (reg_l >> SHIFT_R) ^ (reg_r << SHIFT_L2);
  assign out = wire_s;
  assign out_valid_s  = valid_s;
  assign out_valid_lr = valid_lr;
	 
endmodule //tausworthe_part