`timescale 1ns / 1ps

module sqrt_rom 
#(
	parameter A_WIDTH   = 4,           //Разрядность адреса
			  D_WIDTH   = 48,           //Разрядность данных
			  FILE      = "memory.txt"  // memory.txt - файл с содержимым
)
(
	input  clk,
	input  [A_WIDTH-1:0] adress, // Адресный вход
	output [D_WIDTH-1:0] data, // Выход данных
	input  re_s // Разрешение чтения
);

	reg [D_WIDTH-1:0] mem [0:(2**A_WIDTH)-1] ;
	reg [D_WIDTH-1:0] data_r;

	initial begin 
		$readmemb(FILE, mem); //Подключение файла со значениями
	end

	always @(posedge clk) begin
		if (re_s == 1)
			data_r <= mem[adress];
	end
	
	assign data = data_r;

endmodule

