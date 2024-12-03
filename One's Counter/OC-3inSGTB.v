`timescale 1ns/1ns
module ocswitchgateTB ();
reg aa,bb,cc;
wire ys0,ys1,yg0,yg1;
OC3ingate UUT1(.a(aa),.b(bb),.c(cc),.y0(yg0),.y1(yg1));
oc3inswitch UUT2(.a(aa),.b(bb),.c(cc),.y0(ys0),.y1(ys1));
initial begin 
#500 aa=0 ; bb=0; cc=0;
#500 aa=0 ; bb=0; cc=1;
#500 aa=0 ; bb=1; cc=0;
#500 aa=0 ; bb=1; cc=1;
#500 aa=1 ; bb=0; cc=0;
#500 aa=1 ; bb=0; cc=1;
#500 aa=1 ; bb=1; cc=0;
#500 aa=1 ; bb=1; cc=1;
#500 aa=0 ; bb=0; cc=0;

end
endmodule
