`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/09 16:36:33
// Design Name: 
// Module Name: maindec
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
module maindec(
	input wire [5:0] op,
	input wire [5:0] func,
	output wire memtoreg, memwrite,regwrite, 
				alusrc, regdst, jump, 
				memen, branch,jal,jr,bal,jalr,
    output wire DataMove, WriteHiLo, HiorLo
	);
	reg [14:0] sigs;

	assign {regdst, alusrc, memtoreg, regwrite,
				memen, memwrite, branch, jump,
				jar, jr, bal,DataMove, WriteHiLo, HiorLo, jalr } = sigs;
	//regdst：  1表示[15:15]为写回地址，是0表示[20:16]为写回地址
	//alusrc：  1表示alu的B操作数来自立即数经过符号位扩展，0表示alu的B操作数来自寄存器堆读出的操作数2
	//memtoreg：1表示写回register的数是从memory中取出来的，0表示写回register的数是alu的计算结果
	//regwrite：1表示该指令需要写回寄存器堆，0则反之
	//memen：   1表示该指令需要使用到memory
	//memwrite：1表示该指令需要写memory
	//branch
	//jump
	//jar
	//jr
	//bal
	//DataMove：1表示该指令为DataMove类指令
	//WriteHiLo:1表示该指令需要写HiLo寄存器，
	//HiorLo：  1表示该指令为DataMove类指令，并且将数据存进Hi寄存器中或者要从Hi寄存器中取数据
	//jalr

	

	always @(*) begin
		case (op)
			`R_TYPE: begin 
				
				case (func)
						`JR: sigs <= {15'b0_0_0_0_0_0_0_0_0_1_0_0_0_0_0};
						`JALR: sigs <= {15'b1_0_0_1_0_0_0_0_0_0_0_0_0_0_1};
						// 数据移动指令
						`MFHI:
							sigs <= {15'b1_0_0_1_0_0_0_0_0_0_0_1_0_1_0};
						`MFLO:
							sigs <= {15'b1_0_0_1_0_0_0_0_0_0_0_1_0_0_0};
						`MTHI:
							sigs <= {15'b0_0_0_0_0_0_0_0_0_0_0_1_1_1_0};
						`MTLO:
							sigs <= {15'b0_0_0_0_0_0_0_0_0_0_0_1_1_0_0};
						
						// R_Type logic
						`AND, `OR, `XOR, `NOR, `SLL, `SRL, `SRA,
						`SLLV, `SRLV, `SRAV, `ADD, `ADDU, `SUB,
						`SUBU, `SLT, `SLTU, `MULT, `MULTU, `DIV,
						`DIVU:
							sigs <= {15'b1_0_0_1_0_0_0_0_0_0_0_0_0_0_0};
					endcase

			end
			// I_Type logic
			`ANDI, `XORI, `LUI, `ORI, `ADDI, `ADDIU, `SLTI, `SLTIU: 
				sigs <= {15'b0_1_0_1_0_0_0_0_0_0_0_0_0_0_0};

			// 分支跳转指令
			`J: sigs <= {15'b0_0_0_0_0_0_0_1_0_0_0_0_0_0_0};
			`JAL: sigs <= {15'b0_0_0_1_0_0_0_0_1_0_0_0_0_0};
			`BEQ, `BGTZ, `BLEZ, `BNE, `BLTZ, `BGEZ:
				sigs <= {15'b0_0_0_0_0_0_1_0_0_0_0_0_0_0_0};
			`BLTZAL, `BGEZAL:
				sigs <= {15'b0_0_0_0_0_0_1_0_0_0_1_0_0_0_0};

			// 访存指令
			`LW: sigs <= {15'b0_1_1_1_1_0_0_0_0_0_0_0_0_0_0};
			`SW: sigs <= {15'b0_1_0_0_1_1_0_0_0_0_0_0_0_0_0};
			
			default: begin
				sigs <= 15'b0000_0000_0000_000;
			end
		endcase
	end
endmodule
