`timescale 1ns/1ns
module oc7in (input a,b,c,d,e,f,g, output y0,y1,y2);
wire aa,bb,cc,dd,ee;
oc3inswitch oc7in1(a,b,c,aa,bb);
oc3inswitch oc7in2(d,e,f,cc,dd);
oc3inswitch oc7in3(g,aa,cc,y0,ee);
oc3inswitch oc7in4(bb,dd,ee,y1,y2);
endmodule



