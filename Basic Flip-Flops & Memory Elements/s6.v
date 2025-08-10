`timescale 1ns/1ns

module Adder8Bit(output [7:0] SUM, input [7:0] A, input [7:0] B);
    assign #260 SUM = A + B;
endmodule


module Sequence_Adder(output [7:0] Q, input [7:0] A, input CLK, input RST);
    wire [7:0] SUM;

    Adder8Bit adder (.SUM(SUM), .A(A), .B(Q));
    Register8Bit register (.Q(Q), .Qn(), .D(SUM), .CLK(CLK), .RST(RST));
    
endmodule