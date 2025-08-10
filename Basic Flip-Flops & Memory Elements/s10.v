`timescale 1ns/1ns

module Sequence_Adders_comparison_tb;
    reg [7:0] A;
    reg CLK, RST;
    wire [7:0] Q_MSFF;
    wire [7:0] Q_TRANSPARENT;
    
    Sequence_Adder_with_Register8Bit_FF uut1 (.Q(Q_MSFF), .A(A), .CLK(CLK), .RST(RST));
    Sequence_Adder uut2 (.Q(Q_TRANSPARENT), .A(A), .CLK(CLK), .RST(RST));
    
    initial begin
        A = 8'b00000000; CLK = 1; RST = 1; #350;
        A = 8'b00000001; CLK = 0; RST = 0; #200; CLK = 1; #300;
        A = 8'b00000010; CLK = 0; #300; CLK = 1; #300;
        A = 8'b00000100; CLK = 0; #400; CLK = 1; #400;
        A = 8'b00001000; CLK = 0; #500; CLK = 1; #500;
        A = 8'b00010000; CLK = 0; #200; CLK = 1; #200;
        RST = 1; #100;
        RST = 0; A = 8'b00000011; CLK = 0; #200; CLK = 1; #200;
        A = 8'b00000100; CLK = 0; #200; CLK = 1; #200;
        $stop;
    end
    
endmodule