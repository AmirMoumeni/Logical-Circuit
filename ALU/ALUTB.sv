`timescale 1ns/1ns
module ALUTB;
reg [15:0] A,B;
reg C;
reg [2:0] opc;
wire [15:0] w,wp,w2;
wire zer , neg,zerp , negp ,zer2 , neg2;

ALU16b UUT1(.opc(opc), .A(A) , .B(B) , .C(C) , .w(w) , .zer(zer) , .neg(neg));
ALU UUT2(.opc(opc), .A(A) , .B(B) , .C(C) , .w(wp) , .zer(zerp) , .neg(negp));
ALUq2s UUT3(.opc(opc), .A(A) , .B(B) , .C(C) , .w(w2) , .zer(zer2) , .neg(neg2));


initial begin 
A= 16'b0; B=16'b0; C=2'b0; opc= 3'b0;

repeat (10) #500 begin 
A = $random() ;
B = $random() ;
C = $random() ;
opc = $random ();
end 
$stop;
end
endmodule

