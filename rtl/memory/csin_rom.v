`timescale 1ns / 1ps
module csin_rom
#(
	parameter A_WIDTH   = 16,           //Разрядность адреса
			  D_WIDTH   = 16,           //Разрядность данных
			  FILE      = "cos.txt"  // memory.txt - файл с содержимым
) 

(
	input  clk,
	input  [A_WIDTH:0] adress, // Адресный вход
	output [D_WIDTH-1:0] data, // Выход данных
	input  re_s // Разрешение чтения
);

	reg [D_WIDTH-1:0] mem [0:(2**A_WIDTH)-1] ;
	reg [D_WIDTH-1:0] data_r;
	reg sign_bit;
	wire s_bit;

	initial begin 
		$readmemb(FILE, mem); //Подключение файла со значениями
	end

	always @(posedge clk) begin
		if (re_s == 1)
			data_r <= mem[adress[A_WIDTH-1:0]];
	end
	
	always @(posedge clk) begin
		sign_bit <= adress[A_WIDTH];
	end

	assign s_bit = sign_bit ? ~data_r[D_WIDTH-1] : data_r[D_WIDTH-1];
	assign data = {s_bit, data_r[D_WIDTH-2:0]};

endmodule
