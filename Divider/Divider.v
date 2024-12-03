module Divider(input clk , rst , START , input [7:0] Dividend_bus , Divisor_bus , output [7:0] quationt , remainder ,output READY);
wire ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn , countCo;

DataPath D1(clk, rst, ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn, Dividend_bus , Divisor_bus , quationt , remainder ,countCo);

Controler C1(clk , rst, START ,countCo ,ldA, ldshift, ldM, ldQ, ldSub, ldDividend, initA, initCount, countEn ,READY);

endmodule
