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

    input wire  branchD, // add 2021.1.5

    input wire  stall_divE,
    input wire  stall_mulE,
    input wire  flush_div,
    input wire  jrD, // add 之后紧跟jr指令要添加的stall
    // input wire  jalrD, // add之后紧跟jalr

    input wire MulDivM,
    input wire HiorLoE, HiorLoM,  
    input wire DataMoveD, DataMoveE, DataMoveM, WriteHiLoD, WriteHiLoM, WriteHiLoE,

	input wire  regwriteE,
                regwriteM,
                regwriteW,
                memtoregE,
                memtoregM,
                pcsrcD,

	output wire [1:0] forwardAE,forwardBE,
    output wire forwardAD,forwardBD,

    // output wire forwardHilo;

    output wire stallF,stallD,stallPC,stallE,stallM,stallW,
    output wire flushF, flushD, flushE, flushM, flushW, flushPC,
    output wire forward_hiloE,

    // axi stall
    input  wire i_stall,
    input  wire d_stall,
    output wire longest_stall
    );
    
    assign forward_hiloE = MulDivM && ( DataMoveE && !WriteHiLoE );

    // ( (DataMoveM || MulDivM) && WriteHiLoM && DataMoveE && !WriteHiLoE && HiorLoE == HiorLoM))?
                                              

    // 前推
	assign forwardAD = (( (RsD != 5'b0) && (RsD == writeregM) && regwriteM) ||  
                            MulDivM && ( DataMoveD && !WriteHiLoD ) )?  1'b1 : 1'b0 ; //2'b10:
                                        //表示当前正处于ID阶段的这条指令需要读的寄存器是[25:21]并且这个读的地址
                                        //和上上条需要写回寄存器堆的指令的写回地址是一样的

					//    ((RsD != 5'b0) && (RsD == writeregW) && regwriteW)? 2'b01:
                                        //表示当前正处于ID阶段的这条指令需要读的寄存器是[25:21]并且这个读的地址
                                        //和上上上条需要写回寄存器堆的指令的写回地址是一样的
                                        
					//    ((RsD != 5'b0) && (RsD == writeregE) && regwriteE)? 2'b11
                                        //表示当前正处于ID阶段的这条指令需要读的寄存器是[25:21]并且这个读的地址
                                        //和上一条需要写回寄存器堆的指令的写回地址是一样的
                                                                        //  : 2'b00;
	assign forwardBD = ((RsD != 5'b0) && (RtD == writeregM) && regwriteM)? 1'b1:1'b0; //2'b10:
					//    ((RsD != 5'b0) && (RtD == writeregW) && regwriteW)? 2'b01: 
					//    ((RtD == writeregE) && regwriteE)? 2'b11: 2'b00;//(RsD != 5'b0) &&

    
	assign forwardAE =( ((RsE != 5'b0) && (RsE == writeregM) && regwriteM) || 
                        //第一个数在reg中的地址就是writeregM	且是不是要写寄存器堆
										//这个时候三选一选的是aluoutM，即10
                        ( DataMoveM && WriteHiLoM && DataMoveE && !WriteHiLoE && HiorLoE == HiorLoM))? 2'b10:
						//上一条是，mthi或者muldiv，这一条是mfhi或者mflo
						((RsE != 5'b0) && (RsE == writeregW) && regwriteW) ? 2'b01 : 2'b00;
										//寄存器取的第一个数的地址等于上一条的write2reg的地址
										//这个时候三选一选的是resultW，即文件中的wd3
	assign forwardBE = ((RtE != 5'b0) && (RtE == writeregM) && regwriteM) ? 2'b10: 
										 //第二个数在reg中的地址就是regwriteM
						((RtE == writeregW) && regwriteW) ? 2'b01 : 2'b00;  //(RtE != 5'b0) &&
										//寄存器取的第二个数的地址等于上一条的write2reg的地址

    // assign forwardHilo = ;
    // stall
	wire lwstallD, branch_stallD, jr_stallD;
	assign lwstallD = ((RsD == writeregE) || (RtD == writeregE)) && memtoregE;    
    //这一条指令的上一条是lw指令并且这一条的第一个源寄存器等于上一条lw指令的目的寄存器
	//这一条指令的上一条是lw指令并且这一条的第二个源寄存器等于上一条lw指令的目的寄存器
	
    assign jr_stallD = (RsD == writeregE) && regwriteE && jrD;
    // assign jalr_stallD = (RsD == writeregE) && regwriteE && jalrD;

    // assign branch_stallD = 这里记得要加进去		
    assign branch_stallD = branchD && regwriteE &&  (writeregE == RsD || writeregE == RtD) ||
    // 1. 要跳转的时候，上一条指令写的寄存器号等于下一条指令读的寄存器号  
                           branchD && memtoregM && (writeregM == RsD || writeregM == RtD) ;
                           
    
                          
    // 2. 指令是跳转指令并且上上条是lw指令，
	// 新增部分



    reg [5:0] stall;
    //错误：assign stallPC = stall[0];
    assign stallPC = i_stall || d_stall || stall[0];
    assign stallF  = i_stall || d_stall || stall[1];
    assign stallD  = i_stall || d_stall || stall[2];
    assign stallE  = i_stall || d_stall || stall[3];
    assign stallM  = i_stall || d_stall || stall[4];
    assign stallW  = i_stall || d_stall || stall[5];

    // reg hasStall;// 判断longest stall

    assign flushD = 0;
    assign flushE = (lwstallD || branch_stallD || jr_stallD) && ~(i_stall);//|| d_stall
    assign flushM = stall_divE && ~i_stall;

    wire   stall_from_ex, stall_from_id;
    assign stall_from_ex = stall_divE | stall_mulE;
    assign stall_from_id = lwstallD | jr_stallD | branch_stallD;


    // W,M,E,D,F,PC
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


    assign longest_stall = i_stall || d_stall || stall_divE;

endmodule