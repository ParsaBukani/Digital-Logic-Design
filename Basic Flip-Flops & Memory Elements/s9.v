`timescale 1ns/1ns

module Register8Bit_FF(output [7:0] Q, input [7:0] D, input CLK, input RST);
    Master_Slave_D_FF ff0 (.Q(Q[0]), .Qn(), .D(D[0]), .CLK(CLK), .RST(RST));
    Master_Slave_D_FF ff1 (.Q(Q[1]), .Qn(), .D(D[1]), .CLK(CLK), .RST(RST));
    Master_Slave_D_FF ff2 (.Q(Q[2]), .Qn(), .D(D[2]), .CLK(CLK), .RST(RST));
    Master_Slave_D_FF ff3 (.Q(Q[3]), .Qn(), .D(D[3]), .CLK(CLK), .RST(RST));
    Master_Slave_D_FF ff4 (.Q(Q[4]), .Qn(), .D(D[4]), .CLK(CLK), .RST(RST));
    Master_Slave_D_FF ff5 (.Q(Q[5]), .Qn(), .D(D[5]), .CLK(CLK), .RST(RST));
    Master_Slave_D_FF ff6 (.Q(Q[6]), .Qn(), .D(D[6]), .CLK(CLK), .RST(RST));
    Master_Slave_D_FF ff7 (.Q(Q[7]), .Qn(), .D(D[7]), .CLK(CLK), .RST(RST));
endmodule


module Sequence_Adder_with_Register8Bit_FF(output [7:0] Q, input [7:0] A, input CLK, input RST);
    wire [7:0] SUM;
    
    Adder8Bit adder (.SUM(SUM), .A(A), .B(Q));
    Register8Bit_FF register (.Q(Q), .D(SUM), .CLK(CLK), .RST(RST));
    
endmodule


module Sequence_Adder_with_Register8Bit_FF_tb;
    reg [7:0] A;
    reg CLK, RST;
    wire [7:0] Q;
    
    Sequence_Adder_with_Register8Bit_FF uut (.Q(Q), .A(A), .CLK(CLK), .RST(RST));
    
    initial begin
        A = 8'b00000000; CLK = 1; RST = 1; #350;
        A = 8'b00000001; CLK = 0; RST = 0; #200; CLK = 1; #200;
        A = 8'b00000010; CLK = 0; #200; CLK = 1; #200;
        A = 8'b00000100; CLK = 0; #200; CLK = 1; #200;
        A = 8'b00001000; CLK = 0; #200; CLK = 1; #200;
        A = 8'b00010000; CLK = 0; #200; CLK = 1; #200;
        RST = 1; #100;
        RST = 0; A = 8'b00000011; CLK = 0; #200; CLK = 1; #200;
        A = 8'b00000100; CLK = 0; #200; CLK = 1; #200;
        $stop;
    end

endmodule