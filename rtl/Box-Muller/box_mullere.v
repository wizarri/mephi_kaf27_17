module box_muller
(
	input clk, rst,
	output [31:0] out1, out2,
	output ovr1, ovr2
);
	
//Подключение генераторов Tausworthe
	tausworthe number1 
	(
	.clk(clk),
    .rst(rst),
    .generator_out(a),
    .out_val_s(out_val_s1), 
    .out_val_lr(out_val_lr1)
	);

	tausworthe number2 
	(
	.clk(clk),
    .rst(rst),
    .generator_out(b),
    .out_val_s(out_val_s2), 
    .out_val_lr(out_val_lr2)
	);

//Промежуточные сигналы
	wire [31:0] a, b; //Выходные значения из генераторов Tausworthe
	wire [47:0] u1;   //к Square root and Logarithm Unit
	wire [15:0] u2;   //к Sin/Cos 
	wire out_val_s1, out_val_s2;    //Сигналы 
	wire out_val_lr1, out_val_lr2;
	wire re_sqrt, re_csin;
	wire [47:0] address_sqrt, data_sqrt; 
	wire [15:0] address_csin, data_csin;
	wire [47:0] mn1_sin, mn1_cos;
	wire [15:0] mn2_sin, mn2_cos;
	wire [31:0] result_sin, result_cos;
	wire ovr_sin, ovr_cos;

//Разделение сигналов
	assign u1 = {a, b[31:16]}; //Конкатенация
	assign u2 = b[15:0];

//Подключение блоков памяти 
    //Square root and Logarithm Unit 
	memory_rom 
	#(
		.A_WIDTH(48), .D_WIDTH(48), .MEM_DEPTH(/*глубина памяти*/)
	)
	sqrt_ln_unit
	(
		.address(address_sqrt),
		.data(data_sqrt),
		.re(re_sqrt)
	);

    //Sin/Cos Unit
	memory_rom 
	#(
		.A_WIDTH(16), .D_WIDTH(16), .MEM_DEPTH(/*глубина памяти*/)
	)
	sin_cos_unit
	(
		.address(address_csin),
		.data(data_csin),
		.re(re_csin)
	);

//Реализация чтения из файла
	assign address_sqrt = u1;
	assign address_csin = u2;
	assign re_sqrt      = out_val_s1 || out_val_lr1; //Момент спорный
	assign re_csin      = out_val_s2 || out_val_lr2;

//Подключение умножителей
	//Умножение на sin
	mult
	#(
		.N1(48), .N2(16), .N_RES(32) 
	)
	mult_sin
	(
		.mn1(mn1_sin),
		.mn2(mn2_sin),
		.result(result_sin),
		.ovr(ovr_sin)
	);

	//Умножение на cos
	mult
	#(
		.N1(48), .N2(16), .N_RES(32) 
	)
	mult_cos
	(
		.mn1(mn1_cos),
		.mn2(mn2_cos),
		.result(result_cos),
		.ovr(ovr_cos)
	);

//Объявление выходов
	assign out1 = result_sin;
	assign out2 = result_cos;
	assign ovr1 = ovr_sin;
	assign ovr2 = ovr_cos;

endmodule // box_muller