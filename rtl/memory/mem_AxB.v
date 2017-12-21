`timescale 1ns / 1ps

module rom_AxB 
#(parameter A=7, width=8, depth=18)

(
input [A:0] address,
output [A:0] data,
input read_one,
input read_two
//input ce 
);       
reg [width-1:0] mem [0:depth-1] ;  
      
assign data = (read_one && read_two) ? mem[address] : 8'b0;

initial begin
  $readmemb("mem.txt", mem); // memory_list is memory file
end

endmodule