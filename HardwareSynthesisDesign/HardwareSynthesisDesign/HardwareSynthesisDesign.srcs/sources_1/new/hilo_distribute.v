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

	assign hi = (s == 1'b1) ? in : 32'b0;
	assign lo = (s == 1'b0) ? in : 32'b0; 

endmodule
