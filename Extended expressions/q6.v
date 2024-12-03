`timescale 1ns/1ns
module q(input Cin , a0,a1,b0,b1, output s1,s0,Cout);
//Question 6
assign {Cout,s1,s0} = {a1,a0} + {b1,b0}+ {Cin};
endmodule
