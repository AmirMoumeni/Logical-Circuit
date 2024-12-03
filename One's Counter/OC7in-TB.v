`timescale 1ns/1ns
module oc7inTB ();
reg aa,bb,cc,dd,ee,ff,gg;
wire ys0,ys1,ys2,ya0,ya1,ya2;
oc7in UUT1 (.a(aa),.b(bb),.c(cc),.d(dd),.e(ee),.f(ff),.g(gg),.y0(ys0),.y1(ys1),.y2(ys2));
oc7inassign UUT2 (.a(aa),.b(bb),.c(cc),.d(dd),.e(ee),.f(ff),.g(gg),.y0(ya0),.y1(ya1),.y2(ya2));
initial begin
#500 aa=0;  bb=0; cc=0;  dd=0;  ee=0;  ff=0;  gg=1; 
#500 aa=0;  bb=0; cc=0;  dd=0;  ee=0;  ff=1;  gg=1; 
#500 aa=0;  bb=0; cc=1;  dd=1;  ee=1;  ff=1;  gg=0; 
#500 $stop;
end
endmodule

