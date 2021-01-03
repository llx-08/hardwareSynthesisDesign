`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 10:13:05
// Design Name: 
// Module Name: pc
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


module pc(
	input wire clk, rst, en,
	input wire [31:0] din,
	output reg [31:0] q
    );
	always @(posedge clk) begin
		if(rst) q <= 32'b0;
		else if(en) begin
			q <= din;
		end
		else begin
			q <= q;//这里为啥视频里是q <= 32'b0？
		end
	end
endmodule
