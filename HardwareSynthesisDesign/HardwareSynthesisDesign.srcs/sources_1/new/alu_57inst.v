`timescale 1ns / 1ps
`include "defines.vh"
`include "defines2.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/28 21:07:13
// Design Name: 
// Module Name: alu_57inst
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


module alu(
		input wire [31:0] a,b,
		input wire [7:0]  op ,

		// input wire [63:0] hilo_input, // 自己添加

		input wire [4:0]  sa , // rs寄存?
		
		// input wire [31:0] pc, 
		// input wire [25:0] j_instr_index,

		output reg [31:0] y,
		output reg zero

		// output reg [31:0] hilo_output, // 自己添加
		// output reg overflow           // 自己添加

		// output reg [63:0] hilo_temp,   // 自己添加
		// output reg zero                // 增加了beq指令，现在表示是否转?
    );

	// reg [32:0] add_resTmp;
	// reg [32:0] sub_resTmp;

	always @(*) begin 
		case (op)
			// memory inst : 这部分ALU应该只是计算访问内存的虚地址
//			`EXE_LB_OP, `EXE_LBU_OP, `EXE_LH_OP, `EXE_LHU_OP, `EXE_LW_OP, `EXE_SB_OP, `EXE_SH_OP, `EXE_SW_OP:y <= sa + {16{offset[15]}, offset};
			// logic inst
			`EXE_AND_OP : y <= a & b;
			`EXE_ANDI_OP: y <= a & b;
			`EXE_OR_OP  : y <= a | b;
			`EXE_XOR_OP : y <= a ^ b;
			`EXE_XORI_OP: y <= a ^ b;
			`EXE_NOR_OP : y <= ~(a | b);
			`EXE_LUI_OP : y <= b << 16; //lui b?16位为立即数，?16位为0
			`EXE_ORI_OP : y <= a | b;
			
			// shift inst
			`EXE_SLL_OP : y <= b << sa;
			`EXE_SLLV_OP: y <= b << a[4:0];
			`EXE_SRL_OP : y <= b >> sa;
			`EXE_SRLV_OP: y <= b >> a[4:0];
			            // 算数右移：空位补?高位
			`EXE_SRA_OP : y <= ({32{b[31]}} << (6'd32 - {1'b0, sa}))     | b >> sa    ;
			`EXE_SRAV_OP: y <= ({32{b[31]}} << (6'd32 - {1'b0, a[4:0]})) | b >> a[4:0];

//			// move inst
			`EXE_MTHI_OP: y <= a; // ?32位为rs，低32位不?
			`EXE_MTLO_OP: y <= a; // ?32位为rs，高32位不?
			`EXE_MFHI_OP: y <= 32'b0;//hilo_input[63:32];
			`EXE_MFLO_OP: y <= 32'b0;//hilo_input[31:0] ;

//			// arithmetic inst, 无符号运算与有符号运算在不检查溢出时相同
			// `EXE_ADD_OP ,`EXE_ADDI_OP : begin
			// 			  add_resTmp <= a + b;
			// 			  y <= add_resTmp[31:0];
			// 			  overflow <= (add_resTmp[31] == add_resTmp[32]) ? 1'b0 : 1'b1;
			// 			  // 31,32位不相等则出现溢?
			// 		end
							
			`EXE_ADDU_OP, `EXE_ADDIU_OP: y <= a + b;

			// `EXE_SUB_OP : begin
			// 			  temp_a <= (a[31] == 1'b1) ? {a[31], ~a[30:0]+1} : a;
			// 			  temp_b <= (b[31] == 1'b1) ? {b[31], ~b[30:0]+1} : b;
			// 			  sub_resTmp <= temp_a - temp_b;
			// 			  y <= sub_resTmp[31:0];
			// 			  overflow <= (sub_resTmp[31] == sub_resTmp[32]) ? 1'b0 : 1'b1;
			// end
						  
			`EXE_SUBU_OP: y <= a - b;
			// `EXE_SLT_OP , `EXE_SLTI_OP : begin 
			// 							 temp_a <= (a[31] == 1'b1) ? {a[31], ~a[30:0]+1} : a;
			// 			  				 temp_b <= (b[31] == 1'b1) ? {b[31], ~b[30:0]+1} : b;

			// 							 y <= (a + (~b + 1) < 0) ? 1'b1 : 1'b0;
			// end
			
			// `EXE_SLTU_OP, `EXE_SLTIU_OP: y <= (a - b < 0)        ? 1'b1 : 1'b0;
			// 除法在除法器里面处理
			// 立即数经过sign_extend扩展?32?

			// branch & jump inst

			// branch
//			`EXE_BEQ_OP : zero <= (a - b == 32'b0) ? 1'b1 : 1'b0;
//			`EXE_BNE_OP : zero <= (a - b == 32'b0) ? 1'b0 : 1'b1; 
//			// 寄存器sa存储的地?�???b? ?
//			`EXE_BGEZ_OP:  zero <= (sa < 0)         ? 1'b0 : 1'b1;
//			`EXE_BGTZ_OP:  zero <= (sa > 0)         ? 1'b1 : 1'b0;
//			`EXE_BLEZ_OP:  zero <= (sa > 0)         ? 1'b0 : 1'b1;
//			`EXE_BLTZ_OP:  zero <= (sa < 0)         ? 1'b1 : 1'b0;
//			`EXE_BGEZAL_OP: zero <= (sa < 0)       ? 1'b0 : 1'b1;
//			`EXE_BLTZAL_OP: zero <= (sa < 0)       ? 1'b1 : 1'b0;

			// j, 同样计算地址
			// `EXE_J_OP, `EXE_JAL_OP : y <= {pc[31:28], j_instr_index << 2};
			// `EXE_JR_OP : y <= sa;
 
			default : y = 32'b0;
		endcase
		// 处理乘法
	end
//		wire [31:0] mult_a;
//		wire [31:0] mult_b;
//		wire [63:0] mult_unsigned;

//		assign mult_a = ((op == `EXE_MULT_OP) && (a[31] == 1'b1)) ? (~a + 1) : a;
//		assign mult_b = ((op == `EXE_MULT_OP) && (b[31] == 1'b1)) ? (~b + 1) : b;
//		assign hilo_temp = ((op == `EXE_MULT_OP) && (a[31] ^ b[31] == 1'b1) ? ~(mult_a * mult_b) + 1 : mult_a * mult_b);

//		assign mult_unsigned = (op == `EXE_MULTU_OP) ? a * b : 0;

endmodule
