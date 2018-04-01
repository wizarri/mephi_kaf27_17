module sborka
#(
	parameter SEED1  = 32'hE761B9DB, //Задаваемые 
              CONST1 = 32'hfffffffe, //значения
              SEED2  = 32'hB4B4D15C, //для
              CONST2 = 32'hfffffff8, //Tausworthe
              SEED3  = 32'hC0B4DD55,
              CONST3 = 32'hfffffff0,
              //---------SQRT UNIT-----------------------
              A_SQRT    = 24, //Разрядность адреса
              D_SQRT    = 24, //Разрядность данных
              FILE_SQRT = "sqrt.txt", //Файл со значениями (в данном
              							//случае 3 старших бита - целая часть
              //------COS and SIN UNIT------------------
              A_CSIN   = 16, //Разрядность адреса
              D_CSIN   = 16, //Разрядность данных
              FILE_COS = "cos.txt", //Файлы со значениями (в данном
              FILE_SIN = "sin.txt",  //случае старший бит - знак числа)
              //------------MULT-----------------------
              N1    = 24, //Разрядность 1 числа (sqrt)
              N2    = 16, //Разрядность 2 числа (sin or cos)
              N_RES = 32  //Разрядность выходного значения (sqrt * sin or cos)
)
(
	input clk, rst,
	output [D_SQRT-1:0] data_sqrt, //Выходные значения из SQRT UNIT
	output [D_CSIN-1:0] data_cos, data_sin, //Выходные значения из COS and SIN UNIT
	output [N_RES-1:0] out_cos, out_sin //Выходные значения
);

	wire [31:0] generator_out;

//-----------------------Tauswothe URNG-------------------
	tausworthe #(.SEED1(SEED1), .CONST1(CONST1), .SEED2(SEED2), 
		.CONST2(CONST2), .SEED3(SEED3), .CONST3(CONST3))

	tausworthe1
	(
		.clk(clk),
		.rst(rst),
		.generator_out(generator_out),
		.out_val_s(out_val_s),
		.out_val_lr(out_val_lr)
	);

//-------------------------SQRT UNIT---------------------
	sqrt_rom #(.A_WIDTH(A_SQRT), .D_WIDTH(D_SQRT), .FILE(FILE_SQRT))

	sqrt_unit
	(
		.clk(clk),
		.adress(generator_out[A_SQRT-1:0]),
		.data(data_sqrt),
		.re_s(out_val_s)
	);

//-------------------------COS UNIT-----------------------
	cos_mem #(.A_WIDTH(A_CSIN), .D_WIDTH(D_CSIN), .FILE(FILE_COS))

	cos_unit
	(
		.clk(clk),
		.adress(generator_out[A_CSIN-1:0]),
		.data(data_cos),
		.re_s(out_val_s)
	);

//-------------------------SIN UNIT-----------------------
	sin_mem #(.A_WIDTH(A_CSIN), .D_WIDTH(D_CSIN), .FILE(FILE_SIN))

	sin_unit
	(
		.clk(clk),
		.adress(generator_out[A_CSIN:0]),
		.data(data_sin),
		.re_s(out_val_s)
	);

//-------------------------MULT COS-----------------------
	mult #(.N1(N1), .N2(N2), .N_RES(N_RES))

	mult_cos
	(
		.clk(clk),
		.mn1(data_sqrt),
		.mn2(data_cos),
		.result(out_cos)
	);

//-------------------------MULT SIN-----------------------
	mult #(.N1(N1), .N2(N2), .N_RES(N_RES))

	mult_sin
	(
		.clk(clk),
		.mn1(data_sqrt),
		.mn2(data_sin),
		.result(out_sin)
	);

endmodule