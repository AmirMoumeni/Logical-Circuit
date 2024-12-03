`timescale 1ns/1ns
 module Q_reg(input clk, rst, cen ,incrmnt, input [7:0] pin, output reg [7:0] pout);
	always @(posedge clk, posedge rst) begin
		if (rst) pout <= 8'b0;
		else if (cen) pout <= pin;
		else if (incrmnt)pout <= pout +1'b1 ;
		else pout <= pout;
	end
endmodule