`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/29 18:02:42
// Design Name: 
// Module Name: sign_extend_57inst
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


module sign_extend(
	input  wire [15:0] a,
	input  wire [1:0]  select,
	output wire [31:0] y
    );

	assign y = (select == 2'b11) ? {{16{1'b0}}, a} : {{16{a[15]}} , a};
														//1'b0

endmodule
