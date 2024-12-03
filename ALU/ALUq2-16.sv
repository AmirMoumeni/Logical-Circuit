`timescale 1ns/1ns
module ALUq2 (input [15:0] A,B, input C, input [2:0]opc , output reg[15:0]w , output reg neg,zer); 
reg [15:0]add1 , add2, shb;
assign shb=B>>1;
assign a1 = (opc==3'b000) ?~A : A;  
assign a2 =(opc==3'b010) ? (A+B) :(opc == 3'b011) ? ({B[15],shb[14:0]}) : 1'b1;
always @(opc , A ,B ,C , w)begin
w=0;
zer =0;
neg =0;

case(opc)

3'd4: w = A&B; 
3'd5: w = A|B; 
3'd6: w={A[7:0] , B[7:0]};
default: w=a1 + a2;
endcase
zer = w == 0;
neg = w[15];


end
endmodule