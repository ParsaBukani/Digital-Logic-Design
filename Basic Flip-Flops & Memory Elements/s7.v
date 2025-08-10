`timescale 1ns/1ns

module Sequence_Adder_tb;
    reg [7:0] A;
    reg CLK, RST;
    wire [7:0] Q;
    
    Sequence_Adder uut (.Q(Q), .A(A), .CLK(CLK), .RST(RST));
    
    initial begin
        A = 8'b00000000; CLK = 1; RST = 1; #300;
       	A = 8'b00000001; CLK = 0; RST = 0; #200; CLK = 1; #100;
	    A = 8'b00000010; CLK = 0; #200; CLK = 1; #100;
	    A = 8'b00000100; CLK = 0; #200; CLK = 1; #100;
        A = 8'b00001000; CLK = 0; #200; CLK = 1; #100;
        A = 8'b00010000; CLK = 0; #300; CLK = 1; RST = 1; #300;
	    A = 8'b00100000; CLK = 0; RST = 0; #300; CLK = 1; #100;
	    A = 8'b01000000; CLK = 0; #200; CLK = 1; #100;
	    A = 8'b10000000; CLK = 0; #200; CLK = 1; #200;
        $stop;
    end
endmodule