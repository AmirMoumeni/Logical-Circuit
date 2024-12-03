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
//ALU Design without trying to minimize Structure

module ALUTB;
reg [15:0] M,N;
reg C;
reg [2:0] opc;
wire [15:0] F,F_post,F_yosys_1 , F_yosys_2;
wire zer , neg , zer_post , neg_post , zer_yosys_1 , neg_yosys_1 , zer_yosys_2 , neg_yosys_2;

ALU UUT1(.opc(opc), .inM(M) , .inN(N) , .inC(C) , .outF(F) , .zer(zer) , .neg(neg));
ALU_yoosys_1 UUT2(.opc(opc), .inM(M) , .inN(N) , .inC(C) , .outF(F_yosys_1) , .zer(zer_yosys_1) , .neg(neg_yosys_1));
ALU_Post_Synth UUT3(.opc(opc), .inM(M) , .inN(N) , .inC(C) , .outF(F_post) , .zer(zer_post) , .neg(neg_post));
ALU_Yoosys_2 UUT4(.opc(opc), .inM(M) , .inN(N) , .inC(C) , .outF(F_yosys_2) , .zer(zer_yosys_2) , .neg(neg_yosys_2));

initial begin 
M= 16'b0; N=16'b0; C=2'b0; opc= 3'b0;

repeat (30) #500 begin 
M = $random() ;
N = $random() ;
C = $random() ;
opc = $random ();
end 
$stop;
end
endmodule
//TestBench For all Circuits

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
//ALU Design after trying to minimize Structure










