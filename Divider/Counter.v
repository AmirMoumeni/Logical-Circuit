module counter(input cen, iz, clk, rst, output [2:0] po, output co);
	wire [3:0] ns;
	reg [3:0] ps;
	assign ns = ps + 1'b1;
	always @(posedge clk, posedge rst) begin
		if(rst) ps <= 4'b 0;
		else if (iz) ps <= 4'b 0;
		else if (cen) ps <= ns;
	end
	assign {co , po} = ps ;
endmodule
