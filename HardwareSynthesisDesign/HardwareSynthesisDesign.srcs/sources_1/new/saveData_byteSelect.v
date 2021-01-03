`timescale 1ns / 1ps
`include "defines.vh"
`include "defines2.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 16:32:03
// Design Name: 
// Module Name: saveData_byteSelect
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


module saveData_byteSelect(
	input  wire [5:0]  op,
	input  wire [31:0] save_data,
	input  wire [31:0] addr, 

	output reg [31:0]final_data,
	output reg address_error // 是否产生地址错误（未对齐�?
    );

	always @(*) begin 
		case (op)

			`EXE_SW_OP : begin
				address_error <= (addr[1:0] == 2'b00) ? 1'b0 : 1'b1;
				final_data <= save_data;
			end
        endcase
    end
endmodule
