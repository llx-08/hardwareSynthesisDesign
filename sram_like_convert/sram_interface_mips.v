`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/04 21:41:58
// Design Name: 
// Module Name: llx_newMycpu_top
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


module newMycpu_top(
	input wire 		   clk      ,
	input wire 		   resetn   ,// 复位信号，低电平复位
	input wire  [5:0]  interrupt,// 硬件终端，高电平有效
	
	// Instruction Memory
	output wire        inst_sram_en   ,// ram 使能信号，高电平有效
	output wire [3:0]  inst_sram_wen  ,// ram 字节写使能信号，高电平有效
	output wire [31:0] inst_sram_addr ,// ram 读写地址，字节寻址
	output wire [31:0] inst_sram_wdata,// ram 写数据
	input  wire [31:0] inst_sram_rdata,// ram 读入地址
	
	// Data Memory
	output wire        data_sram_en   ,// ram 使能信号，高电平有效
	output wire [3:0]  data_sram_wen  ,// ram 字节写使能信号，高电平有效
	output wire [31:0] data_sram_addr ,// ram 读写地址，字节寻址
	output wire [31:0] data_sram_wdata,// ram 写数据
	input  wire [31:0] data_sram_rdata,// ram 读数据
	
	// Debug
	output wire [31:0] debug_wb_pc,    //写回级（多周期最后一级）的 PC，
									   //因而需要 mycpu 里将 PC 一路带到写回级
	output wire [3:0]  debug_wb_rf_wen,//写回级写寄存器堆(regfiles)的写使能，为字节写使能，如果 mycpu 写 regfiles
                                       //为单字节写使能，则将写使能扩展成 4 位即可。
	output wire [4:0]  debug_wb_rf_wnum, // 写回级写 regfiles 的目的寄存器号
	output wire [31:0] debug_wb_rf_wdata,// 写回级写 regfiles 的写数据

	// axi stalls
	input  wire	       i_stall,
	input  wire		   d_stall,
	output wire        longest_stall
    );

wire [31:0] pc;
wire [31:0] alu_result;
// wire i_stall, d_stall, longest_stall;

// 地址转换
mmu addr_transfer(
	.inst_vaddr(pc			  ),
	.inst_paddr(inst_sram_addr),
	.data_vaddr(alu_result	  ),
	.data_paddr(data_sram_addr)
);

// 端口赋值
// assign inst_sram_en = 1'b1;
assign inst_sram_wen = 4'b0000;
assign inst_sram_wdata = 32'b0;

// 访存指令才为1
// assign data_sram_en = memenM;

mips Mymips(
		.clka    (clk),
		.rst     (resetn),
		
        // instr
        .inst_ram_ena    (inst_sram_en),   
                       //(inst_sram_wen) 
                       //(inst_sram_addr)
                       //(inst_sram_wdata)
        .instr           (inst_sram_rdata),

        // data
                       //(data_sram_en)
        .write_mask      (data_sram_wen  ),
                       //(data_sram_addr )
        .mem_wdata       (data_sram_wdata),  // 写入mem的数据
		.mem_rdata       (data_sram_rdata),// 从mem读入的数据
		.data_ram_wea    (data_ram_wea	 ),
		.memenM          (data_sram_en 	 ),


		.pc              (pc			  ),
		.alu_result      (alu_result 	  ), // 没有地址转换时的mem地址
		.aluoutbefore    (aluoutbefore	  ),
		.out_pc_next_jump(out_pc_next_jump),
		.out_regwrite    (out_regwrite	  ),
		
		.out_pcsrc       (out_pcsrc		  ),
		.out_zero        (out_zero		  ),
		.out_branch      (out_branch	  ),
		.out_jump        (out_jump		  ),
		.SrcAEout        (SrcAEout		  ),
		.SrcBEout        (SrcBEout		  ),

		
        // debug
        .debug_wb_pc	  (debug_wb_pc		),
	    .debug_wb_rf_wen  (debug_wb_rf_wen	),
	    .debug_wb_rf_wnum (debug_wb_rf_wnum	),
	    .debug_wb_rf_wdata(debug_wb_rf_wdata),

		// axi stalls
		.i_stall	      (i_stall),	// input 	 i_stall,
		.d_stall		  (d_stall),	// input 	 d_stall,
		.longest_stall    (longest_stall)	// output  longest_stall
);


endmodule
