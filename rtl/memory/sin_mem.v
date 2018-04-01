module sin_mem
#(
	parameter A_WIDTH   = 16,           //Разрядность адреса
			  D_WIDTH   = 16,           //Разрядность данных
			  FILE      = "sin.txt"  // memory.txt - файл с содержимым
) 

(
	input  clk,
	input  [A_WIDTH:0] adress, // Адресный вход
	output [D_WIDTH-1:0] data, // Выход данных
	input re_s // Разрешение чтения
);

	reg [D_WIDTH-1:0] mem [0:(2**A_WIDTH)-1] ;
	reg [D_WIDTH-1:0] data_r;
	reg sign_bit, s_bit;
	
	initial begin 
		$readmemb(FILE, mem); //Подключение файла со значениями
	end

	always @(posedge clk) begin
		if (re_s == 1)
			data_r <= mem[adress[A_WIDTH-1:0]];
	end
	
	always @(posedge clk) begin
		s_bit <= adress[A_WIDTH];
		sign_bit <= s_bit;
	end
	
	assign data = {sign_bit, data_r[D_WIDTH-2:0]};
