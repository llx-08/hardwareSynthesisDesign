`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 09:13:40
// Design Name: 
// Module Name: datapath
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
`include "defines.vh"
`include "defines2.vh"
module datapath(
	input wire clka,rst,
	input wire memtoregW,regwriteW, 
				regwriteM,regwriteE,
				alusrcE, regdstE, jumpE, 
				memtoregE,branchD,
	input wire  [7:0] alucontrolE,
	input wire  [31:0] instr, mem_rdata,

	input wire HiorLoW, DataMoveW, WriteHiLoW, // 硬综添加

	output wire out_pcsrc,out_zero,out_flushE,
	output wire [31:0] pc,out_pc_next_jump,
	output wire [31:0] aluoutM,aluoutbefore,
	output wire [31:0] instrD_out,
	output wire [31:0] mem_wdata,
	output wire [31:0] SrcAEout,SrcBEout
    );
wire pcsrcD,zero,zeroM;
wire stallF,stallD,flushE;
wire [1:0]  forwardAE,forwardBE,forwardAD,forwardBD;

wire [4:0] writeregE,writeregM,writeregW,
		   RtE,RdE,RsE,RsD,RtD, saD, saE;
//硬综在这里新加了一条saD,saE

wire [31:0] instr_sl2,instrD;
wire [31:0] pc_plus4F,pc_plus4D,pc_plus4E,
			rd1,rd1D,SrcAE,
			rd2,rd2D,SrcBE,
			SignImmD,SignImmE,imm_sl2,
			alu_result,aluoutW,
			writedataE,writedataM,
			wa3,resultW,rd1E,rd2E,
			ReadDataW,pc_next,
			pc_branchD,pc_branchM,
			pc_next_jump, 
			memtoregM,memwriteM,
			branchE; 

// 除法部分
wire signed_div_i;
wire opdata1_i;
wire opdata2_i;
wire start_i;
wire end_i;
wire div_result;
wire ready_o;

assign signed_div_i = (alucontrolE == `EXE_DIV_OP) ? 1'b1 : 1'b0;
assign opdata1_i = SrcAE;
assign opdata2_i = SrcBE;
assign start_i = (alucontrolE == `EXE_DIV_OP | 
				  alucontrolE == `EXE_DIVU_OP) ? 1'b1 : 1'b0;
assign end_i = 1'b0;

assign out_flushE = flushE;
assign RsD = instrD[25:21];
assign RtD = instrD[20:16];
assign instrD_out = instrD;
assign aluoutbefore = alu_result;
assign out_zero = zero;
assign out_pcsrc = pcsrcD;
assign out_pc_next_jump = pc_next_jump;
assign mem_wdata = writedataM;
assign SrcAEout = RtD;
assign SrcBEout = writeregW;

//pc
pc u1(
	.clk(clka),
	.en(~stallF),
	.rst(rst),// input wire clk, rst,
	.din(pc_next_jump),// input wire [31:0] din,
	.q(pc)// output reg [31:0] q
    );

//pcadder
adder pcadder(
	.a(pc),// input wire[31:0] a,b,
	.b(32'd4),// output wire[31:0] y
    .y(pc_plus4F)
    );

//Fetch to decode
flopenrc #(32) r1(
	.clk(clka),
	.rst(rst),
	.en(~stallD),
	.clear(1'b0),
	.d(instr),// input wire [WIDTH - 1:0] d,
	.q(instrD)// output reg [WIDTH - 1:0] q
    );

//Fetch pc+4
flopenrc #(32) r2(
	.clk(clka),
	.rst(rst),
	.en(~stallD),
	.clear(pcsrcD),
	.d(pc_plus4F),// input wire [WIDTH - 1:0] d,
	.q(pc_plus4D)// output reg [WIDTH - 1:0] q
    );

//reg_file
regfile u4(//regfile的读功能是相当于一个组合逻辑的
	.clk(~clka),//input wire clk,
	.we3(regwriteW),//regwrite  写使能
	.ra1(instrD[25:21]),
	.ra2(instrD[20:16]), //lw中，将ra2的数取出，
	.wa3(writeregW),//input wire[4:0] ra1,ra2,wa3,
	.wd3(resultW),// input wire[31:0] wd3,
	.rd1(rd1),
	.rd2(rd2)// output wire[31:0] rd1,rd2
    );

