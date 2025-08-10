module Odd3(input a, b, c, output w);
assign #(50, 50) w = ~a&~b&c | ~a&b&~c | a&~b&~c | a&b&c;
endmodule


module maj3(input a, b, c, output w);
assign #(30, 25) w = a&b | a&c | b&c;
endmodule

module finalGate(input a, b, c, output w1, w2);
Odd3 odd3(a, b, c, w1);
maj3 maj(a, b, c, w2);
endmodule
