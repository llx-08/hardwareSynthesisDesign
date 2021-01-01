`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/09 16:36:33
// Design Name: 
// Module Name: maindec
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


module maindec_57inst(
	input wire [5:0] op,
	input wire [5:0] funct,
	input wire [4:0] rt,
	output wire memtoreg, memen, memwrite,
	output wire branch, alusrc,
	output wire regdst, regwrite,
	output wire jump, jal, jr, bal
	);

	always @(*) begin 
		case (op)
			
		
			default : /* default */;
		endcase
	
	end



endmodule
