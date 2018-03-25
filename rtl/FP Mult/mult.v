`timescale 1ns / 1ps

module mult 
#(
	parameter N1 = 24, 	//Разрядность 1 числа
	parameter N2 = 16,    //Разрядность 2 числа
	parameter N_RES = 32  //Разрядность выходного значения 
)
(
	input clk,
	input	 [N1-1:0]	mn1, 
	input	 [N2-1:0]	mn2,
	output [N_RES-1:0]	result
);

	localparam PODGON = N1+N2-3;    //Поменять, но не понятно почему
	
	reg [(N1+N2)-1:0]	mult_res;	//Результат умножения
	reg [N_RES-1:0]	result_r;      //Приведенный к N_RES разрядности результат
	
	assign result = result_r;	

	always @(posedge clk)	begin						
		mult_res = mn1[N1-1:0] * mn2[N2-2:0];   //Умножение 2х чисел (без знаковых битов)												
		result_r[N_RES-1] = mn2[N2-1];	          //Получение знакового бита
		result_r[N_RES-2:0] = mult_res[PODGON:PODGON-N_RES+2];
	end

endmodule
