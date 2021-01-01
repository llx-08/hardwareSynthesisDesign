`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/28 16:15:45
// Design Name: 
// Module Name: aludec_57inst
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


module aludec(
	input  wire [5:0] op,
	input  wire [5:0] funct,
	output wire [7:0] alucontrol
    );
	
	
	assign alucontrol = (op == 6'b000000) ? (  
						// 判断op�?6'b000000�? logic instruction 
						(funct == `EXE_ADD)    ? `EXE_ADD_OP    : // add指令
						(funct == `EXE_OR)     ? `EXE_OR_OP     : // or指令
						(funct == `EXE_XOR)    ? `EXE_XOR_OP    : // xor指令
						(funct == `EXE_NOR)    ? `EXE_NOR_OP    : // nor指令
						// 判断op�?6'b000000的移位指�? 
						(funct == `EXE_SLL)    ? `EXE_SLL_OP    :
						(funct == `EXE_SRL)    ? `EXE_SRL_OP    :
						(funct == `EXE_SRA)    ? `EXE_SRA_OP    :
						(funct == `EXE_SLLV)   ? `EXE_SLLV_OP   :
						(funct == `EXE_SRLV)   ? `EXE_SRLV_OP   :
						(funct == `EXE_SRAV)   ? `EXE_SRAV_OP   :
						// 判断op�?6'b000000的数据移动指�?
						(funct == `EXE_MFHI)   ? `EXE_MFHI_OP   :
						(funct == `EXE_MFLO)   ? `EXE_MFLO_OP   :
						(funct == `EXE_MTHI)   ? `EXE_MTHI_OP   :
						(funct == `EXE_MTLO)   ? `EXE_MTLO_OP   :
						// 判断op�?6'b000000的算术运算指�?
						(funct == `EXE_ADD)    ? `EXE_ADD_OP    :
						(funct == `EXE_ADDU)   ? `EXE_ADDU_OP   :
						(funct == `EXE_SUB)    ? `EXE_SUB_OP    :
						(funct == `EXE_SUBU)   ? `EXE_SUBU_OP   :
						(funct == `EXE_SLT)    ? `EXE_SLT_OP    :
						(funct == `EXE_SLTU)   ? `EXE_SLTU_OP   :
						(funct == `EXE_MULT)   ? `EXE_MULT_OP   :
						(funct == `EXE_MULTU)  ? `EXE_MULTU_OP  :
						(funct == `EXE_DIV)    ? `EXE_DIV_OP    :
						(funct == `EXE_DIVU)   ? `EXE_DIVU_OP   :
						// 判断op�?6'b000000的分支跳转指�?
						(funct == `EXE_JR)     ? `EXE_JR_OP     :
						(funct == `EXE_JALR)   ? `EXE_JALR_OP   :
						// 判断op�?6'b000000的内陷指�? 
						(funct == `EXE_SYSCALL)? `EXE_SYSCALL_OP: `EXE_BREAK_OP ) :
						// (funct == `EXE_BREAK)  ? 
						
						// 可以直接由op确定的logic instructions
						(op == `EXE_ANDI) ? `EXE_ANDI_OP :
						(op == `EXE_ORI)  ? `EXE_ORI_OP  :
						(op == `EXE_XORI) ? `EXE_XORI_OP :
						(op == `EXE_LUI)  ? `EXE_LUI_OP  :

						// 可以直接由op确定的arithmetic instructions
						(op == `EXE_ADDI) ? `EXE_ADDI_OP :
						(op == `EXE_ADDIU)? `EXE_ADDIU_OP:
						(op == `EXE_SLTI) ? `EXE_SLTI_OP :
						(op == `EXE_SLTIU)? `EXE_SLTIU_OP:

						// 可直接�?�过op确定的访问存�? inst
						(op == `EXE_LB)   ? `EXE_LB_OP   :
						(op == `EXE_LBU)  ? `EXE_LBU_OP  :
						(op == `EXE_LH)   ? `EXE_LH_OP   :
						(op == `EXE_LHU)  ? `EXE_LHU_OP  :
						(op == `EXE_LW)   ? `EXE_LW_OP   :
						(op == `EXE_SB)   ? `EXE_SB_OP   :
						(op == `EXE_SH)   ? `EXE_SH_OP   : `EXE_SW_OP;
						// (op == `EXE_SW)   ?    :

						// // 特权指令
						// (op == `EXE_MTC0) 

endmodule
