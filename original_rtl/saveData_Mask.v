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
    input  wire [31:0] write_data,

    output reg [31:0] final_data,
    output reg [3:0]  write_mask,
	output reg address_error
    );

    // wire [5:0] op;
	// assign op = instrM[31:26];

    always @(*) begin
        case(op)
        // 第一种
        `EXE_SW: begin
                    address_error <= (addr[1:0] == 2'b00) ? 1'b0 : 1'b1;
                    final_data    <= write_data;
                    write_mask    <= 4'b1111;
                end
                    

        `EXE_SH: begin
                    address_error <= (addr[0] == 1'b0) ? 1'b0 : 1'b1;
                    write_mask    <= (addr[1] == 1'b0) ? 4'b0011 : 4'b1100;
                    final_data    <= {write_data[15:0], write_data[15:0]};

                end 

        `EXE_SB: begin
                    // $display("SB INST");
                    // $display("addr last 2 bits: %b",addr[1:0]);
                    // $display("opcode : %b",op);
                    write_mask <= (addr[1:0] == 2'b00) ? 4'b0001 : 
                                  (addr[1:0] == 2'b01) ? 4'b0010 :   //z这里反向操作过
                                  (addr[1:0] == 2'b10) ? 4'b0100 : 4'b1000;
                    final_data    <= {write_data[7:0],write_data[7:0],write_data[7:0],write_data[7:0]};
                    // $display("write mask: %b",write_mask);
                    // $display(write_mask);
                end



        // 第二种
        // `EXE_SW: begin
        //             address_error <= (addr[1:0] == 2'b00) ? 1'b0 : 1'b1;
        //             final_data    <= write_data;
        //             write_mask    <= 4'b1111;
        //         end
                    

        // `EXE_SH: begin
        //             address_error <= (addr[0] == 1'b0) ? 1'b0 : 1'b1;
        //             final_data    <= {write_data[15:0], write_data[15:0]};
        //             write_mask    <= (addr[1] == 1'b0) ? 4'b0011 : 4'b1100;
        //         end 

        // `EXE_SB: begin
        //             // $display("SB INST");
        //             // $display("addr last 2 bits: %b",addr[1:0]);
        //             // $display("opcode : %b",op);
        //             write_mask <= (addr[1:0] == 2'b00) ? 4'b0001 : 
        //                           (addr[1:0] == 2'b01) ? 4'b0010 :
        //                           (addr[1:0] == 2'b10) ? 4'b0100 : 4'b1000;
        //             final_data    <= {write_data[7:0],write_data[7:0],write_data[7:0],write_data[7:0]};
        //             // $display("write mask: %b",write_mask);
        //             // $display(write_mask);
        // end


        default:    begin
            final_data <= write_data;
            write_mask <= 4'b0000;
        end
        endcase
        end

endmodule
