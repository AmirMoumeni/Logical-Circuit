 `timescale 1ns/1ns
module OC3ingate (input a,b,c, output y1,y0);
wire x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11;
//Calculating y1(First Digit from Right)
and #(14,15)(x1,a,b);
and #(14,15)(x2,~a,~b);
or #(14,15)(x3,x2,x1);
and #(14,15)(x4,x3,c);
and #(14,15)(x5,~a,b);
and #(14,15)(x6,a,~b);
or #(14,15)(x7,x5,x6);
and #(14,15)(x8,~c,x7);
or #(14,15)(y1,x4,x8);
//Calculating y0(Second Digit from Right)
and #(14,15)(x9,a,b);
or #(14,15)(x10,a,b);
and #(14,15)(x11,x10,c);
or #(14,15)(y0,x9,x11);

endmodule
