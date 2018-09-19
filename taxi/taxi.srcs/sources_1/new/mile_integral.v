`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2018 07:58:06 PM
// Design Name: 
// Module Name: mile_integral
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


module mile_integral(
    input clk,
    input rst,
    input [9:0] speed,
    output[9:0] miles,
    output[3:0] h_miles
    );
    
    parameter meter_raw_ratio = 500000000;//50 0000000
    
    
    // use the miles_dec to handle the dec
    // from 0 - 2^30, over 10^9
    reg [29:0] miles_dec;
    // to record the miles as meter(from 0-2^20 about 1000 km)
    //reg [19:0] miles_meter;
    // use two reg to marginlly reduce the size we need
    reg [9:0] miles_m;
    reg [3:0] miles_hm;
    reg [9:0] miles_km;
    
    // 1. calculate the dec
    // when the miles_dec is large than ratio(the value responding to 1 actual meter)
    // enumlate the meter
    always @ (posedge clk or posedge rst)
        begin
            if(rst) begin miles_dec <= 0; miles_m <=0; miles_km <= 0; end
            else if(miles_dec >= meter_raw_ratio)
                    begin
                        
                        miles_dec <= 0;
                        
                        if(miles_m == 1000)
                            begin
                                // !!!!!!!!!!!! to do : add km top value
                                miles_km <= miles_km + 1;
                                miles_m <= 0;
                            end
                        else 
                            if(miles_m/100 == 0) 
                            begin
                                    if(miles_hm == 9)
                                        miles_hm <= 0;
                                    else
                                        miles_hm <= miles_hm + 1;
                                    miles_m <= miles_m + 1;
                            end
                            else 
                                miles_m <= miles_m + 1;
                    end
                else
                    begin
                        miles_dec <= miles_dec + speed; // !!!!!!!!!!!
                    end
        end
        
    assign miles = miles_km;
    assign h_miles = miles_hm;
        
endmodule