// mux3x1_forward d_forwardA(
// 	.a(rd1),
// 	.b(aluoutW),//b是10，  10是M
// 	.c(aluoutM),// input wire [31:0] a,b,c,
// 	.s(forwardAD),// input wire [1:0] s,
// 	.y(rd1D)// output wire [31:0] y
//     );

// mux3x1_forward d_forwardB(
// 	.a(rd2),
// 	.b(aluoutW),//b是10，  10是M
// 	.c(aluoutM),// input wire [31:0] a,b,c,
// 	.s(forwardBD),// input wire [1:0] s,
// 	.y(rd2D)// output wire [31:0] y
//     );

mux4x1_forwardD d_forwardA(
	.a(rd1),
	.b(aluoutW),
	.c(aluoutM),// input wire [31:0] a,b,c,d
	.d(alu_result),
	.s(forwardAD),// input wire [1:0] s,
	.y(rd1D)// output wire [31:0] y
    );

mux4x1_forwardD d_forwardB(
	.a(rd2),
	.b(aluoutW),
	.c(aluoutM),// input wire [31:0] a,b,c,d
	.d(alu_result),
	.s(forwardBD),// input wire [1:0] s,
	.y(rd2D)// output wire [31:0] y
    );

// mux2x1_32 rd1_or_writeback(
// 	.a(aluoutW),// input wire [31:0] a,
// 	.b(rd1),// input wire [31:0] b,
// 	.s(forwardAD),// input wire s,
// 	.y(rd1D)// output wire [31:0] y
//     );

// mux2x1_32 rd2_or_writeback(
// 	.a(aluoutW),// input wire [31:0] a,
// 	.b(rd2),// input wire [31:0] b,
// 	.s(forwardBD),// input wire s,
// 	.y(rd2D)// output wire [31:0] y
//     );

assign pcsrcD = ((rd1D == rd2D) && branchD);

//Decode to Excute rd1
flopenrc #(32) r3(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(flushE),
	.d(rd1D),// input wire [WIDTH - 1:0] d,
	.q(rd1E)// output reg [WIDTH - 1:0] q
    );

//Decode to Excute rd2
flopenrc #(32) r4(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(flushE),
	.d(rd2D),// input wire [WIDTH - 1:0] d,
	.q(rd2E)// output reg [WIDTH - 1:0] q
    );

//Decode to Excute RtE
flopenrc #(5) r5(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(flushE),
	.d(instrD[15:11]),// input wire [WIDTH - 1:0] d,
	.q(RdE)// output reg [WIDTH - 1:0] q
    );

//Decode to Excute RdE
flopenrc #(5) r6(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(flushE),
	.d(instrD[20:16]),// input wire [WIDTH - 1:0] d,
	.q(RtE)// output reg [WIDTH - 1:0] q
    );


//-------------------------------------------------
//硬综新加的sa
assign saD = instrD[10:6];
//Decode to Excute sa
flopenrc #(5) saDtoE(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(flushE),
	.d(saD),// input wire [WIDTH - 1:0] d,
	.q(saE)// output reg [WIDTH - 1:0] q
    );
//-------------------------------------------------


//Decode to Execute Rs
flopenrc #(5) r6_1(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(flushE),
	.d(instrD[25:21]),// input wire [WIDTH - 1:0] d,
	.q(RsE)// output reg [WIDTH - 1:0] q
    );

//sign extend
sign_extend u5(
	.a(instrD[15:0]),// input wire [15:0] a,
	.select(instrD[29:28]),
	.y(SignImmD)// output wire [31:0] y
    );

// Decode to Excute sign extend
flopenrc #(32) r7(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(flushE),
	.d(SignImmD),// input wire [WIDTH - 1:0] d,
	.q(SignImmE)// output reg [WIDTH - 1:0] q
    );

//Decode to Excute pc+4
// flopenrc #(32) r8(
// 	.clk(clka),
// 	.rst(rst),
// 	.en(1'b1),
// 	.clear(flushE),
// 	.d(pc_plus4D),// input wire [WIDTH - 1:0] d,
// 	.q(pc_plus4E)// output reg [WIDTH - 1:0] q
//     );

mux3x1_forward srca_sel(
	.a(rd1E),// input wire [31:0] a,b,c,
	.b(aluoutW),
	.c(aluoutM),
	//下面是forwardAE
    .s(forwardAE),// input wire [1:0] s,
    .y(SrcAE)// output wire [31:0] y
    );

