module delay_8x256 (
input clk, shift,
input [7:0] sr_in,
output [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out );
reg [7:0] sr [255:0];
integer n;
 	always@(posedge clk)
begin
if (shift == 1'b1)
begin
for (n = 255; n>0; n = n-1)
begin
sr[n] <= sr[n-1];
end
sr[0] <= sr_in; 
end
end
    // выходы входной последовательности sr_in
assign sr_tap_one = sr[4]; // с задержкой на 5 тактов
assign sr_tap_two = sr[9]; // с задержкой на 10 такта
assign sr_tap_three = sr[14]; // с задержкой на 15 тактов
assign sr_out = sr[19]; // с задержкой на 20 такта
    endmodule
