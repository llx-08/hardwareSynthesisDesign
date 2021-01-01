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
	output wire out_regwrite,//测试用
	input wire[31:0] instr,mem_rdata,
	input wire data_ram_wea,
	output wire inst_ram_ena, data_ram_ena,
	output wire[31:0] pc,alu_result,aluoutbefore,
	output wire[31:0] out_pc_next_jump,
	output wire[31:0] mem_wdata,SrcAEout,SrcBEout,
	output wire out_pcsrc,out_zero,out_branch,out_jump
    );

	wire flushE,branchD,memtoreg,memtoregE_out,alusrc,regdstE,regwriteW,regwriteE,regwriteM_out,jump,zero,memen,branch,memwrite;
	wire[7:0] alucontrol;
	wire [31:0] instrD_out;

	wire DataMoveW, WriteHiLoW, HiorLoW;

	assign out_branch = branch;
	assign out_regwrite = regwriteW;
	assign out_jump = jump;
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
		.jumpD(jump),
		.memenM(data_ram_ena),
		.alucontrolE(alucontrol),		
		.branchD_out(branchD),

		.DataMoveW(DataMoveW), .WriteHiLoW(WriteHiLoW), .HiorLoW(HiorLoW)

		);

	datapath dp(
		.clka(clka),
		.rst(rst),
		.pc(pc),
		.aluoutM(alu_result),
		.aluoutbefore(aluoutbefore),
		.out_pc_next_jump(out_pc_next_jump),
		.instr(instr),//input

		.DataMoveW(DataMoveW), .WriteHiLoW(WriteHiLoW), .HiorLoW(HiorLoW),

		.instrD_out(instrD_out),//output to controller
		.mem_rdata(mem_rdata),
		.memtoregW(memtoreg),
		.memtoregE(memtoregE_out),
		.regwriteW(regwriteW),
		.regwriteM(regwriteM_out),
		.regwriteE(regwriteE),
		.alusrcE(alusrc),
		.regdstE(regdstE),
		.jumpE(jump),
		.branchD(branchD),
		.alucontrolE(alucontrol),
		.mem_wdata(mem_wdata),
		.out_pcsrc(out_pcsrc),
		.out_zero(out_zero),
		.SrcAEout(SrcAEout),
		.SrcBEout(SrcBEout)
		);
endmodule
