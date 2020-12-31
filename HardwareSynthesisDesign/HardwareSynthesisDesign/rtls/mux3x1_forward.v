`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/21 22:05:06
// Design Name: 
// Module Name: mux3x1_forward
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


module mux3x1_forward(
	input wire [31:0] a,b,c,
	input wire [1:0] s,
	output wire [31:0] y
    );
	assign y = (s == 2'b00)? a:
			   (s == 2'b01)? b:
			   (s == 2'b10)? c:
			   32'b0;
endmodule
