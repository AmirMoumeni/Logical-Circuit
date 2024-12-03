`timescale 1ns/1ns
module NOT(A, Y);
input A;
output Y;
assign #(5,7) Y = ~A;
endmodule


module twoinputNOR(A, B, Y);
input A, B;
output Y;
assign #(10,14) Y = ~(A | B);
endmodule


module threeinputNOR(A, B, C,Y);
input A, B,C;
output Y;
assign #(15,21) Y = ~(A | B | C);
endmodule





