`timescale 1ns/1ns
module ALU_Post_Synth (input signed [15:0] inM,inN, input inC, input [2:0]opc , output reg signed [15:0]outF , output reg neg,zer);
wire [15:0] Mx , incr , Rshift , Lshift ,adder;
assign incr = inC + inN ;
assign Rshift = inN >> 1;
assign Lshift = inM << 1;
assign Mx = (opc == 3'b000) ? incr:
	    (opc == 3'b001) ? Rshift:
	    (opc == 3'b011) ? Lshift: 16'bZ;
assign adder = inM + Mx;
always @(opc , inM ,inN, inC )begin
outF=16'b0;
neg=1'b0;
zer=1'b0;
case(opc)
3'd0: outF= adder;
3'd1: outF= adder;
3'd2: outF= inM>inN ?inM:inN ;
3'd3: outF= adder;
3'd4: outF= inM & inN;
3'd5: outF= inM | inN;
3'd6: outF= ~inM ;
3'd7: outF= 16'b0 ;
endcase 
end
endmodule 
