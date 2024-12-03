`timescale 1ns/1ns
module A_reg(input clk, rst, cen, input [7:0] pin, output reg [7:0] pout);
	always @(posedge clk, posedge rst) begin
		if (rst) pout <= 8'b0;
		else if (cen) pout <= pin;
		else pout <= pout;
	end
endmodule