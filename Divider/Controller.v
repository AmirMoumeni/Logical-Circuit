module Controler (input clk , rst, START ,countCo , output reg ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn ,READY);
parameter Idle = 3'd0 , Starting = 3'd1 , Load = 3'd2 , Shift = 3'd3 , Minuse =3'd4 ;
reg [2:0] ps , ns = 3'd0;
always @(ps, START, countCo)begin
{ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn ,READY} = 10'b0;
case (ps)
Idle : begin ns = (START) ? Starting : Idle ; 
	READY =1; end
Starting : begin ns = (START) ? Starting : Load;
end
Load : begin ns = Shift;
	{initA ,ldQ ,ldM ,initCount ,ldDividend } =5'b11111; end
Shift : begin ns = Minuse; 
	{ldA ,ldQ , ldshift ,countEn } = 4'b1111; end	

Minuse : begin ns = (countCo) ? Idle : Shift ;
	{ldA , ldSub } =2'b11; end
default ns = 3'b0;
endcase 
end
always @(posedge clk, posedge rst) begin
		if (rst) ps <= 3'b 000;
		else ps <= ns;
	end
endmodule
