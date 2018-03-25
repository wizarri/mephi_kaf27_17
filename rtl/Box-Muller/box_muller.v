 module box_muller
#(
	parameter 	OUT = 32, // Разрядность выходных данных 32 или 48
			  	FILE_SQRT = "sqrt.txt", //Файл со значениями корня 
			  	FILE_SIN  = "sin.txt", //Файл со значениями синуса
			  	FILE_COS  = "cos.txt", //Файл со значениями косинуса
			  	A_SQRT = 24, //Разрядность адреса к Square root and Logarithm Unit
			  	D_SQRT = 24, //Разрядность данных из Square root and Logarithm Unit
			  	A_CSIN = 16, //Разрядность адреса к Sin/Cos Unit (учитывается знаковый бит)
			  	D_CSIN = 16, //Разрядность данных к Sin/Cos Unit
			  	//Задавамые параметры для 1-ого генератора Tausworthe
			  	SEED1_1      = 32'hE761B9DB,
           	  	CONST1_1     = 32'hfffffffe,
              	SEED2_1      = 32'hB4B4D15C,
              	CONST2_1     = 32'hfffffff8,
           		SEED3_1      = 32'hC0B4DD55,
          		CONST3_1     = 32'hfffffff0,
           		//Задавамые параметры для 2-ого генератора Tausworthe (желательно поменять)
			 	SEED1_2      = 32'hE761B9DB,
           		CONST1_2     = 32'hfffffffe,
           		SEED2_2      = 32'hB4B4D15C,
           		CONST2_2     = 32'hfffffff8,
           		SEED3_2      = 32'hC0B4DD55,
           		CONST3_2     = 32'hfffffff0

)
(
	input clk, rst,
	output [OUT-1:0] out1, out2 //out1 - умножение на син, out2 - на косин
);

//Промежуточные сигналы
	wire [31:0] a, b; //Выходные значения из генераторов Tausworthe
	//wire [A_SQRT-1:0] u1;   //к Square root and Logarithm Unit
	//wire [A_CSIN:0] u2;   //к Sin/Cos 
	wire out_val_s1, out_val_s2;    //Сигналы с промежуточных регистров в 
	wire out_val_lr1, out_val_lr2;  //генераторе Tausworthe 
	wire re_s, re_lr;          //Сигналы разрешения чтения
	wire [A_SQRT-1:0] adr_sqrt; //Адрес к Square root and Logarithm Unit
	wire [D_SQRT-1:0] data_sqrt;    //Данные из Square root and Logarithm Unit
	wire [A_CSIN:0] adr_csin; //Адрес к Sin/Cos Unit
	wire [D_CSIN-1:0] data_sin, data_cos; //Данные из Sin/Cos Unit
	//wire [D_SQRT-1:0] mn1_sin, mn1_cos;   //Множители при умножении на синус и 
	//wire [D_CSIN-1:0] mn2_sin, mn2_cos;   //косинус 

//Подключение генераторов Tausworthe
	tausworthe
	#(
		.SEED1(SEED1_1), .CONST1(CONST1_1), .SEED2(SEED2_1), .CONST2(CONST2_1),
		.SEED3(SEED3_1), .CONST3(CONST3_1)
	)
	number1
	(
		.clk(clk),
    	.rst(rst),
    	.generator_out(a),
    	.out_val_s(out_val_s1), 
    	.out_val_lr(out_val_lr1)
	);

	tausworthe
	#(
		.SEED1(SEED1_2), .CONST1(CONST1_2), .SEED2(SEED2_2), .CONST2(CONST2_2),
		.SEED3(SEED3_2), .CONST3(CONST3_2)
	)
	number2
	(
		.clk(clk),
    	.rst(rst),
    	.generator_out(b),
    	.out_val_s(out_val_s2), 
    	.out_val_lr(out_val_lr2)
	);

//Разделение сигналов
	assign adr_sqrt = a[A_SQRT-1:0]; 
	assign adr_csin = b[A_CSIN:0];

//Подключение блоков памяти 
    //Square root and Logarithm Unit 
	sqrt_rom 
	#(
		.A_WIDTH(A_SQRT), .D_WIDTH(D_SQRT), .FILE(FILE_SQRT)
	)
	sqrt_unit
	(
		.clk(clk),
		.adress(adr_sqrt),
		.data(data_sqrt),
		.re_lr(out_val_lr1),
		.re_s(out_val_s1)
	);

    //Sin Unit
	csin_rom 
	#(
		.A_WIDTH(A_CSIN), .D_WIDTH(D_CSIN), .FILE(FILE_SIN)
	)
	sin_unit
	(
		.clk(clk),
		.adress(adr_csin),
		.data(data_sin),
		.re_lr(out_val_lr2),
		.re_s(out_val_s2)
	);

	//Cos Unit
	csin_rom 
	#(
		.A_WIDTH(A_CSIN), .D_WIDTH(A_CSIN), .FILE(FILE_COS)
	)
	cos_unit
	(
		.clk(clk),
		.adress(adr_csin),
		.data(data_cos),
		.re_lr(out_val_lr2),
		.re_s(out_val_s2)
	);

//Подключение умножителей
	//Умножение на sin
	mult
	#(
		.N1(D_SQRT), .N2(D_CSIN), .N_RES(OUT) 
	)
	mult_sin
	(
		.clk(clk),
		.mn1(data_sqrt),
		.mn2(data_sin),
		.result(out1)
	);

	//Умножение на cos
	mult
	#(
		.N1(D_SQRT), .N2(D_CSIN), .N_RES(OUT) 
	)
	mult_cos
	(
		.clk(clk),
		.mn1(data_sqrt),
		.mn2(data_cos),
		.result(out2)
	);

endmodule // box_muller