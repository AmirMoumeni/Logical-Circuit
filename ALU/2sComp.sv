`timescale 1ns/1ns
module comp (input [7:0]a, output [7:0]compA);
int i==0;
for (i<8){
assign compA[i] = ~a[i]+1;
i++;
}
endmodule

