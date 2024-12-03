`timescale 1ns/1ns
module ALU (input signed [15:0] inM,inN, input inC, input [2:0]opc , output reg signed [15:0]outF , output reg neg,zer);
always @(opc , inM ,inN, inC )begin
outF=16'b0;
neg=1'b0;
zer=1'b0;
case(opc)
3'd0: outF= inM+ inN + inC;
3'd1: outF= inM+ (inN>>1'b1);
3'd2: outF= inM>inN ?inM:inN ;
3'd3: outF= (inM<<1'b1) + inM;
3'd4: outF= inM & inN;
3'd5: outF= inM | inN;
3'd6: outF= ~inM ;
3'd6: outF= 16'b0 ;
endcase
zer = outF == 0;
neg = outF[15];
end 
endmodule 
