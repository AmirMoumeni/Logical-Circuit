`timescale 1ns/1ns
module fourOneMUX(input a,b,c,d,s1,s0 , output w);
wire i,j,k,l,p;
nor #(15,21)(i,~s1,~s0,a);
nor #(15,21)(j,~s1,s0,b);
nor #(15,21)(k,s1,~s0,c);
nor #(15,21)(l,s1,s0,d);
nor #(20,28)(p,i,j,k,l);
nor #(10,14)(w,p,p);
endmodule


