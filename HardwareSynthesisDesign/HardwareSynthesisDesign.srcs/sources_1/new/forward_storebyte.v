`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/03 01:38:32
// Design Name: 
// Module Name: forward_storebyte
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


module forward_storebyte(
    input wire [5:0] opcode,
    input wire [3:0] write_maskE,
    input wire [31:0] writedataE,
    output wire [31:0] data_aftermask
    );

    assign data_aftermask = (write_maskE == 4'b1111)? 
                            (write_maskE == 4'b0001)? {24'b0, alu_result[7:0]}:
                            (write_maskE == 4'b0010)? {16'b0, alu_result[15:8], 8'b0} :
                            (write_maskE == 4'b0100)? {8'b0,alu_result[23:16], 16'b0} :
                            (write_maskE == 4'b1000)? {alu_result[31:24], 24'b0} :
                            32'b0;
endmodule
