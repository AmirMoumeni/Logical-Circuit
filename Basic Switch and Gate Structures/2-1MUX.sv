`timescale 1ns/1ns
module twoOneMUX(input a,b,s , output w);
wire j;
supply0 gnd;
supply1 vdd;
nmos #(3,4,5)(w,a,s);
pmos #(5,6,7)(j,vdd,s);
nmos #(3,4,5)(j,gnd,s);
nmos #(3,4,5)(w,b,j);
endmodule

