`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:16:57 11/05/2017
// Design Name:   tausworthe_mod
// Module Name:   C:/ISE PROJECTS/students2k17/tb.v
// Project Name:  students2k17
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: tausworthe_mod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

    // Inputs
    reg clk = 0;
    reg rst;

    // Outputs
    wire [31:0] generator_out, random_out;
    wire valid_out;

    // Instantiate the Unit Under Test (UUT)
    tausworthe_mod uut (
        .clk(clk), 
        .rst(rst), 
        .generator_out(generator_out)
    );

    tausworth test_taus
    (
        .clk(clk),
        .reset(rst),
        .random_out(random_out),
        .valid_out(valid_out) 
    );

    initial begin
        rst = 0;
        #5;
        rst = 1;
        #10;
        rst = 0;

    end


    initial begin 
        forever begin
        #5 clk = ~clk;
        end
    end

endmodule

