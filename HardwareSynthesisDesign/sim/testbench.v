`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 13:54:42
// Design Name: 
// Module Name: testbench
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


module testbench();
	reg clk;
	reg rst;

	wire [31:0] instr_out,writedata,dataadr,aluoutbefore,pc_out,out_pc_next_jump;//
	wire [31:0] SrcAEout,SrcBEout;
	wire memwrite,out_regwrite,out_zero,out_branch;

	top test(
		.clka(clk),
		.rst(rst),
		.writedata(writedata),
		.dataadr(dataadr),
		.dataadr_before(aluoutbefore),
		.memwrite(memwrite),
		// .out_regwrite(out_regwrite),
		// .pc_out(pc_out),
		// .out_pc_next_jump(out_pc_next_jump),
		.instr_out(instr_out)
		// .out_pcsrc(out_pcsrc),
		// .out_zero(out_zero),
		// .out_branch(out_branch),
		// .out_jump(out_jump),
		// .SrcAEout(SrcAEout),
		// .SrcBEout(SrcBEout)
		);

	initial begin 
		rst <= 1;
		#200;
		rst <= 0;
	end

	always begin
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	end

	// always @(negedge clk) begin
	// 	if(memwrite) begin
	// 		/* code */
	// 		if(dataadr === 84 & writedata === 7) begin
	// 			/* code */
	// 			$display("Simulation succeeded");
	// 			$stop;
	// 		end else if(dataadr !== 80) begin
	// 			/* code */
	// 			$display("Simulation Failed");
	// 			$stop;
	// 		end
	// 	end
	// end
endmodule
