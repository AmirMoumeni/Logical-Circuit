`timescale 1ns/1ns
module ocgateTB ();
reg aa,bb,cc;
wire yy0,yy1;
OC3ingate UUT(.a(aa),.b(bb),.c(cc),.y0(yy0),.y1(yy1));
initial begin 
#50 aa=0 ; bb=0; cc=0;
#50 aa=0 ; bb=0; cc=1;
#50 aa=0 ; bb=1; cc=0;
#50 aa=0 ; bb=1; cc=1;
#50 aa=1 ; bb=0; cc=0;
#50 aa=1 ; bb=0; cc=1;
#50 aa=1 ; bb=1; cc=0;
#50 aa=1 ; bb=1; cc=1;
#50 aa=0 ; bb=0; cc=0;

end
endmodule

