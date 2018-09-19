`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2018 09:48:20 PM
// Design Name: 
// Module Name: display
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


module display(
input clk,rst,
input [9:0] m,
input [3:0] m_dec,
input [9:0] f,
output reg [7:0] sel,
output reg [7:0] digs_m,
output reg [7:0] digs_f
    );
    
    // divide the frequency(50MHz) by exp(2,16)(16 digs)
    parameter N=19;
    reg[N-1:0] fre_div;
    
    reg [15:0] m_BCD, f_BCD;
    reg [9:0] t1;
        always @ *
            begin
            /*
                t1=m;
                m_BCD[15:12]=t1/17'd1000;
                t1=(t1-m_BCD[15:12]*17'd1000);
                m_BCD[11:8]=t1/17'd100;
                t1=(t1-m_BCD[11:8]*17'd100);
                m_BCD[7:4]=t1/17'd10;  
                t1=(t1-m_BCD[7:4]*17'd10);
                m_BCD[3:0]=t1;
                */
                t1=m;
                m_BCD[15:12]=t1/17'd100;
                t1=(t1-m_BCD[15:12]*17'd100);
                m_BCD[11:8]=t1/17'd10;
                t1=(t1-m_BCD[11:8]*17'd10);
                m_BCD[7:4]=t1;
 
                m_BCD[3:0]=m_dec;
            end
    
    reg [9:0] t2;
    always @ *
            begin
                t2=f;
                f_BCD[15:12]=t2/17'd1000;
                t2=(t2-f_BCD[15:12]*17'd1000);
                f_BCD[11:8]=t2/17'd100;
                t2=(t2-f_BCD[11:8]*17'd100);
                f_BCD[7:4]=t2/17'd10;  
                t2=(t2-f_BCD[7:4]*17'd10);
                f_BCD[3:0]=t2;
            end
    
    always @ (posedge clk or posedge rst)
        begin
            if(rst) fre_div <= 0;
            else fre_div <= fre_div + 1;
        end
        
    reg dp;
    reg [3:0] temp;
    always @ *
        begin
            case(fre_div[N-1:N-3])
            // miles
                3'b000:
                    begin
                        sel = 8'b00010000;
                        temp = m_BCD[3:0];
                        dp = 1'b0;
                    end
                3'b001:
                    begin
                        sel = 8'b00100000;
                        temp = m_BCD[7:4];
                        dp = 1'b1;
                    end
                3'b010:
                    begin
                        sel = 8'b01000000;
                        temp = m_BCD[11:8];
                        dp = 1'b0;
                    end
                3'b011:
                    begin
                         sel = 8'b10000000;
                         temp = m_BCD[15:12];
                         dp = 1'b0;
                     end
                     
            // fee
                3'b100:begin sel = 8'b00000001; temp = f_BCD[3:0]; end
                3'b101:begin sel = 8'b00000010; temp = f_BCD[7:4]; end
                3'b110:begin sel = 8'b00000100; temp = f_BCD[11:8]; end
                default: begin sel = 8'b00001000; temp = f_BCD[15:12]; end
                    
            endcase
            
        end
        
        
        
        
        always @ *
                begin
                //if(fre_div[N-1:N-3] == 3'b000 || fre_div[N-1:N-3] == 3'b001 || fre_div[N-1:N-3] == 3'b010 || fre_div[N-1:N-3] == 3'b011 )
                if(fre_div[N-1:N-3] == 3'b001 || fre_div[N-1:N-3] == 3'b010 || fre_div[N-1:N-3] == 3'b011 )
                begin
                    case(temp)
                        4'b0000: digs_m[6:0] = 7'b0111111;
                        4'b0001: digs_m[6:0] = 7'b0000110;
                        4'b0010: digs_m[6:0] = 7'b1011011;
                        4'b0011: digs_m[6:0] = 7'b1001111;
                        4'b0100: digs_m[6:0] = 7'b1100110;
                        4'b0101: digs_m[6:0] = 7'b1101101;
                        4'b0110: digs_m[6:0] = 7'b1111101;
                        4'b0111: digs_m[6:0] = 7'b0000111;
                        4'b1000: digs_m[6:0] = 7'b1111111;
                        default: digs_m[6:0] = 7'b1100111; // 4'd9
                    endcase
                    digs_m[7] = dp;
                end
                    
                else if(fre_div[N-1:N-3] == 3'b100 || fre_div[N-1:N-3] == 3'b101 || fre_div[N-1:N-3] == 3'b110 || fre_div[N-1:N-3] == 3'b111)
                begin
                    case(temp)
                         4'b0000: digs_f[6:0] = 7'b0111111;
                         4'b0001: digs_f[6:0] = 7'b0000110;
                         4'b0010: digs_f[6:0] = 7'b1011011;
                         4'b0011: digs_f[6:0] = 7'b1001111;
                         4'b0100: digs_f[6:0] = 7'b1100110;
                         4'b0101: digs_f[6:0] = 7'b1101101;
                         4'b0110: digs_f[6:0] = 7'b1111101;
                         4'b0111: digs_f[6:0] = 7'b0000111;
                         4'b1000: digs_f[6:0] = 7'b1111111;
                         default: digs_f[6:0] = 7'b1100111; // 4'd9
                     endcase
                     digs_f[7] = 1'b0;
                 end
                 else //fre_div[N-1:N-3] == 3'b000
                 begin
                    case(temp)
                        4'b0000: digs_m[6:0] = 7'b0111111;
                        4'b0001: digs_m[6:0] = 7'b0000110;
                        4'b0010: digs_m[6:0] = 7'b1011011;
                        4'b0011: digs_m[6:0] = 7'b1001111;
                        4'b0100: digs_m[6:0] = 7'b1100110;
                        4'b0101: digs_m[6:0] = 7'b1101101;
                        4'b0110: digs_m[6:0] = 7'b1111101;
                        4'b0111: digs_m[6:0] = 7'b0000111;
                        4'b1000: digs_m[6:0] = 7'b1111111;
                        default: digs_m[6:0] = 7'b1100111; // 4'd9
                    endcase
                    digs_m[7] = dp;
                 end
                                 
                    
                end
        
endmodule
