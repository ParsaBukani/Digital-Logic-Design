module Odd3(input a, b, c, output w);
assign #(50, 50) w = ~a&~b&c | ~a&b&~c | a&~b&~c | a&b&c;
endmodule
