`timescale 1ns / 1ps

module mult 
#(
	parameter N1 = 48, 	//Разрядность 1 числа
	parameter N2 = 16,    //Разрядность 2 числа
	parameter N_RES = 32  //Разрядность выходного значения 
)
(
	input	[N1-1:0]	mn1, 
	input	[N2-1:0]	mn2,
	output	[N_RES-1:0]	result,
	output ovr
);

	reg [(N1+N2)-1:0]	mult_res;	//Результат умножения
	reg [N_RES-1:0]	result_r;      //Приведенный к N_RES разрядности результат
	reg ovr_r;
	
	assign ovr = ovr_r;
	assign result = result_r;	

	always @*	begin						
		mult_res = mn1[N1-1:0] * mn2[N2-2:0];   //Умножение 2х чисел (без знаковых битов)												
		result_r[N_RES-1] = mn2[N2-1];	          //Получение знакового бита
		ovr_r = 1'b0;
		if (N_RES == 32) begin
			result_r[N_RES-2:0] = mult_res[(N1+N2)-4:30];  //Приведение полученного результата к 32-разрядам	
			if (mult_res[N1+N2-1:N1+N2-3] > 0)			//Есть переполнение							
				ovr_r = 1'b1;
		end
		else if (N_RES == 48) begin
			result_r[N_RES-2:0] = mult_res[(N1+N2)-3:15];	//Приведение полученного результата к 48-разрядам	
			if (mult_res[N1+N2-1:N1+N2-2] > 0)			      //Есть переполнение							
				ovr_r = 1'b1;
		end
	end

endmodule
