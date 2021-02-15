`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/04 14:40:43
// Design Name: 
// Module Name: mycpu_top
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


module mycpu_top(
	input wire clk,
	input wire resetn,         // 复位信号，低电平复位
	input wire [5:0] interrupt,// 硬件终端，高电平有效
	
	// Instruction Memory
	output wire inst_sram_en,          // ram 使能信号，高电平有效
	output wire [3:0]  inst_sram_wen,  // ram 字节写使能信号，高电平有效
	output wire [31:0] inst_sram_addr, // ram 读写地址，字节寻址
	output wire [31:0] inst_sram_wdata,// ram 写数据
	input  wire [31:0] inst_sram_rdata,// ram 读入地址
	
	// Data Memory
	output wire data_sram_en,          // ram 使能信号，高电平有效
	output wire [3:0]  data_sram_wen,  // ram 字节写使能信号，高电平有效
	output wire [31:0] data_sram_addr, // ram 读写地址，字节寻址
	output wire [31:0] data_sram_wdata,// ram 写数据
	input  wire [31:0] data_sram_rdata,// ram 读数据
	
	// Debug
	output wire [31:0] debug_wb_pc,    //写回级（多周期最后一级）的 PC，
									//因而需要 mycpu 里将 PC 一路带到写回级
	output wire [3:0]  debug_wb_rf_wen,//写回级写寄存器堆(regfiles)的写使能，为字节写使能，如果 mycpu 写 regfiles
                                       //为单字节写使能，则将写使能扩展成 4 位即可。
	output wire [4:0]  debug_wb_rf_wnum, // 写回级写 regfiles 的目的寄存器号
	output wire [31:0] debug_wb_rf_wdata // 写回级写 regfiles 的写数据
    );

    wire branchD,memtoreg,memtoregE_out,alusrc,regdstE,regwriteW,regwriteE,regwriteM_out, jumpD ,zero,memen,branch,memwrite;
	wire[7:0] alucontrol;
	wire [31:0] instrD_out;

	wire DataMoveW, 
         WriteHiLoW, 
         HiorLoW, 
         MulDivW;//硬综中DataMove指令需要增加的信号

	wire jrD, 
         jalE, 
         balE, 
         jalrD, 
         jalrE; // 硬综中增加j类与beq类指令需要增加的信号

	assign out_branch = branch;
	assign out_regwrite = regwriteW;
	assign out_jump = jumpD;
	assign inst_ram_ena = 1'b1;
    
	//cpu一般都是一直在读指令的，所以置为1
	wire stallF,stallD, stallE,stallPC, stallM, stallW;
	wire flushF,flushD, flushE,flushPC, flushM, flushW;

    // 地址转换
    wire [31:0] inst_paddr;
    wire [31:0] data_paddr;

    // sram 设置对应接口
    assign inst_sram_en    = 2'b1;
    assign inst_sram_wen   = 4'b0000;// ram 字节写使能信号，高电平有效

	assign inst_sram_addr  = inst_paddr;// 传出pc

	assign inst_sram_wdata = 32'b0;// ram 写数据
	assign instr           = inst_sram_rdata;

    assign data_sram_en    = data_ram_ena;      // ram 使能信号，高电平有效
	assign data_sram_wen   = write_mask;

    assign data_sram_addr  = data_paddr;//{alu_result[31:2],{2'b00}};
    assign data_sram_wdata = mem_wdata;
    assign mem_rdata       = data_sram_rdata;

	wire [31:0] pc;
    // assign debug_wb_pc       =;
	// assign debug_wb_rf_wen   =;
	// assign debug_wb_rf_wnum  =;
	// assign debug_wb_rf_wdata =;

    mmu mmu_0(
    .inst_vaddr(pc),            // input wire  [31:0] inst_vaddr,
    .inst_paddr(inst_paddr),    // output wire [31:0] inst_paddr,
    .data_vaddr(alu_result),    // input wire  [31:0] data_vaddr,
    .data_paddr(data_paddr)     // output wire [31:0] data_paddr,
    );

controller c(
		.clk(~clk),
		.rst(~resetn),
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

		.jrD(jrD), .jalE(jalE), 
        .balE(balE), 
        .jalrD(jalrD), .jalrE(jalrE),//硬综中j类指令需要增加的信号

		.DataMoveW(DataMoveW), 
        .WriteHiLoW(WriteHiLoW), 
        .HiorLoW(HiorLoW),//硬综中DataMove指令需要增加的信号
		
        .MulDivW(MulDivW),  // 硬综乘除法
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
		.clka(~clk),
		.rst(~resetn),
		.pc(pc),
		.aluoutM(alu_result),
		.aluoutbefore(aluoutbefore),
		.out_pc_next_jump(out_pc_next_jump),
		.instr(instr),//input


		.DataMoveW(DataMoveW), 
        .WriteHiLoW(WriteHiLoW), 
        .HiorLoW(HiorLoW),//硬综中DataMove指令需要增加的信号

		.jrD(jrD), 
        .jalE(jalE), 
        .balE(balE), .jalrD(jalrD), 
        .jalrE(jalrE),// 硬综中增加j类与beq类指令需要增加的信号
		.MulDivW(MulDivW),

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

		.write_mask(write_mask),// output wire [3:0] write_mask

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
		.flushW(flushW),

        .debug_wb_pc(debug_wb_pc),	          // output wire [31:0] debug_wb_pc,
	    .debug_wb_rf_wnum(debug_wb_rf_wnum),  // output wire [4:0]  debug_wb_rf_wnum,
	    .debug_wb_rf_wdata(debug_wb_rf_wdata) // output wire [31:0] debug_wb_rf_wdata
		);

endmodule
