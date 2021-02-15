`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 15:06:13
// Design Name: 
// Module Name: mux2x1_32
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


module mux2x1_32(
	input wire [31:0] a,
	input wire [31:0] b,
	input wire s,
	output wire [31:0] y
    );

	assign y = (s == 1)? a : b;
endmodule
