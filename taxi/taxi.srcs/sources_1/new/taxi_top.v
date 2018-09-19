`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2018 11:15:01 PM
// Design Name: 
// Module Name: taxi_top
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


module taxi_top(
input clk100,RESET,
//input stop
output [7:0] sel,
output [7:0] digs_m,
output [7:0] digs_f,
input A_VAUXP,A_VAUXN
    );
    
    // from 0-999
    wire [9:0] speed;
    
    // collect the speed from the adc module
    speed_collector sc(
    // input
    .clk100(clk100),
    .rst(RESET),
    .A_VAUXP(A_VAUXP),
    .A_VAUXN(A_VAUXN),
    // output
    .speed_value(speed)
    );
    
    // from 0 - 999
    wire [9:0] miles;
    wire [3:0] h_miles;   
    // calculate the miles
    mile_integral mi(
    // input
    .clk(clk100),
    .rst(~RESET),
    .speed(speed),
    // output
    .miles(miles),
    .h_miles(h_miles)
    );
    
    
    wire [9:0] fee;
    // calculate the fee
    fare f(
    // input 
    .clk(clk100),
    .rst(~RESET),
    .miles(miles),
    // output
    .fee(fee)
    );
    
    // display the numbers
    //wire [7:0] sel;
    //wire [7:0] digs_m, digs_f;
    
    
    display dis(
    .clk(clk100),
    .rst(~RESET),
    .m(miles),
    .m_dec(h_miles),
    .f(fee),
    .sel(sel),
    .digs_m(digs_m),
    .digs_f(digs_f)
    );
    
    
endmodule
