`timescale 1ns/1ns
module QuesFourMUX(input a,b,c,d,s1,s0 , output w);
wire i,j,s0bar , s1bar;
supply0 gnd;
supply1 vdd;
//Mux1 a,b
nmos #(3,4,5)(i,b,s0);
nmos #(3,4,5)(i,a,s0bar);
//s0 inverter
nmos #(3,4,5)(s0bar,gnd,s0);
pmos #(5,6,7)(s0bar,vdd,s0);
//Mux2 c,d
nmos #(3,4,5)(j,c,s0bar);
nmos #(3,4,5)(j,d,s0);
//Mux3 
nmos #(3,4,5)(w,j,s1);
nmos #(3,4,5)(w,i,s1bar);
//s1 inverter
nmos #(3,4,5)(s1bar,gnd,s1);
pmos #(5,6,7)(s1bar,vdd,s1);

endmodule