`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 01:10:40
// Design Name: 
// Module Name: mux4x1_forwardD
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


module mux4x1_forwardD(
	input wire [31:0] a,b,c,d,
	input wire [1:0] s,
	output wire [31:0] y
    );
	assign y = (s == 2'b00)? a:
			   (s == 2'b01)? b:
			   (s == 2'b10)? c:
			   				 d;
endmodule
