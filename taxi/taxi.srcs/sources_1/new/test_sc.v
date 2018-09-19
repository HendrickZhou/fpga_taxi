`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2018 04:40:06 PM
// Design Name: 
// Module Name: test_sc
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


module test_sc(
input clk100,RESET,
//input stop
output [3:0] s_sel,
output [7:0] s_digs,
input A_VAUXP,A_VAUXN
    );
    
    wire clk100, RESET;
    wire [9:0] speed;
    wire A_VAUXP,A_VAUXN;
    speed_collector a(
            .clk100(clk100),
            .rst(RESET),
            .A_VAUXP(A_VAUXP),
            .A_VAUXN(A_VAUXP),
            .speed_value(speed)
            );
            
       wire [15:0] speed_BCD;
            b2d b(
            .inClk(clk100),
            .inData(speed),
            .outData(speed_BCD)
            );
 
 
        wire [3:0] s_sel;
            wire [3:0] s_digs;
    display d1(
               .clk(clk100),
               .rst(RESET),
               .d(speed_BCD),
               .sel(s_sel),
               .digs(s_digs)
               );
            
endmodule
