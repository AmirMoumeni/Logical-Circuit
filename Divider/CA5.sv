`timescale 1ns/1ns
 module Q_reg(input clk, rst, cen ,incrmnt, input [7:0] pin, output reg [7:0] pout);
	always @(posedge clk, posedge rst) begin
		if (rst) pout <= 8'b0;
		else if (cen) pout <= pin;
		else if (incrmnt)pout <= pout +1 ;
		else pout <= pout;
	end
endmodule

module M_reg(input clk, rst, cen, input [7:0] pin, output reg [7:0] pout);
	always @(posedge clk, posedge rst) begin
		if (rst) pout <= 8'b0;
		else if (cen) pout <= pin;
		else pout <= pout;
	end
endmodule

module A_reg(input clk, rst, cen, input [7:0] pin, output reg [7:0] pout);
	always @(posedge clk, posedge rst) begin
		if (rst) pout <= 8'b0;
		else if (cen) pout <= pin;
		else pout <= pout;
	end
endmodule

module Mux(input [7:0] a, b, input sla, slb, output [7:0] s);
	assign s = sla ? a:
	           slb ? b: 16'b z;
endmodule

module Subtractor(input [8:0] a, b ,  output logic [15:0] po);
	wire [15:0] b_temp;
	assign b_temp  = ~b + 1'b1;
	assign po = a + b_temp  ;
endmodule

module Shifter (input [15:0] a , output [15:0] out);
assign out = a<<1;
endmodule 

module counter(input cen, iz, clk, rst, output logic [2:0] po, output co);
	wire [3:0] ns;
	logic [3:0] ps;
	assign ns = ps + 1'b1;
	always @(posedge clk, posedge rst) begin
		if(rst) ps <= 4'b 0;
		else if (iz) ps <= 4'b 0;
		else if (cen) ps <= ns;
	end
	assign {co , po} = ps ;
endmodule

module counterTB ();
logic cen=0 , iz=1 , clk=0 , rst=0;
wire [2:0] po;
wire co;
counter uut1(cen , iz , clk , rst , po , co);
always #100 clk = ~clk;
initial begin
#80 cen=1; 
#80 iz=0;

#2000 $stop;
end
endmodule

module DataPath(input clk, rst, ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn,
input [7:0] Dividend_bus , Divisor_bus , output [7:0] quationt , remainder , output countCo );

wire [2:0] count ;
wire [7:0] Qreg , Mreg , Areg , QBus ,Abus ,sub ,Qshift ,Ashift ,mx ;
wire [15:0] shiftin ,shiftout ;
Q_reg Dividend (clk , rst ,ldQ,  ~sub[7], QBus, Qreg);
M_reg Divisor  (clk , rst ,ldM, Divisor_bus, Mreg);
A_reg Afill (clk , initA ,ldA, Abus , Areg);
Subtractor Subt ({1'b0,Areg} , {1'b0,Mreg} , sub);
Mux abus (mx , Ashift , ldSub , ldshift , Abus);
Mux SUB (sub , Areg , ~sub[7]  , sub[7] , mx);
Mux qbus (Dividend_bus , Qshift , ldDividend , ldshift , QBus);
counter cnt (countEn , initCount , clk , rst , count , countCo);
assign shiftin = {Areg , Qreg}; 
Shifter shft (shiftin , shiftout);
assign {Ashift[7:0] , Qshift[7:1] , Qshift[0] } = {shiftout[15:1] , ~sub[7]} ;

assign quationt = Qreg;
assign remainder = Areg;
endmodule

module DataPathTB();
reg clk =0 ;
reg rst, ldA, ldshift, ldM, ldSubReg, ldQ, initA, initCount , ldSub, ldDividend ,countEn;
reg [7:0] Dividend_bus , Divisor_bus;
wire[7:0] quationt , remainder ;
DataPath UUT1 (clk, rst, ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn, Dividend_bus , Divisor_bus, quationt , remainder ,countCo);
always #100 clk = ~clk;
initial begin 
Dividend_bus = 8'b00011100;
Divisor_bus = 8'b00000110;
//LOAD
ldA =1 ; ldM =1 ; ldQ =1 ; ldshift = 1; initA =1;
rst =0 ; initCount =1 ; ldSub =0; ldDividend=1; countEn=1;
#150
//shift
ldA =1 ; ldM =0 ; ldQ =1 ; ldshift = 1; initA =0;
rst =0 ; initCount =0 ; ldSub =0; ldDividend=0; countEn=1;
#150
//Minuse 
ldA =1 ; ldM =0 ; ldQ =1 ; ldshift = 1; initA =0;
rst =0 ; initCount =0 ; ldSub =1; ldDividend=0; countEn=1;

#150  $stop;
//
end
endmodule

module Controler (input clk , rst, START ,countCo , output logic ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn ,READY);
parameter Idle = 3'd0 , Starting = 3'd1 , Load = 3'd2 , Shift = 3'd3 , Minuse =3'd4 ;
logic [2:0] ps , ns = 3'd0;
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

module ControllerTB();
logic clk =1 , rst=0 , START =0 , countCo =0 ;
wire ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn ,READY;
Controler UUT1 (clk ,rst ,START ,countCo ,ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn ,READY);
always #100 clk = ~clk;
	initial begin
	#80 START = 1;
	#140 START = 0;
	#800;
	#105 countCo = 1; START = 0;
	#400 $stop;
	end
endmodule

module DividerMine(input clk , rst , START , input [7:0] Dividend_bus , Divisor_bus , output [7:0] quationt , remainder ,output READY);
wire ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn , countCo;

DataPath D1(clk, rst, ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn, Dividend_bus , Divisor_bus , quationt , remainder ,countCo);

Controler C1(clk , rst, START ,countCo ,ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn ,READY);

endmodule

module DividerTB ();
logic clk = 0, rst = 0, START = 0;
logic [7:0] Dividend_bus = 8'd211;
logic [7:0] Divisor_bus = 8'd14;
wire [7:0] quationt , remainder ;
wire READY ;
	DividerMine UUT1(clk , rst , START , Dividend_bus , Divisor_bus , quationt , remainder, READY);
	always #130 clk = ~clk;
	initial begin
	#80 START = 1;
	#450 START = 0;
 	#20000 $stop;
	end
endmodule