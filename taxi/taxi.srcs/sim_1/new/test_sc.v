`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2018 04:25:31 PM
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

    );
    
    reg clk100, RESET;,
    wire [9:0] speed;
    reg A_VAUXP,A_VAUXN;
    speed_collector a(
        .clk(clk100),
        .clk(RESET),
        .A_VAUXP(A_VAUXP),
        .A_VAUXN(A_VAUXP),
        .speed_value(speed)
        );
    
    initial begin
          clock = 0;
          forever #5 clock = ~clock;
          end

    initial 
    begin
        
    end
    
    
endmodule
