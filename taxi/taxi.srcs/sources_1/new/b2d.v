`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2018 02:02:02 PM
// Design Name: 
// Module Name: b2d
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


module b2d(
    input [9:0] inData,
    input inClk,
    //input rst,
    output [15:0] outData
    );
      
      
      reg     [3:0]count10 = 9;
      reg     [15:0]ShiftReg;
      
      
          always@(posedge inClk)
          begin
              if(count10 >= 0 && count10 <= 9)
              begin
                  count10 <= count10 - 1'b1;      
              end
              else
                  count10 <= 4'd15;
          end
      
          always @(posedge inClk)
          begin
              //for(i = 9; i >= 0; i = i - 1)
              if(count10 >= 0 && count10 <= 9)
             begin
                  // shift left 
                  ShiftReg = (ShiftReg << 1);
                  ShiftReg[0] = inData[count10];
                  //adjust by add 3
                  if(ShiftReg[15:12] > 4)
                      ShiftReg[15:12] = ShiftReg[15:12] + 2'd3;
                 else
                      ShiftReg[15:12] = ShiftReg[15:12];
                  
                  if(ShiftReg[11:8] > 4)
                      ShiftReg[11:8] = ShiftReg[11:8] + 2'd3;
                  else
                      ShiftReg[11:8] = ShiftReg[11:8];            
              
                  if(ShiftReg[7:4] > 4)
                     ShiftReg[7:4] = ShiftReg[7:4] + 2'd3;
                  else
                     ShiftReg[7:4] = ShiftReg[7:4];
              
                  if(ShiftReg[3:0] > 4)
                      ShiftReg[3:0] = ShiftReg[3:0] + 2'd3;
                  else
                      ShiftReg[3:0] = ShiftReg[3:0];        
              
                              
              end
              else
                  ShiftReg = ShiftReg;
          end
      
              assign outData = ShiftReg;
    
endmodule
