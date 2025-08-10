`timescale 1ns/1ps 
module not_gate(input a, output w);
supply1 Vdd;
supply0 Gnd;
pmos #(4, 7, 9) Tp(w, Vdd, a);
nmos #(3, 5, 7) Tn(w, Gnd, a);
endmodule

module maj1(input a, b, c, output w);
supply1 Vdd;
supply0 Gnd;
wire Awire, Bwire, Cwire;
wire p1Wire, p2Wire, p3Wire;
wire n1Wire, n2Wire;
not_gate notGateA(a, Awire), notGateB(b, Bwire), notGateC(c, Cwire);
pmos #(4, 7, 9) pA1(p1Wire, Vdd, Awire), pA2(p2Wire, Vdd, Awire),
		pB1(w, p1Wire, Bwire), pB2(w, p3Wire, Bwire),
		pC1(w, p2Wire, Cwire), pC2(p3Wire, Vdd, Cwire);
nmos #(3, 5, 7) nB1(n1Wire, Gnd, Bwire), nC1(n1Wire, Gnd, Cwire),
		nA1(n2Wire, n1Wire, Awire), nC2(n2Wire, n1Wire, Cwire),
		nA2(w, n2Wire, Awire), nB2(w, n2Wire, Bwire);
endmodule

module maj2(input a, b, c, output w);
wire j, k, l, m, n;
not #(7, 9) bNot(j, b), cNot(k, c);
nand #(14, 10) first(l, c, b), second(m, k, j), third(n, m, a), last(w, l, n);
endmodule

module maj3(input a, b, c, output w);
assign #(30, 25) w = a&b | a&c | b&c; // not #(30, 27)
endmodule


