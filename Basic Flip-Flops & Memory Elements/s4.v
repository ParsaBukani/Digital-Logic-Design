`timescale 1ns/1ns

module Clocked_D_Latch(output reg Q, output reg Qn, input D, input CLK);
	always @(CLK, D) begin
		if (CLK) begin
			if (D) begin
        		Q <= #(14) 1;
            	Qn <= #(21) 0; // 14 + 7 delays
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


module D_Latch_tb;
    reg D, CLK;
    wire Q, Qn;

    Clocked_D_Latch uut (.D(D), .CLK(CLK), .Q(Q), .Qn(Qn));

    initial begin 
        CLK = 0; 
        forever #30 CLK = ~CLK;  
    end

    initial begin
        D = 0; #70;
        D = 1; #70;
        D = 0; #70;

        D = 0; #10; D = 1; #10; D = 0; #20;
        D = 1; #10; D = 0; #10; D = 1; #20;
        $stop;
    end
endmodule