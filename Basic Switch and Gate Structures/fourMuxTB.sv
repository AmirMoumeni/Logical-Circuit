`timescale 1ns/1ns
module fourMuxTB();
reg aa,bb,cc,dd,ss1,ss0;
wire ww;
fourOneMUX UUT1(.a(aa),.b(bb),.c(cc),.d(dd),.s1(ss1),.s0(ss0),.w(ww));
initial begin
#300 ss1=0; ss0=0; aa=1; bb=0; cc=0; dd=1;
#300 ss1=0; ss0=1; aa=0; bb=1; cc=0; dd=0;
#300 ss1=1; ss0=1; aa=0; bb=0; cc=0; dd=1;
#300 ss1=1; ss0=0; aa=0; bb=0; cc=1; dd=0;

#300 ss1=0; ss0=0; aa=0; bb=1; cc=1; dd=1;
#300 ss1=0; ss0=1; aa=1; bb=0; cc=1; dd=1;
#300 ss1=1; ss0=1; aa=1; bb=1; cc=1; dd=0;
#300 ss1=1; ss0=0; aa=1; bb=1; cc=0; dd=1;

end
endmodule
