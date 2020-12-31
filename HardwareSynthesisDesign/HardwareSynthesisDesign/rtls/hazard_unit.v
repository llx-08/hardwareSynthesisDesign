`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/21 21:50:22
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit(
	input wire [4:0] RsD,RtD,RsE,RtE,writeregE,writeregM,writeregW,

	input wire regwriteE,regwriteM,regwriteW,memtoregE,memtoregM,pcsrcD,
	output wire [1:0] forwardAE,forwardBE,forwardAD,forwardBD,
    output wire stallF,stallD,flushE
    );
	
	assign forwardAD = ((RsD != 5'b0) && (RsD == writeregM) && regwriteM)? /*1'b1:1'b0;*/2'b10:
					   ((RsD != 5'b0) && (RsD == writeregW) && regwriteW)? 2'b01:
					   ((RsD != 5'b0) && (RsD == writeregE) && regwriteE)? 2'b11: 2'b00;
	assign forwardBD = ((RsD != 5'b0) && (RtD == writeregM) && regwriteM)? /*1'b1:1'b0;*/2'b10:
					   ((RsD != 5'b0) && (RtD == writeregW) && regwriteW)? 2'b01: 
					   ((RsD != 5'b0) && (RtD == writeregE) && regwriteE)? 2'b11: 2'b00;


	assign forwardAE = ((RsE != 5'b0) && (RsE == writeregM) && regwriteM) ? 2'b10:
										//第一个数在reg中的地址就是writeregM	且是不是要写寄存器堆
										//这个时候三选一选的是aluoutM，即10
						((RsE != 5'b0) && (RsE == writeregW) && regwriteW) ? 2'b01 : 2'b00;
										//寄存器取的第一个数的地址等于上一条的write2reg的地址
										//这个时候三选一选的是resultW，即文件中的wd3
	assign forwardBE = ((RtE != 5'b0) && (RtE == writeregM) && regwriteM) ? 2'b10: 
										 //第二个数在reg中的地址就是regwriteM
						((RtE != 5'b0) && (RtE == writeregW) && regwriteW) ? 2'b01 : 2'b00;
										//寄存器取的第二个数的地址等于上一条的write2reg的地址
	wire lwstall,branch_stall;
	assign lwstall = ((RsD == RtE) ||    //这一条指令的上一条是lw指令并且这一条的第一个源寄存器等于上一条lw指令的目的寄存器
					  (RtD == RtE))     //这一条指令的上一条是lw指令并且这一条的第二个源寄存器等于上一条lw指令的目的寄存器
						&& memtoregE;

	assign branch_stall = 1'b0;/*(pcsrcD && regwriteE && ((writeregE == RsD) || (writeregE == RtD)) ) ||
						  (pcsrcD && memtoregM && ((writeregM == RsD) || (writeregM == RtD)) );*/
	assign stallF = lwstall || branch_stall;
	assign stallD = lwstall || branch_stall;
	assign flushE = lwstall || branch_stall;
endmodule
