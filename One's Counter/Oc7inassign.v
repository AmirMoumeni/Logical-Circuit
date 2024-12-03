`timescale 1ns/1ns
module oc7inassign (input a,b,c,d,e,f,g, output y0,y1,y2);
wire aa,bb,cc,dd,ee;
ocassign oc7inas1(a,b,c,aa,bb);
ocassign oc7inas2(d,e,f,cc,dd);
ocassign oc7inas3(g,aa,cc,y0,ee);
ocassign oc7inas4(bb,dd,ee,y1,y2);
endmodule
