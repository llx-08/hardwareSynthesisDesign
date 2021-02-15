`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 10:58:03
// Design Name: 
// Module Name: mips
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


module mips(
	input wire clka,rst,
	// input wire [3:0] 
	
	input wire [31:0] instr,mem_rdata,

	//测试访存指令的时候发现这个端口有错，应为output，但是写成了input
	output wire data_ram_wea, //硬综更改，这个现在没啥用

	output wire out_regwrite,
	output wire inst_ram_ena, memenM,
	output wire[31:0] pc,alu_result,aluoutbefore,
	output wire[31:0] out_pc_next_jump,
	output wire[31:0] mem_wdata,SrcAEout,SrcBEout,
	output wire out_pcsrc,out_zero,out_branch,out_jump,

	output wire [3:0] write_mask,//写掩码
	// debug
	output wire [31:0] debug_wb_pc,
	output wire [3:0]  debug_wb_rf_wen,
	output wire [4:0]  debug_wb_rf_wnum,
	output wire [31:0] debug_wb_rf_wdata,

	output wire i_stall,
	output wire d_stall,

	output wire longest_stall
    );

	wire branchD,memtoreg,memtoregE_out,alusrc,regdstE,regwriteW,regwriteE,regwriteM_out, jumpD ,zero,memen,branch,memwrite;

	wire memtoregM;

	wire[7:0] alucontrol;
	wire [31:0] instrD_out;

	wire WriteHiLoD, HiorLoD;

	wire DataMoveD, DataMoveW, WriteHiLoE, WriteHiLoW, HiorLoW, MulDivD;//硬综中DataMove指令需要增加的信号
	wire jrD, jalE, balE, jalrD, jalrE; 		// 硬综中增加j类与beq类指令需要增加的信号

	wire stallF,stallD, stallE,stallPC, stallM, stallW;
	wire flushF,flushD, flushE,flushPC, flushM, flushW;

	assign out_branch = branch;
	assign out_regwrite = regwriteW;
	assign out_jump = jumpD;
	//cpu一般都是一直在读指令的，所以置为1
	assign inst_ram_ena = 1'b1;

	assign debug_wb_rf_wen = {4{regwriteW}};
	

	controller c(
		.clk(clka),
		.rst(rst),
		.instr(instrD_out),//[31:26]
		.memtoregW(memtoreg),
		.memwriteM(data_ram_wea),
		.alusrcE(alusrc),
		.regdstE(regdstE),
		.regwriteW(regwriteW),
		.regwriteE(regwriteE),
		.memtoregE_out(memtoregE_out),
		.regwriteM_out(regwriteM_out),
		.jumpD(jumpD),
		.memenM(memenM),
		.alucontrolE(alucontrol),		
		.branchD_out(branchD),

		.memtoregM(memtoregM),

		.jrD(jrD), .jalE(jalE), .balE(balE), .jalrD(jalrD), .jalrE(jalrE),//硬综中j类指令需要增加的信号
		.DataMoveW(DataMoveW), .WriteHiLoW(WriteHiLoW), //硬综中DataMove指令需要增加的信号
		
		.DataMoveE(DataMoveE),
		.DataMoveM(DataMoveM),

		.WriteHiLoE(WriteHiLoE),
		.WriteHiLoM(WriteHiLoM),
		
		.DataMoveD(DataMoveD),
		.HiorLoD(HiorLoD),
		.WriteHiLoD(WriteHiLoD),
		
		.MulDivD(MulDivD),  // 硬综乘除法
		.stallPC(stallPC),
		.stallF(stallF),
		.stallD(stallD),
		.stallE(stallE),
		.stallM(stallM),
		.stallW(stallW),
		.flushE(flushE),
		.flushF(flushF), 
		.flushD(flushD), 
		.flushPC(flushPC), 
		.flushM(flushM), 
		.flushW(flushW)
		);

	datapath dp(
		.clka(clka),
		.rst(rst),
		.pc(pc),
		.aluoutM(alu_result),
		.aluoutbefore(aluoutbefore),
		.out_pc_next_jump(out_pc_next_jump),
		.instr(instr),//input

		.DataMoveD	(DataMoveD),
		.HiorLoD	(HiorLoD),
		.DataMoveE	(DataMoveE),
		.DataMoveM	(DataMoveM),
		.WriteHiLoM	(WriteHiLoM),
		.WriteHiLoE	(WriteHiLoE),
		.DataMoveW	(DataMoveW), .WriteHiLoW(WriteHiLoW), //硬综中DataMove指令需要增加的信号
		.jrD(jrD), .jalE(jalE), .balE(balE), .jalrD(jalrD), .jalrE(jalrE),// 硬综中增加j类与beq类指令需要增加的信号
		
		
		.WriteHiLoD	(WriteHiLoD),

		.MulDivD	(MulDivD),

		.instrD_out	(instrD_out),//output to controller
		.mem_rdata	(mem_rdata),

		.memtoregM	(memtoregM),

		.memtoregW	(memtoreg),  //这个地方里面是memtoreg有没有问题？？
		
		.memtoregE	(memtoregE_out),
		.regwriteW	(regwriteW),
		.regwriteM	(regwriteM_out),
		.regwriteE	(regwriteE),
		.alusrcE  	(alusrc),
		.regdstE  	(regdstE),
		.jumpD    	(jumpD),
		.branchD  	(branchD),
		.alucontrolE(alucontrol),
		.mem_wdata	(mem_wdata),
		.out_pcsrc	(out_pcsrc),
		.out_zero 	(out_zero),
		.SrcAEout 	(SrcAEout),
		.SrcBEout   (SrcBEout),

		.write_mask (write_mask),// output wire [3:0] write_mask
		.stallPC	(stallPC),
		.stallF		(stallF ),
		.stallD		(stallD ),
		.stallE		(stallE ),
		.stallM		(stallM ),
		.stallW		(stallW ),
		.flushE		(flushE ),
		.flushF		(flushF ), 
		.flushD		(flushD ), 
		.flushPC	(flushPC), 
		.flushM		(flushM ), 
		.flushW		(flushW ),

		.debug_wb_pc	  (debug_wb_pc      ),	// output wire [31:0] debug_wb_pc,
		.debug_wb_rf_wnum (debug_wb_rf_wnum ),	// output wire [4:0]  debug_wb_rf_wnum,
		.debug_wb_rf_wdata(debug_wb_rf_wdata),	// output wire [31:0] debug_wb_rf_wdata

		.i_stall		  (i_stall          ),
		.d_stall		  (d_stall          ),
		.longest_stall    (longest_stall	)
		);
endmodule
