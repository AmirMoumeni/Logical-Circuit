`timescale 1ns/1ns
module twoMuxTB();
reg aa,bb,ss;
wire ww;
twoOneMUX UUT1(.a(aa),.b(bb),.s(ss),.w(ww));
initial begin
#100 ss=0; aa=0; bb=0;
#100 ss=0; aa=0; bb=1;
#100 ss=0; aa=1; bb=1;
#100 ss=0; aa=1; bb=0;
#100 ss=1; aa=0; bb=0;
#100 ss=1; aa=0; bb=1;
#100 ss=1; aa=1; bb=1;
#100 ss=1; aa=1; bb=0;
end
endmodule