mux3x1_forward srcb_sel(
	.a(rd2E),// input wire [31:0] a,b,c,
	.b(aluoutW),
	.c(aluoutM),
    .s(forwardBE),// input wire [1:0] s,
    .y(writedataE)// output wire [31:0] y
    );

//mux2x1 for alusrcb
mux2x1_32 alusrcb( //a是1，b是0
	.a(SignImmE),// input wire [31:0] a,
	.b(writedataE),// input wire [31:0] b,
	.s(alusrcE),// alusrcE
	.y(SrcBE)// output wire [31:0] y 
    );

hazard_unit h1(
	.RsD(RsD),
	.RtD(RtD),
	.RsE(RsE),
	.RtE(RtE),
	.writeregE(writeregE),
	.writeregM(writeregM),
	.writeregW(writeregW),// input wire [4:0] RsE,RtE,writeregM, writeregW,
	.forwardAE(forwardAE),
	.forwardBE(forwardBE),// output wire [1：0] forwardAE,forwardBE,
	.memtoregE(memtoregE),
	.memtoregM(memtoregM),
	.regwriteE(regwriteE),
	.regwriteM(regwriteM),
	.regwriteW(regwriteW),// output wire regwriteM,regwriteW,
    .stallF(stallF),
    .stallD(stallD),
    .flushE(flushE),
    .forwardAD(forwardAD),
    .forwardBD(forwardBD),
    .pcsrcD(pcsrcD)
    );

//alu
alu u6(
	.a(SrcAE),// input wire [31:0] a,
	.b(SrcBE),// input wire [31:0] b,
	.op(alucontrolE),// alucontrol
	.sa(saE),
	.y(alu_result),// output reg [31:0] s
    .zero(zero)
    );

div divider(
		.clk(clka),
		.rst(rst),
		.signed_div_i(signed_div_i),//是否为有符号除法（1为有符号）
		.opdata1_i(opdata1_i),// 被除数
		.opdata2_i(opdata2_i),// 除数
		.start_i(start_i),  // 是否开始除法
		.annul_i(end_div),  // 是否从外界停止除法
		.result_o(div_result),// 除法结果
		.ready_o(ready_o) // 除法运算是否结束
	);

//Excute to Memory alu-zero
flopenrc #(1) r9(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(1'b0),
	.d(zero),// input wire [WIDTH - 1:0] d,
	.q(zeroM)// output reg [WIDTH - 1:0] q
    );

//Excute to Memory alu
flopenrc #(32) r10(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(1'b0),
	.d(alu_result),// input wire [WIDTH - 1:0] d,
	.q(aluoutM)// output reg [WIDTH - 1:0] q
    );

//Excute to Memory writedataE to writedataM
flopenrc #(32) r11(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(1'b0),
	.d(writedataE),// input wire [WIDTH - 1:0] d,
	.q(writedataM)// output reg [WIDTH - 1:0] q
    );


//left shift 2 bits
sl2 left_shift2(
	.a(SignImmD),// input wire [31:0] a,
	.y(imm_sl2)// output wire [31:0] y
    );

//left shift 2 bits then plus pc+4
adder adder_pc_branch(
	.a(pc_plus4D),// input wire[31:0] a,b,
	.b(imm_sl2),// output wire[31:0] y
    .y(pc_branchD)
    );

//mux2x1 for rt or rd
mux2x1_5 mux_wa3(
	.a(RdE),// input wire [4:0] a,
	.b(RtE),// input wire [4:0] b,
	.s(regdstE),// regdst
	.y(writeregE)// output wire [4:0] y 
    );

//Excute to Memory writetoreg
flopenrc #(32) r13(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(1'b0),
	.d(writeregE),// input wire [WIDTH - 1:0] d,
	.q(writeregM)// output reg [WIDTH - 1:0] q
    );

//Memory to Writeback writetoreg
flopenrc #(32) r14(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(1'b0),
	.d(writeregM),// input wire [WIDTH - 1:0] d,
	.q(writeregW)// output reg [WIDTH - 1:0] q
    );

