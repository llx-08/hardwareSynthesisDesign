`timescale 1ns / 1ps
`include "defines2.vh"
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/29 23:42:44
// Design Name: 
// Module Name: eqcmp
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


module eqcmp(
	input  wire [31:0] a, b,
	input  wire [5:0]  op,
	input  wire [4:0]  rt,
	output wire y
    );
	
	assign y = (op == `EXE_BEQ) ? (a == b) :
	  	   	   (op == `EXE_BNE) ? (a != b) :
	  	   	   (op == `EXE_BGTZ) ? ((a[31] == 1'b0) && (a != `ZeroWord)) : // 大于0
	  	   	   (op == `EXE_BLEZ) ? ((a[31] == 1'b1) || (a == `ZeroWord)) : // 小于等于0
	  	   	   ((op == `EXE_REGIMM_INST) && ((rt == `EXE_BGEZ) || (rt == `EXE_BGEZAL))) ? 
					((a[31] == 1'b0)) :
	  	   	   ((op == `EXE_REGIMM_INST) && ((rt == `EXE_BLTZ) || (rt == `EXE_BLTZAL))) ? 
					((a[31] == 1'b1) ) : 1'b0;

					//37: && (a != `ZeroWord)   39:|| (a == `ZeroWord)


endmodule
