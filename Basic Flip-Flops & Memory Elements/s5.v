`timescale 1ns/1ns

module Clocked_D_Latch_with_Reset(output reg Q, output reg Qn, input D, RST, input CLK);
	always @(CLK, D, RST) begin
		if (CLK) begin
			if (RST) begin
				Q <= #(21) 0;
				Qn <= #(21) 1;
			end else if (D) begin
            	Q <= #(14) 1;
        		Qn <= #(21) 0;
			end else if (~D) begin
				Q <= #(14) 0;
				Qn <= #(21) 1;
			end else begin
				Q <= #(14) Q;
				Qn <= #(21) Qn; 
			end
		end
	end
endmodule


module Register8Bit(output [7:0] Q, output [7:0] Qn, input [7:0] D, input CLK, input RST);
    Clocked_D_Latch_with_Reset d0 (.Q(Q[0]), .Qn(Qn[0]), .D(D[0]), .RST(RST), .CLK(CLK));
    Clocked_D_Latch_with_Reset d1 (.Q(Q[1]), .Qn(Qn[1]), .D(D[1]), .RST(RST), .CLK(CLK));
    Clocked_D_Latch_with_Reset d2 (.Q(Q[2]), .Qn(Qn[2]), .D(D[2]), .RST(RST), .CLK(CLK));
    Clocked_D_Latch_with_Reset d3 (.Q(Q[3]), .Qn(Qn[3]), .D(D[3]), .RST(RST), .CLK(CLK));
    Clocked_D_Latch_with_Reset d4 (.Q(Q[4]), .Qn(Qn[4]), .D(D[4]), .RST(RST), .CLK(CLK));
    Clocked_D_Latch_with_Reset d5 (.Q(Q[5]), .Qn(Qn[5]), .D(D[5]), .RST(RST), .CLK(CLK));
    Clocked_D_Latch_with_Reset d6 (.Q(Q[6]), .Qn(Qn[6]), .D(D[6]), .RST(RST), .CLK(CLK));
    Clocked_D_Latch_with_Reset d7 (.Q(Q[7]), .Qn(Qn[7]), .D(D[7]), .RST(RST), .CLK(CLK));
endmodule