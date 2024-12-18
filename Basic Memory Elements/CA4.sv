`timescale 1ns/1ns
module register_4(input clk, rst, cen, input [3:0] pin, output reg [3:0] pout);
	always @(posedge clk, posedge rst) begin
		if (rst) pout <= 4'b0;
		else if (cen) pout <= pin;
		else pout <= pout;
	end
endmodule


module register_4_TB ();
	reg [3:0] pin;
	reg clk =0  , rst=0 , cen=1;
	wire [3:0] pout;
register_4 UUT1 (.clk(clk), .rst(rst), .cen(cen), .pin(pin), .pout(pout));
always #100 clk = ~clk;
initial begin 

repeat (30) #500 begin 
pin = $random() ;
rst = $random() ;
cen = $random() ;
end 
$stop;
end
endmodule

module ShiftRegister (input [3:0] si , input clk , rst, shn, output [3:0] so);
	reg  [3:0] shift_reg [0:7] ;
	genvar i;
	generate for (i=0 ; i<8 ; i=i+1) begin : shift_stages
		if (i==0) begin 
		register_4 shift_stage (clk , rst , shn , si , shift_reg[i]);
			  end
		else begin 
		register_4 shift_stage (clk , rst , shn , shift_reg [i-1] , shift_reg[i]);
			  end
	end
endgenerate 
assign so = shift_reg[7];
endmodule

module ShiftRegisterTB ();
	reg [3:0] si =4'b0101 ;
	reg clk =0  , rst=0 , shn=1 ; 
	wire [3:0] so;
ShiftRegister UUT1 (.clk(clk), .rst(rst), .shn(shn), .si(si), .so(so));
always #100 clk = ~clk;
initial begin 

#120 begin 
repeat(10)#120 begin
si = $random ;
rst = 0 ;
shn = 1 ;

end 
#2000;
rst = 1 ;
#500 $stop;
end
end
endmodule

module ShiftRegNonBlock (input [3:0] si , input clk , rst, shn, output [3:0] so);
	reg  [3:0] shift_reg [0:7] ;
	always@(posedge clk , posedge rst) begin 
	int i;
	for (i=0 ; i<8 ; i=i+1) begin : shift_stages
	if (rst)
		shift_reg[i] <= 4'b0;
	else if (i==0)
		if (shn) 
		shift_reg[i] <= si;
		else shift_reg[i] <= shift_reg[i];
	else if (shn)
		shift_reg[i] <= shift_reg[i-1];
	else shift_reg[i] <= shift_reg[i];
end 
end
assign so = shift_reg[7];
endmodule

module ShiftRegBlock (input [3:0] si , input clk , rst, shn, output [3:0] so);
	reg  [3:0] shift_reg [0:7] ;
	always@(posedge clk , posedge rst) begin 
	int i;
	for (i=0 ; i<8 ; i=i+1) begin : shift_stages
	if (rst)
		for (i=0 ; i<8 ; i=i+1) begin 
			shift_reg[i] <= 4'b0;
					end
	else if (i==0)
		if (shn) 
		for (i=0 ; i<8 ; i=i+1) begin 
			shift_reg[i] <= si;
					end
		else for (i=0 ; i<8 ; i=i+1) begin 
			shift_reg[i] <= shift_reg[i];
					end
	else if (shn)
		for (i=0 ; i<8 ; i=i+1) begin 
			shift_reg[i] <= shift_reg[i-1];
					end
	else for (i=0 ; i<8 ; i=i+1) begin 
			shift_reg[i] <= shift_reg[i];
					end
end 
end
assign so = shift_reg[7];
endmodule

module ShiftRegisterBehavTB ();
	reg [3:0] si =4'b0101 ;
	reg clk =0  , rst=0 , shn=1 ; 
	wire [3:0] so1 , so2;
ShiftRegBehav UUT1 (.clk(clk), .rst(rst), .shn(shn), .si(si), .so(so1));
ShiftRegBlock UUT2 (.clk(clk), .rst(rst), .shn(shn), .si(si), .so(so2));
always #100 clk = ~clk;
initial begin 

#120 begin 
repeat(10)#120 begin
si = $random ;
rst = 0 ;
shn = 1 ;

end 
#4000;
end
repeat(10)#120 begin
si = $random ;
rst = 1 ;
shn = 1 ;

end 
#4000;
repeat(10)#120 begin
si = $random ;
rst = 0 ;
shn = 0 ;

end 
#4000 $stop;
end
endmodule






 