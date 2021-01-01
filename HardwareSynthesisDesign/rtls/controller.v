`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/09 17:15:25
// Design Name: 
// Module Name: controller
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


module controller(
	input wire clk,rst,flushE,
	input wire [31:0] instr,
	output wire memtoregW, memwriteM,
				regwriteM_out,memtoregE_out,
				regwriteW, regwriteE,
				alusrcE, regdstE, jumpD, 
				memenM, 
				branchD_out,
	output wire [7:0] alucontrolE
    );

wire memtoregD,memtoregE,memtoregM,
	 memwriteD,memwriteE,
	 regwriteD, regwriteM,
	 alusrcD,
	 regdstD, 
	 memenD,memenE,
	 branchD,branchE,
	 jal,
	 jr,
	 bal,
	 jalr;

wire [7:0] alucontrolD;
wire [1:0] aluop;

assign regwriteM_out = regwriteM;
assign memtoregE_out = memtoregE;
assign branchD_out = branchD;


maindec u1(
	.op(instr[31:26]),
	.func(instr[5:0]),
	// .aluop(aluop),
	.memtoreg(memtoregD),
	.memwrite(memwriteD),
	.regwrite(regwriteD), 
	.alusrc(alusrcD),
	.regdst(regdstD),
	.jump(jumpD), 
	.memen(memenD),
	.branch(branchD),
	.jal(jal),
	.jr(jr),
	.bal(bal),
	.jalr(jalr)
	);

aludec u2(
	.op(instr[31:26]),  // 硬综更改
	.funct(instr[5:0]),
	.alucontrol(alucontrolD)
    );

floprc #(1) c1(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(regwriteD),// input wire [WIDTH - 1:0] d,
	.q(regwriteE)// output reg [WIDTH - 1:0] q
    );

floprc #(1) c2(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(memtoregD),// input wire [WIDTH - 1:0] d,
	.q(memtoregE)// output reg [WIDTH - 1:0] q
    );

floprc #(1) c3(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(memwriteD),// input wire [WIDTH - 1:0] d,
	.q(memwriteE)// output reg [WIDTH - 1:0] q
    );

floprc #(8) c5(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(alucontrolD),// input wire [WIDTH - 1:0] d,
	.q(alucontrolE)// output reg [WIDTH - 1:0] q
    );

floprc #(1) c6(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(alusrcD),// input wire [WIDTH - 1:0] d,
	.q(alusrcE)// output reg [WIDTH - 1:0] q
    );

floprc #(1) c7(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(regdstD),// input wire [WIDTH - 1:0] d,
	.q(regdstE)// output reg [WIDTH - 1:0] q
    );

floprc #(1) cc1(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(memenD),// input wire [WIDTH - 1:0] d,
	.q(memenE)
	);

floprc #(1) cc2(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(memenE),// input wire [WIDTH - 1:0] d,
	.q(memenM)
	);

//Excute to Memory controller
floprc #(1) c8(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(regwriteE),// input wire [WIDTH - 1:0] d,
	.q(regwriteM)// output reg [WIDTH - 1:0] q
    );

floprc #(1) c9(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(memtoregE),// input wire [WIDTH - 1:0] d,
	.q(memtoregM)// output reg [WIDTH - 1:0] q
    );

floprc #(1) c10(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(memwriteE),// input wire [WIDTH - 1:0] d,
	.q(memwriteM)// output reg [WIDTH - 1:0] q
    );

//Memory to Writeback controller
floprc #(1) c12(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(regwriteM),// input wire [WIDTH - 1:0] d,
	.q(regwriteW)// output reg [WIDTH - 1:0] q
    );

floprc #(1) c13(
	.clk(clk),
	.rst(rst),
	.clear(1'b0),
	.d(memtoregM),// input wire [WIDTH - 1:0] d,
	.q(memtoregW)// output reg [WIDTH - 1:0] q
    );
endmodule
