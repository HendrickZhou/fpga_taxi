`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2018 07:52:55 PM
// Design Name: 
// Module Name: fare
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


module fare(
    input [9:0] miles,
    input clk,
    input rst,
    output [9:0] fee
    );
    
        reg [9:0] temp_fee;
        parameter base_fee = 15, base_miles = 5, l1_miles = 25;
        parameter l0_fee = 2; // (level_0 fee, miles between 15 & 25, 2 yuan per mile)
        parameter l1_fee = 3; // (level_1 fee, miles over 25, 3 yuan per mile)
    
    always @(posedge clk or posedge rst)
        begin
            // if reset, clear the fee
            if(rst) temp_fee <= 0;
            
            //else, calculate them
            else if(miles <= base_miles) temp_fee <= base_fee;
                    else if(miles <= l1_miles) temp_fee <= base_fee + (miles - base_miles)*l0_fee;
                    else temp_fee <= base_fee + (l1_miles - base_miles)*l0_fee + (miles - l1_miles)*l1_fee;
        end
        assign fee = temp_fee;
    
endmodule
