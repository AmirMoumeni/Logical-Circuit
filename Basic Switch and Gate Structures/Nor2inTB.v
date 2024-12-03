`timescale 1ns/1ns
module TBNor();
reg aa,bb;
wire ww;
mynor UUT(.a(aa),.b(bb),.w(ww));
initial begin
aa=0; bb=0;
#100 aa=1 ; bb=0;
#100 aa=1 ; bb=1;
#100 aa=0 ; bb=1;
#100 aa=0 ; bb=0;
#100 $stop;
end
endmodule
