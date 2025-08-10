module final_test_bench();
wire odd3, maj;
reg a = 0, b = 0, c = 0;
finalGate fg(a, b, c, odd3, maj);
initial begin
#200 a = 1; 
#200 b = 1;
#200 c = 1;
#200 $stop;
end
endmodule
