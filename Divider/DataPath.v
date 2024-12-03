module DataPath(input clk, rst, ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn,
input [7:0] Dividend_bus , Divisor_bus , output [7:0] quationt , remainder , output countCo );

wire [2:0] count ;
wire [7:0] Qreg , Mreg , Areg , QBus ,Abus ,sub ,Qshift ,Ashift ,mx ;
wire [15:0] shiftin ,shiftout ;
Q_reg Dividend (clk , rst ,ldQ,  ~sub[7], QBus, Qreg);
M_reg Divisor  (clk , rst ,ldM, Divisor_bus, Mreg);
A_reg Afill (clk , initA ,ldA, Abus , Areg);
Subtractor Subt ({1'b0,Areg} , {1'b0,Mreg} , sub);
myMux abus (mx , Ashift , ldSub , ldshift , Abus);
myMux SUB (sub , Areg , ~sub[7]  , sub[7] , mx);
myMux qbus (Dividend_bus , Qshift , ldDividend , ldshift , QBus);
counter cnt (countEn , initCount , clk , rst , count , countCo);
assign shiftin = {Areg , Qreg}; 
Shifter shft (shiftin , shiftout);
assign {Ashift[7:0] , Qshift[7:1] , Qshift[0] } = {shiftout[15:1] , ~sub[7]} ;

assign quationt = Qreg;
assign remainder = Areg;
endmodule
