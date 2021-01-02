`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/30 15:53:08
// Design Name: 
// Module Name: loadData_byteSelect
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

module loadData_byteSelect( // 该模块用于选择load data 中取整个字，还是取其中的某个byte或halfword
	input  wire [5:0]  op,
	input  wire [31:0] read_data,
	input  wire [31:0] addr, 

	output reg [31:0]final_data,
	output reg address_error // 是否产生地址错误（未对齐
    );

	always @(*) begin 
		
		case (op)

			`EXE_LW : begin

				address_error <= (addr[1:0] == 2'b00) ? 1'b0 : 1'b1;
				final_data <= read_data;
			end

			`EXE_LB: begin
				$display("reached lb");
				case (addr[1:0])
					2'b00: final_data <= {{24{read_data[31]}}, read_data[31:24]};
					2'b01: final_data <= {{24{read_data[23]}}, read_data[23:16]};
					2'b10: final_data <= {{24{read_data[15]}}, read_data[15:8]};
					2'b11: final_data <= {{24{read_data[7]}} , read_data[7:0]};
				
					default : /* default */;
				endcase
			end

			`EXE_LBU: begin
				case (addr[1:0])
					2'b00: final_data <= {{24{0}}, read_data[31:24]};
					2'b01: final_data <= {{24{0}}, read_data[23:16]};
					2'b10: final_data <= {{24{0}}, read_data[15:8]};
					2'b11: final_data <= {{24{0}}, read_data[7:0]};
				
					default : /* default */;
				endcase
			end

			`EXE_LH: begin

				address_error <= (addr[0] == 1'b0) ? 1'b0 : 1'b1;

				case (addr[1])
					1'b0: final_data <= {{16{read_data[15]}}, read_data[15:0]};
					1'b1: final_data <= {{16{read_data[31]}}, read_data[31:16]};
					
					default : /* default */;
				endcase
			end

			`EXE_LHU: begin

				address_error <= (addr[0] == 1'b0) ? 1'b0 : 1'b1;

				case (addr[1])
					1'b0: final_data <= {{16{0}}, read_data[15:0]} ;
					1'b1: final_data <= {{16{0}}, read_data[31:16]};
					
					default : /* default */;
				endcase

			end

			default : /* default */;
		endcase

	end
endmodule
