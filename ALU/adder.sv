`timescale 1ns/1ns
module adder (input [3:0]a,b, input ci , output [3:0]sum ,output co);
assign{co,sum} = a+b+ci;
endmodule

