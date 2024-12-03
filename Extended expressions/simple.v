`timescale 1ns/1ns
module simple(input a0,a1,b0,b1,c0,output s0,s1,c2);

assign  {c2,s1,s0}={a1,a0}+{b1,b0}+c0;


endmodule