//Memory to Writeback
flopenrc #(32) r15(
	.clk(clka),
	.rst(rst),
	.en(1'b1),
	.clear(1'b0),
	.d(mem_rdata),// input wire [WIDTH - 1:0] d,
	.q(ReadDataW)// output reg [WIDTH - 1:0] q
    );

//Memory to Writeback aluoutM - aluoutW
floprc #(32) r16(
	.clk(clka),
	.rst(rst),
	.clear(1'b0),
	.d(aluoutM),// input wire [WIDTH - 1:0] d,
	.q(aluoutW)// output reg [WIDTH - 1:0] q
    );


//mux2x1 for pc_branch or pc+4
mux2x1_32 mux_pc_next(
	.a(pc_branchD),// input wire [31:0] a,
	.b(pc_plus4F),// input wire [31:0] b,
	.s(pcsrcD),// pcsrc
	.y(pc_next)// output wire [31:0] y 
    );

//pc_jump left shift
sl2 jump_left_shift2(
	.a({6'b0,instrD[25:0]}),// input wire [31:0] a,
	.y(instr_sl2)// output wire [31:0] y
    );



//mux2x1 for pc_jump
mux2x1_32 mux_pc_jump(
	.a({pc_plus4F[31:28],instr_sl2[27:0]}),// input wire [31:0] a,
	.b(pc_next),// insput wire [31:0] b,
	.s(jumpE),// Mjump
	.y(pc_next_jump)// output wire [31:0] y 
    );

//pc_add_4
adder u8(
	.a(pc),// input wire[31:0] a,b,
	.b(32'd4),// output wire[31:0] y
    .y(pc_plus4F)
    );

wire [31:0] resultW_tmp; 

//mux2x1 for writeback to register
mux2x1_32 mux_wd3(
	.a(ReadDataW),// input wire [31:0] a,
	.b(aluoutW),// input wire [31:0] b,
	.s(memtoregW), //memtoreg
	.y(resultW_tmp)// output wire [31:0] y 
    );


//Added in HardWare Synthesis Design 


//----------------------------------------------------------
//添加HiLo模块与对应通路，mux
//根据HiorLoW信号来决定将aluoutW输入的信号是分配给hi还是分配给lo

wire [31:0] hi, lo, hi_o, lo_o, hilo_out;


hilo_distribute hilo_d(
    .in(aluoutW), //input  wire [31:0] in
	.s(HiorLoW),  //input  wire  s
	.hi(hi), 	 //output wire [31:0] hi
	.lo(lo)  	 //output wire [31:0] hi
    );


hilo_reg hilo(
	.clk(~clka),
	.rst(rst),
	.we(WriteHiLoW),
	.hi(hi),//input wire[31:0] hi
	.lo(lo),
	.hi_o(hi_o), //output reg[31:0] hi_o
	.lo_o(lo_o)
    );


mux2x1_32 mux_hilo(
	.a(hi_o),
	.b(lo_o),
	.s(HiorLoW),
	.y(hilo_out)
	);


mux2x1_32 mux_datamove(
	.a(hilo_out),
	.b(resultW_tmp),
	.s((DataMoveW & !WriteHiLoW)),
	.y(resultW)
	);
//----------------------------------------------------------


//----------------------------------------------------------
//添加jr所需要的通路：读的地址是rs寄存器的地址
// wire jrD;
// // wire [31:0] pc_next_jump_tmp; 在line54增加了定义

// mux2x1_32 mux_jr(
// 	.a(rd1D),
// 	.b(pc_next_jump_tmp),
// 	.s(jrD),
// 	.y(pc_next_jump)
// 	);

//----------------------------------------------------------


//----------------------------------------------------------
//添加jal所需要的，那边写入寄存器的地址应该是31，还有增加一个pc+8，复用aluoutM传下去
// wire [4:0] writeregEtmp;这里在line42增加了定义
// 在line49添加了 wire[31:0] alu_result_tmp
// wire [31:0]  pc_plus8E;

// mux2x1_5 mux_writeaddress_jal(
// 	.a(5'b11111),  //表示31号寄存器
// 	.b(writeregEtmp),
// 	.s((jalE | balE | ( jalr & (rdE == 5'b0) ) )),
// 	.y(writeregE)
// 	);


// adder adder_jal(
// 	.a(pc_plus4E),//input wire[31:0] a,b
// 	.b(32'b100),  //b这个地方接一个4
// 	.y(pc_plus8E) 	   //output wire[31:0] y
//     );


// mux2x1_32 mux_pcplus8_jal(
// 	.a(alu_result_tmp),
// 	.b(pc_next_jump_tmp),
// 	.s( (jalE | balE) ),
// 	.y(alu_result)
// 	);

//----------------------------------------------------------


endmodule