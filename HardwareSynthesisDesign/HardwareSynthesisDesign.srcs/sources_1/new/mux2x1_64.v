`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/04 00:58:57
// Design Name: 
// Module Name: mux2x1_64
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2x1_64(
	input wire [63:0] a,
	input wire [63:0] b,
	input wire s,
	output wire [63:0] y
    );

	assign y = (s == 1)? a : b;
endmodule
