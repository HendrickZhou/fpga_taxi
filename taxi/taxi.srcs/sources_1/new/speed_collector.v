`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2018 10:48:12 PM
// Design Name: 
// Module Name: speed_collector
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


module speed_collector(
    input clk100, rst,
    input A_VAUXP,A_VAUXN,
    output [9:0] speed_value
    );
    
    // global clock signal for the ug480 adc module
    wire DCLK;
    // output value
    wire[15:0]MEASURED_TEMP,MEASURED_VCCINT,MEASURED_VCCAUX,MEASURED_VCCBRAM,MEASURED_AUX_A;
    // temp value 
    wire[15:0]MEASURED_AUX; 
    
    // convert the clock signal
    clk_wiz_0 u_clk(
    .clk_in1(clk100),
    .clk_out1(DCLK)
    );

    // invoke the ug480 adc module
    ug480 u_xadc(
        .DCLK(DCLK),
        .RESET(!rst),
        . VAUXP({2'b0,A_VAUXP,1'b0}),  //A_VAUX:channel 1 ********   
        . VAUXN({2'b0,A_VAUXN,1'b0}),  // Auxiliary analog channel inputs
       . VP(), 
       . VN(),// Dedicated and Hardwired Analog Input Pair
        
        .MEASURED_TEMP(MEASURED_TEMP), 
        .MEASURED_VCCINT(MEASURED_VCCINT),  
        .MEASURED_VCCAUX(MEASURED_VCCAUX), 
        .MEASURED_VCCBRAM(MEASURED_VCCBRAM), 
        .MEASURED_AUX0(), 
        .MEASURED_AUX1(MEASURED_AUX_A), 
        .MEASURED_AUX2(), 
        . MEASURED_AUX3(), 
    
        . ALM(), 
        .CHANNEL(),       
        . OT(), 
        .EOC(), 
        . EOS()
       );
       
       // get the value of the analog signal(from d0 - d999)
       
       wire[3:0] Units,decimal1 ,decimal2,decimal3;
       assign Units = MEASURED_AUX[15:4]/4096;
       assign decimal1 = MEASURED_AUX[15:4]*10/4096;
       assign decimal2 = (MEASURED_AUX[15:4]*10 - (MEASURED_AUX[15:4]*10/4096*4096))*10/4096;
       assign decimal3 = (MEASURED_AUX[15:4]*100 - (MEASURED_AUX[15:4]*10/4096)*4096*10 - ( (MEASURED_AUX[15:4]*10 - (MEASURED_AUX[15:4]*10/4096*4096))*10/4096)*4096)*10/4096;
       
       assign speed_value = decimal1*100 + decimal2*10 + decimal3;
       assign MEASURED_AUX = MEASURED_AUX_A;
       //assign speed_dig = {Units,decimal1,decimal2,decimal3};
    
endmodule
