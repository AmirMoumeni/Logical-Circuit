`timescale 1ns/1ns
module ALU (input [15:0] A,B, input C, input [2:0]opc , output reg[15:0]w , output reg neg,zer);
always @(opc , A ,B, C ,w)begin
w=16'b0;
neg=1'b0;
zer=1'b0;
case(opc)
3'd0: w=~A+1'b1;
3'd1: w=A+1'b1;
3'd2: w= A+B+C;
3'd3: w=A+ (B>>1'b1);
3'd4: w=A&B;
3'd5: w=A|B;
3'd6: w={A[7:0] , B[7:0]};
endcase
zer = w == 0;
neg = w[15];


end
endmodule
