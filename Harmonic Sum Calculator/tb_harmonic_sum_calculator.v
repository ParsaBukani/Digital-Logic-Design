`timescale 1 ns/ 1 ns

module tb_harmonic_sum_calculator;

reg clk;
reg rst;
reg start;
reg [4:0] n;
wire [19:0] sum;
wire comparator_output;

top_level uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .sum(sum),
    .comparator_output(comparator_output)
);


always #10 clk = ~clk;

initial begin
    clk = 0;
    rst = 0;
    start = 0;
    n = 5'd0;

    rst = 1;
    #20 rst = 0;

    // n = 3
    n = 5'b00011;
    start = 1;
    #10 start = 0;

    #50

    // n = 5
    n = 5'b00101;
    start = 1;
    #10 start = 0;

    #70

    // n = 15
    n = 5'b01111;
    start = 1;
    #10 start = 0;

    # 200 $stop;
end

endmodule
