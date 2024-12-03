`timescale 1ns/1ns
module myMux(input [7:0] a, b, input sla, slb, output [7:0] s);
	assign s = sla ? a:
	           slb ? b: 8'bx;
endmodule
