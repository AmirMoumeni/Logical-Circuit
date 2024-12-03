`timescale 1ns/1ns
module mynor(input a,b , output w);
wire j;
supply0 gnd;
supply1 vdd;
pmos #(5,6,7)(j,vdd,b);
pmos #(5,6,7)(w,j,a);
nmos #(3,4,5)(w,gnd,a);
nmos #(3,4,5)(w,gnd,b);
endmodule

