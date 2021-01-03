`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 13:50:53
// Design Name: 
// Module Name: top
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


module top(
	input wire clka,rst,
	output wire[31:0] writedata,dataadr,
	output wire memwrite,
	output wire out_regwrite,
	output wire [31:0] instr_out,SrcAEout,SrcBEout,
	output wire [31:0] pc_out,out_pc_next_jump,dataadr_before,
	output wire out_pcsrc,out_zero,out_branch,out_jump
    );

	wire[31:0] pc,instr,mem_rdata,mem_wdata,
				alu_result,aluoutbefore;
	wire inst_ram_ena, data_ram_ena;
	wire data_ram_wea;
	wire [3:0] write_mask;
	// wire [31:0] pc, instr;

	assign pc_out = pc;
	assign instr_out = instr;
	assign writedata = mem_wdata;
	assign dataadr = alu_result;
	assign dataadr_before = aluoutbefore;
	assign memwrite = data_ram_ena;
	
	
	//inst_ram
	inst_ram iram (
  		.clka(~clka),    // input wire clka
  		.ena(1'b1),      // input wire ena   //硬综这里改过，本来是1‘b1，现在改为rst取反
  		.wea(4'b0000),      // input wire [3 : 0] wea
 		// .addra({2'b00,pc[7:2]}),  // input wire [7 : 0] addra
		.addra({pc}), // 自己修改
 		.dina(32'b0),    // input wire [31 : 0] dina
 		.douta(instr)  // output wire [31 : 0] douta
	);

	//data_ram
	data_ram dram (
  		.clka(~clka),    // input wire clka
  		.ena(data_ram_ena),      // input wire ena
  		.wea(write_mask),     // // input wire [3 : 0] wea
  		// wea为1时为写入，wea为0时读取
  		//写的时候是4'b1 因为选中了按字节读写
  		// .addra(alu_result[9:0]),  // input wire [9 : 0] addra
  		.addra({alu_result[31:2],{2'b00}}),//{alu_result[31:2],{2'b00}}
		.dina(mem_wdata),    // input wire [31 : 0] dina
  		.douta(mem_rdata)  // output wire [31 : 0] douta
	);	

	// always @(*) begin
	// 	$display("write data test : %h", mem_wdata);
	// 	$display("read data test  : %h", mem_rdata);
	// end

	mips u(
		.clka(clka),
		.rst(rst),
		.instr(instr),
		.mem_rdata(mem_rdata),
		.data_ram_wea(data_ram_wea),
		.inst_ram_ena(inst_ram_ena),
		.data_ram_ena(data_ram_ena),
		.pc(pc),
		.alu_result(alu_result),
		.aluoutbefore(aluoutbefore),
		.out_pc_next_jump(out_pc_next_jump),
		.out_regwrite(out_regwrite),
		.mem_wdata(mem_wdata),
		.out_pcsrc(out_pcsrc),
		.out_zero(out_zero),
		.out_branch(out_branch),
		.out_jump(out_jump),
		.SrcAEout(SrcAEout),
		.SrcBEout(SrcBEout),

		.write_mask(write_mask)
		);
endmodule
