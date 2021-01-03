`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/29 18:09:36
// Design Name: 
// Module Name: hilo_distribute
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


module hilo_distribute(
    input  wire [31:0] in,
	input  wire  s,
	output wire [31:0] hi, lo
    );

	// 表达式为否结果置0通过了测试，现改为hi,lo
	assign hi = (s == 1'b1) ? in : hi;
	assign lo = (s == 1'b0) ? in : lo; 

endmodule
