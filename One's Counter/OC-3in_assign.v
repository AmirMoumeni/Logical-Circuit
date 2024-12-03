`timescale 1ns/1ns
module ocassign (input a,b,c, output y0,y1);
assign   #15 y0=(a&b) |c&(a|b);
assign   #21 y1=(c&(~a&~b|a&b))|(~c&(~a&b|a&~b));
endmodule
