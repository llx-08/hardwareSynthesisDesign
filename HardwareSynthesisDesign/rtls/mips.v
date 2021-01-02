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
	output wire [3:0]  data_ram_wea, //硬综更改，这个现在没啥用

	output wire out_regwrite,
	output wire inst_ram_ena, data_ram_ena,
	output wire[31:0] pc,alu_result,aluoutbefore,
	output wire[31:0] out_pc_next_jump,
	output wire[31:0] mem_wdata,SrcAEout,SrcBEout,
	output wire out_pcsrc,out_zero,out_branch,out_jump,

	output wire [3:0] write_mask//写掩码
    );

	wire flushE,branchD,memtoreg,memtoregE_out,alusrc,regdstE,regwriteW,regwriteE,regwriteM_out, jumpD ,zero,memen,branch,memwrite;
	wire[7:0] alucontrol;
	wire [31:0] instrD_out;

	wire DataMoveW, WriteHiLoW, HiorLoW;//硬综中DataMove指令需要增加的信号
	wire jrD, jalE, balE, jalrD, jalrE; 		// 硬综中增加j类与beq类指令需要增加的信号

	assign out_branch = branch;
	assign out_regwrite = regwriteW;
	assign out_jump = jumpD;
	assign inst_ram_ena = 1'b1;
	//cpu一般都是一直在读指令的，所以置为1
	


	controller c(
		.clk(clka),
		.rst(rst),
		.flushE(flushE),
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
		.memenM(data_ram_ena),
		.alucontrolE(alucontrol),		
		.branchD_out(branchD),

		.jrD(jrD), .jalE(jalE), .balE(balE), .jalrD(jalrD), .jalrE(jalrE),				 //硬综中j类指令需要增加的信号
		.DataMoveW(DataMoveW), .WriteHiLoW(WriteHiLoW), .HiorLoW(HiorLoW)//硬综中DataMove指令需要增加的信号

		);

	datapath dp(
		.clka(clka),
		.rst(rst),
		.pc(pc),
		.aluoutM(alu_result),
		.aluoutbefore(aluoutbefore),
		.out_pc_next_jump(out_pc_next_jump),
		.instr(instr),//input


		.DataMoveW(DataMoveW), .WriteHiLoW(WriteHiLoW), .HiorLoW(HiorLoW),//硬综中DataMove指令需要增加的信号
		.jrD(jrD), .jalE(jalE), .balE(balE), .jalrD(jalrD), .jalrE(jalrE),// 硬综中增加j类与beq类指令需要增加的信号


		.instrD_out(instrD_out),//output to controller
		.mem_rdata(mem_rdata),
		.memtoregW(memtoreg),
		.memtoregE(memtoregE_out),
		.regwriteW(regwriteW),
		.regwriteM(regwriteM_out),
		.regwriteE(regwriteE),
		.alusrcE(alusrc),
		.regdstE(regdstE),
		.jumpD(jumpD),
		.branchD(branchD),
		.alucontrolE(alucontrol),
		.mem_wdata(mem_wdata),
		.out_pcsrc(out_pcsrc),
		.out_zero(out_zero),
		.SrcAEout(SrcAEout),
		.SrcBEout(SrcBEout),

		.write_mask(write_mask)// output wire [3:0] write_mask
		);
endmodule
