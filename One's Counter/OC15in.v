`timescale 1ns/1ns
module oc15in(input a,b,c,d,e,f,g,h,i,j,k,l,m,n,o , output y0,y1,y2,y3);
wire aa,bb,cc,dd,ee,ff,gg,hh;
oc7in oc15in1(a,b,c,d,e,f,g,aa,bb,cc);
oc7in oc15in2(h,i,j,k,l,m,n,dd,ee,ff);
oc3inswitch oc15in3(aa,dd,o,y0,gg);
oc3inswitch oc15in4(gg,bb,ee,y1,hh);
oc3inswitch oc15in5(hh,cc,ff,y2,y3);
endmodule



