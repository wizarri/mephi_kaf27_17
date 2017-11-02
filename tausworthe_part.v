module tausworthe
#(
  parameter SEED     = 32'hffffffff,
  parameter SHIFT_L1 = 8'd13,
  parameter SHIFT_L2 = 8'd12,
  parameter SHIFT_R  = 8'd19,
  parameter CONST    = 32'hfffffffe
)
(
  input clk, rst, clk_lr,
  output [31:0] out
);

  reg [31:0] s_reg, l_reg, r_reg;
  wire [31:0] l_path, r_path, x_or;

  always @(posedge clk or posedge rst)
  if (rst)
  begin
    s_reg <= SEED;
    //l_reg <= 32'h00000000;
    //r_reg <= 32'h00000000;
  end
  else
  begin 
    s_reg <= x_or;
    //l_reg <= (s_reg << SHIFT_L1) ^ s_reg;
    //r_reg <= s_reg & CONST;
  end 
  
  always @(posedge clk_lr or posedge rst)
  if (rst)
  begin
    l_reg <= 32'h00000000;
    r_reg <= 32'h00000000;
  end
  else
  begin 
    l_reg <= (s_reg << SHIFT_L1) ^ s_reg;
    r_reg <= s_reg & CONST;
  end 

  assign l_path = l_reg >> SHIFT_R;
  assign r_path = r_reg << SHIFT_L2;
  assign x_or   = l_path ^ r_path;
 
  assign out = x_or;


endmodule