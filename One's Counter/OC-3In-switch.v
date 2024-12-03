`timescale 1ns/1ns
module oc3inswitch (input a,b,c, output y1,y0);
supply1 vdd;
supply0 gnd;
wire x1,x2,ab,x3,x4,z1,z2,z3,z4,z5,z6,t1,t2,t3;
//Calculating y0(Second Digit from Right)
pmos #(5,6,7)T1(x1,vdd,~a);
pmos #(5,6,7)T2(y0,x1,~b);
pmos #(5,6,7)T3(x2,vdd,~c);
pmos #(5,6,7)T4(y0,x2,~a);
pmos #(5,6,7)T5(y0,x2,~b);

nmos #(3,4,5)T6(x3,gnd,~b);
nmos #(3,4,5)T7(x4,x3,~a);
nmos #(3,4,5)T8(x4,gnd,~c);
nmos #(3,4,5)T9(y0,x4,~a);
nmos #(3,4,5)T10(y0,x4,~b);
//Calculating y1(First Digit from Right)
pmos #(5,6,7)T11(z1,vdd,~c);
pmos #(5,6,7)T12(z2,z1,~a);
pmos #(5,6,7)T13(y1,z2,~b);
pmos #(5,6,7)T29(z3,z1,a);
pmos #(5,6,7)T30(y1,z3,b);
pmos #(5,6,7)T14(z4,vdd,c);
pmos #(5,6,7)T15(z5,z4,~a);
pmos #(5,6,7)T16(y1,z5,b);
pmos #(5,6,7)T17(z6,z4,a);
pmos #(5,6,7)T18(y1,z6,~b);

nmos #(3,4,5)T19(t1,gnd,a);
nmos #(3,4,5)T20(t1,gnd,~b);
nmos #(3,4,5)T21(t2,t1,~a);
nmos #(3,4,5)T22(t2,t1,b);
nmos #(3,4,5)T23(t2,gnd,c);
nmos #(3,4,5)T24(t3,t2,~b);
nmos #(3,4,5)T25(t3,t2,~a);
nmos #(3,4,5)T26(y1,t3,a);
nmos #(3,4,5)T27(y1,t3,b);
nmos #(3,4,5)T28(y1,t2,~c);

endmodule










