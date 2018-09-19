`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2018 04:08:50 PM
// Design Name: 
// Module Name: top_sim
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


module top_sim(

    );
    
    reg clk100, RESET;,
    wire [11:0] seg;
    reg A_VAUXP,A_VAUXN;
    taxi_top taxi_top(.clk100(clk100),.RESE(RESET),.seg(seg),.A_VAUXP(A_VAUXP),.A_VAUXN(A_VAUXN)
    );
    initial begin
      clock = 0;
      forever #5 clock = ~clock;
      end
      initial begin
          RESET=0;
           
         #200
          
         #100
          
         #500
          
        end

endmodule
