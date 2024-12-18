`timescale 1ns/1ns
module adder (input Cin , a0,a1,b0,b1, output s1,s0,Cout);
//Question 1
wire a,ab,b,c,c1,d,e,eb,f,g,h,i,j,k,l ,m ,n;
nor #(10,14)(a, a0, b0);
nor #(10,14)(c, a0, a);
nor #(10,14)(d, a ,b0);
nor #(10,14)(e, c , d);
nor #(10,14)(f,e,Cin);
nor #(10,14)(g, e ,f);
nor #(10,14)(h, Cin, f);
nor #(10,14)(s0,g ,h );
nor #(10,14)(c1, a, f);
nor #(10,14)(b, b1, a1);
nor #(10,14)(m, b1, b);
nor #(10,14)(l, b, a1);
nor #(10,14)(n, l, m);
nor #(10,14)(i , c1, n);
nor #(10,14)(j, i, c1);
nor #(10,14)(k, i, n);
nor #(10,14)(s1, k, j);
nor #(10,14)(Cout, b, i);
endmodule

module adderX (input Cin , a0,a1,b0,b1, output s1,s0,Cout);
//Question 1 - Using XOR and AND Gate (Not in the Project)
wire a,b,c,d,e,eb,f;
xor (a,a0,b0);
xor (s0,Cin,a);
and (g,a,Cin);
and (b,a0,b0);
or  (c,g,b);
xor (s1,c,d);
xor (d,a1,b1);
and (e,a1,b1);
and (f,c,d);
or  (Cout,f,e);
endmodule 

module asadder (input Cin , a0,a1,b0,b1, output s1,s0,Cout);
//Question 2
assign #96 {Cout,s1,s0} = {a1,a0} + {b1,b0}+ {Cin};
endmodule

module adderTest();
//Question 1,2 TestBench
reg aa0,aa1,bb0,bb1,cci;
wire cco,ss1,ss0,ccao,ssa1,ssa0;
adder UUT1(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ss1),.s0(ss0),.Cout(cco) , .Cin(cci));
asadder UUT2(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ssa1),.s0(ssa0),.Cout(ccao) , .Cin(cci));
initial begin
#300 cci=1; aa0=1; aa1=0; bb0=1; bb1=1;
#300 cci=0; aa0=0; aa1=0; bb0=0; bb1=0;
#300 cci=1; aa0=0; aa1=0; bb0=0; bb1=0;
#300 cci=0; aa0=0; aa1=1; bb0=1; bb1=0;
#300 $stop;
end
endmodule

module twoOneMUX(input a,b,s , output w);
//Pass Transistor Based 2-to-1 Multiplexer
wire j;
supply0 gnd;
supply1 vdd;
nmos #(3,4,5)(w,a,s);
pmos #(5,6,7)(j,vdd,s);
nmos #(3,4,5)(j,gnd,s);
nmos #(3,4,5)(w,b,j);
endmodule

module MUXadder (input Cin , a0,a1,b0,b1, output s1,s0,Cout);
//Question 3
wire a,b,c,d,e,eb,f;
twoOneMUX twoOneMUX1_inst (.a(b0) , .b(~b0),.s(a0) ,.w(a));
twoOneMUX twoOneMUX2_inst (.a(a0) , .b(b0),.s(a0) ,.w(b));
twoOneMUX twoOneMUX3_inst (.a(a) , .b(Cin),.s(a) ,.w(c));
twoOneMUX twoOneMUX4_inst (.a(c) , .b(b),.s(b) ,.w(d));
twoOneMUX twoOneMUX5_inst (.a(Cin) , .b(~Cin),.s(a) ,.w(s0));
twoOneMUX twoOneMUX6_inst (.a(b1) , .b(~b1),.s(a1) ,.w(e));
twoOneMUX twoOneMUX7_inst (.a(a0) , .b(b1),.s(a1) ,.w(f));
twoOneMUX twoOneMUX8_inst (.a(e) , .b(~e),.s(d) ,.w(s1));
twoOneMUX twoOneMUX9_inst (.a(d) , .b(e),.s(d) ,.w(g));
twoOneMUX twoOneMUX10_inst (.a(g) , .b(f),.s(f) ,.w(Cout));

endmodule 

module MUXasadder (input Cin , a0,a1,b0,b1, output s1,s0,Cout);
//Question 4
assign #45 {Cout,s1,s0} = {a1,a0} + {b1,b0}+ {Cin};
endmodule

module MUXadderTest ();
//Question 4,5 TestBench
reg aa0,aa1,bb0,bb1,cci;
wire cco,ss1,ss0,ccao,ssa1,ssa0;
MUXadder UUT1(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ss1),.s0(ss0),.Cout(cco) , .Cin(cci));
MUXasadder UUT2(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ssa1),.s0(ssa0),.Cout(ccao) , .Cin(cci));
initial begin
#300 cci=1; aa0=1; aa1=0; bb0=1; bb1=1;
#300 cci=0; aa0=0; aa1=0; bb0=0; bb1=0;
#300 cci=1; aa0=0; aa1=0; bb0=0; bb1=0;
#300 cci=0; aa0=0; aa1=1; bb0=1; bb1=0;
#300 $stop;
end
endmodule 

module Tester (); 
//Question 5
reg aa0,aa1,bb0,bb1,cci;
wire cco,ss1,ss0,ccao,ssa1,ssa0;
adder UUT1(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ss1),.s0(ss0),.Cout(cco) , .Cin(cci));
MUXadder UUT2(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ssa1),.s0(ssa0),.Cout(ccao) , .Cin(cci));
initial begin
#300 cci=1; aa0=1; aa1=0; bb0=1; bb1=1;
#300 cci=0; aa0=0; aa1=0; bb0=0; bb1=0;
#300 cci=1; aa0=0; aa1=0; bb0=0; bb1=0;
#300 cci=0; aa0=0; aa1=1; bb0=1; bb1=0;
#300 $stop;
end
endmodule 

module ADDER_QSIX (input Cin , a0,a1,b0,b1, output s1,s0,Cout);
//Question 6
assign {Cout,s1,s0} = {a1,a0} + {b1,b0}+ {Cin};
endmodule

module SynthTester (); 
//Question 5
reg aa0,aa1,bb0,bb1,cci;
wire cco,ss1,ss0,ccao,ssa1,ssa0 ,ccbo,ssb1,ssb0;
adder UUT1(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ss1),.s0(ss0),.Cout(cco) , .Cin(cci));
MUXadder UUT2(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ssa1),.s0(ssa0),.Cout(ccao) , .Cin(cci));
simple UUT3(.a0(aa0),.a1(aa1),.b0(bb0),.b1(bb1),.s1(ssb1),.s0(ssb0),.c2(ccbo) , .c0(cci));
initial begin
#300 cci=1; aa0=1; aa1=0; bb0=1; bb1=1;
#300 cci=0; aa0=0; aa1=0; bb0=0; bb1=0;
#300 cci=1; aa0=0; aa1=0; bb0=0; bb1=0;
#300 cci=0; aa0=0; aa1=1; bb0=1; bb1=0;
#300 $stop;
end
endmodule 
