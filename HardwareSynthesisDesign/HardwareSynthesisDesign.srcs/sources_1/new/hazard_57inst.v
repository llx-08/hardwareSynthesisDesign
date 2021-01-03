`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/01 20:34:26
// Design Name: 
// Module Name: hazard_57inst
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
`include "defines2.vh"

module hazard_57inst(
    input rst,
    input wire [4:0] RsD,
                     RtD,
                     RsE,
                     RtE,
                     writeregE,
                     writeregM,
                     writeregW,
    input stall_divE,
    input stall_mulE,
    input flush_div,

	input wire  regwriteE,
                regwriteM,
                regwriteW,
                memtoregE,
                memtoregM,
                pcsrcD,
	output wire [1:0] forwardAE,forwardBE,forwardAD,forwardBD,
    output wire stallF,stallD,stallPC,stallE,stallM,stallW,
    output wire flushF, flushD, flushE, flushM, flushW, flushPC
    );
    
	assign forwardAD = ((RsD != 5'b0) && (RsD == writeregM) && regwriteM)? /*1'b1:1'b0;*/2'b10:
                                        //表示当前正处于ID阶段的这条指令需要读的寄存器是[25:21]并且这个读的地址
                                        //和上上条需要写回寄存器堆的指令的写回地址是一样的

					   ((RsD != 5'b0) && (RsD == writeregW) && regwriteW)? 2'b01:
                                        //表示当前正处于ID阶段的这条指令需要读的寄存器是[25:21]并且这个读的地址
                                        //和上上上条需要写回寄存器堆的指令的写回地址是一样的
                                        
					   ((RsD != 5'b0) && (RsD == writeregE) && regwriteE)? 2'b11
                                        //表示当前正处于ID阶段的这条指令需要读的寄存器是[25:21]并且这个读的地址
                                        //和上一条需要写回寄存器堆的指令的写回地址是一样的
                                                                         : 2'b00;
	assign forwardBD = ((RsD != 5'b0) && (RtD == writeregM) && regwriteM)? /*1'b1:1'b0;*/2'b10:
					   ((RsD != 5'b0) && (RtD == writeregW) && regwriteW)? 2'b01: 
					   ( (RtD == writeregE) && regwriteE)? 2'b11: 2'b00;//(RsD != 5'b0) &&


	assign forwardAE = ((RsE != 5'b0) && (RsE == writeregM) && regwriteM) ? 2'b10:
										//第一个数在reg中的地址就是writeregM	且是不是要写寄存器堆
										//这个时候三选一选的是aluoutM，即10
						((RsE != 5'b0) && (RsE == writeregW) && regwriteW) ? 2'b01 : 2'b00;
										//寄存器取的第一个数的地址等于上一条的write2reg的地址
										//这个时候三选一选的是resultW，即文件中的wd3
	assign forwardBE = ((RtE != 5'b0) && (RtE == writeregM) && regwriteM) ? 2'b10: 
										 //第二个数在reg中的地址就是regwriteM
						((RtE == writeregW) && regwriteW) ? 2'b01 : 2'b00;  //(RtE != 5'b0) &&
										//寄存器取的第二个数的地址等于上一条的write2reg的地址
	wire lwstall,branch_stall;
	assign lwstall = 1'b0;//((RsD == writeregE) ||    //这一条指令的上一条是lw指令并且这一条的第一个源寄存器等于上一条lw指令的目的寄存器
	//				  (RtD == writeregE))     //这一条指令的上一条是lw指令并且这一条的第二个源寄存器等于上一条lw指令的目的寄存器
	//					&& memtoregE;




	// 新增部分
    reg [5:0] stall;
    assign stallPC = stall[0];
    assign stallF = stall[1];
    assign stallD = stall[2];
    assign stallE = stall[3];
    assign stallM = stall[4];
    assign stallW = stall[5];

    assign flushM = stall_divE;

    wire stall_from_ex, stall_from_id;
    assign stall_from_ex = stall_divE | stall_mulE;
    assign stall_from_id = lwstall;
    always @(*) begin
        if(rst == `RstEnable) begin
            stall <= 6'b000000;
        end else if(stall_from_id == `Stop) begin
            stall <= 6'b000111;
        end else if(stall_from_ex == `Stop) begin
            stall <= 6'b001111;
        end
        else stall <= 6'b000000;
    end
endmodule