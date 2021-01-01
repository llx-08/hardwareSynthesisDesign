`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/31 10:38:24
// Design Name: 
// Module Name: saveData_Mask
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

module saveData_Mask(
    input  wire [5:0]  op,
	input  wire [31:0] addr, 
    output reg [3:0]  write_mask,
	output reg address_error
    );

    always @(*) begin
        case(op)
        `EXE_SW_OP: begin
                    address_error <= (addr[1:0] == 2'b00) ? 1'b0 : 1'b1;
                    write_mask    <= 4'b1111;
                end
                    

        `EXE_SH_OP: begin
                    address_error <= (addr[0] == 1'b0) ? 1'b0 : 1'b1;
                    write_mask    <= (addr[1] == 1'b0) ? 4'b0011 : 4'b1100;
                end 

        `EXE_SB_OP:
                    write_mask <= (addr[1:0] == 2'b00) ? 4'b0001 : 
                                  (addr[1:0] == 2'b01) ? 4'b0010 :
                                  (addr[1:0] == 2'b10) ? 4'b0100 : 4'b1000;
        endcase
    end
endmodule
