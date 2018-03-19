 module box_muller
#(
	parameter OUT = 32, // Разрядность выходных данных 32 или 48
			  FILE_SQRT = , //Файл со значениями корня 
			  FILE_SIN  = , //Файл со значениями синуса
			  FILE_COS  = , //Файл со значениями косинуса
			  A_SQRT = 48, //Разрядность адреса к Square root and Logarithm Unit
			  D_SQRT = 48, //Разрядность данных из Square root and Logarithm Unit
			  A_CSIN = 16, //Разрядность адреса к Sin/Cos Unit
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
	output reg [OUT-1:0] out1, out2,
);

//Промежуточные сигналы
	wire [31:0] a, b; //Выходные значения из генераторов Tausworthe
	wire [47:0] u1;   //к Square root and Logarithm Unit
	wire [15:0] u2;   //к Sin/Cos 
	wire out_val_s1, out_val_s2;    //Сигналы с промежуточных регистров в 
	wire out_val_lr1, out_val_lr2;  //генераторе Tausworthe 
	wire re_sqrt, re_csin;          //Сигналы разрешения чтения
	wire [A_SQRT-1:0] address_sqrt; //Адрес к Square root and Logarithm Unit
	wire [D_SQRT-1:0] data_sqrt;    //Данные из Square root and Logarithm Unit
	wire [A_CSIN-1:0] address_csin; //Адрес к Sin/Cos Unit
	wire [D_CSIN-1:0] data_sin, data_cos; //Данные из Sin/Cos Unit
	wire [D_SQRT-1:0] mn1_sin, mn1_cos;   //Множители при умножении на синус и 
	wire [D_CSIN-1:0] mn2_sin, mn2_cos;   //косинус 

//Подключение генераторов Tausworthe
	tausworthe
	#(
		.SEED1(SEED1_1), .CONST1(CONST1_1), .SEED2(SEED2_1), CONST2(CONST2_1),
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
	assign u1 = {a, b[31:16]}; //Конкатенация
	assign u2 = b[15:0];

//Подключение блоков памяти 
    //Square root and Logarithm Unit 
	memory_rom 
	#(
		.A_WIDTH(A_SQRT), .D_WIDTH(D_SQRT), .FILE(FILE_SQRT)
	)
	sqrt_ln_unit
	(
		.clk(clk),
		.adress(address_sqrt),
		.data(data_sqrt),
		.re(re_sqrt)
	);

    //Sin Unit
	memory_rom 
	#(
		.A_WIDTH(A_CSIN), .D_WIDTH(D_CSIN), .FILE(FILE_SIN)
	)
	sin_unit
	(
		.clk(clk),
		.adress(address_csin),
		.data(data_sin),
		.re(re_csin)
	);

	//Cos Unit
	memory_rom 
	#(
		.A_WIDTH(A_CSIN), .D_WIDTH(A_CSIN), .FILE(FILE_COS)
	)
	cos_unit
	(
		.clk(clk),
		.adress(address_csin),
		.data(data_cos),
		.re(re_csin)
	);

//Реализация чтения из файла
	assign address_sqrt = u1;
	assign address_csin = u2;
	assign re_sqrt      = out_val_lr1; //Момент спорный
	assign re_csin      = out_val_lr2;

//Подключение умножителей
	//Умножение на sin
	mult
	#(
		.N1(D_SQRT), .N2(D_CSIN), .N_RES(OUT) 
	)
	mult_sin
	(
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
		.mn1(data_sqrt),
		.mn2(data_cos),
		.result(out2)
	);

endmodule // box_muller