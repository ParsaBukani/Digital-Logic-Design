`timescale 1ns/1ns

module Clocked_SR_Latch(input wire S, R, CLK, output reg Q, Qn);
	always @(CLK, R, S) begin
		if (~CLK) begin
			if (~S && ~R) begin
				Q <= #(14) 1'bx;
				Qn <= #(14) 1'bx;
			end else if (~S) begin
				Q <= #(14) 1;
				Qn <= #(14) 0;
			end else if (~R) begin
				Q <= #(14) 0;
				Qn <= #(14) 1;
			end else begin
				Q <= #(14) Q;
				Qn <= #(14) Qn; 
			end
		end
	end
endmodule

module Clocked_SR_Latch_tb;
    reg S, R, CLK;
    wire Q, Qn;
    Clocked_SR_Latch uut(.S(S), .R(R), .CLK(CLK), .Q(Q), .Qn(Qn));

    initial begin
        S = 1; R = 1; CLK = 1; #30;
    
        S = 0; R = 1; CLK = 0; #30; CLK = 1; #30;
        
        S = 1; R = 0; CLK = 0; #30; CLK = 1; #30;
        
        S = 0; R = 0; CLK = 0; #30; CLK = 1; #30;
        
        S = 1; R = 1; CLK = 0; #30; CLK = 1; #30;

		S = 1; R = 1; CLK = 0; #30; CLK = 0; #30;
    
        S = 0; R = 1; CLK = 0; #30; CLK = 1; #30;
        
        S = 1; R = 0; CLK = 0; #30; CLK = 1; #30;
        $stop;
    end

endmodule