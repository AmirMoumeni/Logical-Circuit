`timescale 1ns/1ns
module Subtractor(input [8:0] a, b ,  output [15:0] po);
	wire [15:0] b_temp;
	assign b_temp  = ~b + 1'b1;
	assign po = a + b_temp  ;
endmodule
