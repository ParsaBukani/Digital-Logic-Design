`timescale 1ns/1ns

module Master_Slave_D_FF(output Q, output Qn, input D, input CLK, input RST);
    wire Qm, Qm_n; 
    assign #7 CLK_n = ~CLK;

    Clocked_D_Latch_with_Reset master(.Q(Qm), .Qn(Qm_n), .D(D), .RST(RST), .CLK(CLK));

    wire Q_int, Qn_int;
    Clocked_D_Latch_with_Reset slave(.Q(Q_int), .Qn(Qn_int), .D(Qm), .RST(RST), .CLK(CLK_n));
    assign Q = Q_int;
    assign Qn = Qn_int;

endmodule


module Master_Slave_D_FF_tb;
    reg D, CLK, RST;
    wire Q, Qn;

    Master_Slave_D_FF uut (.Q(Q), .Qn(Qn), .D(D), .CLK(CLK), .RST(RST));
    
    initial begin
        D = 0; CLK = 1; RST = 1; #80;
        D = 1; CLK = 0; RST = 0; #80; CLK = 1; #80;
        D = 0; CLK = 0; #80; CLK = 1; #80;
        CLK = 0; #80;
        D = 1; CLK = 1; RST = 1; #80; CLK = 0; RST = 0; #80;
        D = 1; CLK = 1; #80; CLK = 0; #80;  
        $stop;
    end
endmodule


module Combined_tb;
    reg D, CLK;
    wire Q_latch, Qn_latch;
    wire Q_ff, Qn_ff, rst;

    Clocked_D_Latch latch (.Q(Q_latch), .Qn(Qn_latch), .D(D), .CLK(CLK));
    Master_Slave_D_FF ff (.Q(Q_ff), .Qn(Qn_ff), .D(D), .CLK(CLK), .RST(rst));
    
    initial begin
        D = 0; #300;
        D = 1; #100;
        D = 0; #100;
        D = 1; #100;
        D = 0; #100;
        $stop;
    end

    initial begin
        CLK = 0;
        forever #60 CLK = ~CLK;
    end
endmodule