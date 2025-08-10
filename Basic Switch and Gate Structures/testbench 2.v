`timescale 1ns/1ps  
module majority_test_bench();
wire w1, w2, w3;
reg a = 0, b = 0, c = 0;
maj1 mjT(a, b, c, w1);
maj2 mjG(a, b, c, w2);
maj3 mjP(a, b, c, w3);
initial begin
#50 a = 1; b = 1; c = 1;
#50 a = 0; b = 0; c = 0;
#50 $stop;
end
endmodule