`timescale 1 ps/ 1 ps
module tb_harmonic_sum_calculator;

reg clk;
reg rst;
wire reset_n;
reg start;
reg [4:0] n;
wire [19:0] sum;
wire comparator_output;
wire reset_datapath, add_en, count_en, n_en;

harmonic_sum_calculator uutHarmonic_sum (
    .n_en(n_en),
    .count_en(count_en),
    .add_en(add_en),
    .clk(clk),
    .rst(reset_datapath),
    .reset_n(reset_n),
    .n(n),
    .sum(sum),
    .comparator_output(comparator_output)
);

controller uutController (
    .clk(clk),
    .rst(rst),
    .reset_n(reset_n),
    .start(start),
    .comperator_output(comparator_output),
    .reset_datapath(reset_datapath),
    .add_en(add_en),
    .count_en(count_en),
    .n_en(n_en)
);


always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 0;
    start = 0;
    n = 5'd0;

    rst = 1;
    #8 rst = 0;

    // Test case 1: Harmonic sum for n = 3
    n = 5'b00011;
    start = 1;
    #21 start = 0;

    #50

    // Test case 2: Harmonic sum for n = 5
    n = 5'b00101;
    start = 1;
    #10 start = 0;

    #70

    // Test case 3: Harmonic sum for n = 15
    n = 5'b01111;
    start = 1;
    #10 start = 0;


    # 200 $stop;
end

endmodule
