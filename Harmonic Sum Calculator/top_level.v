`timescale 1 ns/ 1 ns

module harmonic_sum_calculator (
    input n_en,
    input count_en,
    input add_en,
    input clk,
    input rst,
    input reset_n,
    input [4:0] n, 
    output [19:0] sum,
    output comparator_output
);

wire [15:0] dout;
reg [19:0] partial_sum;
reg [4:0] count;
reg [4:0] n_reg;

rams_sp_rom_1 rom (
    .clk(clk),
    .rst(rst),
    .address(count),
    .dout(dout)
);

assign comparator_output = (rst) ? 0 : (count == n_reg - 1) ? 1 : 0;
assign sum = (add_en) ? partial_sum + dout : sum;

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 5'd0;
    else 
        count <= count + 1;
end

always @(posedge clk or posedge rst) begin
    if (rst) 
        partial_sum <= 20'd0;
    else
        partial_sum <= sum;
end

always @(posedge clk or posedge reset_n) begin
    if (reset_n) 
        n_reg <= 5'b0;
    else if (n_en)
        n_reg <= n;
end

endmodule





module rams_sp_rom_1 (
    input clk,
    input rst,
    input [4:0] address,
    output [15:0] dout
);
    (* rom_style = "block" *) reg [19:0] data;
    always @(posedge clk, posedge rst) begin
        if (rst)
            data <= 16'h0000;
        else begin
            case(address)
                5'b00000: data <= 16'b1111111111111111; // 1/1
                5'b00001: data <= 16'b1000000000000000; // 1/2
                5'b00010: data <= 16'b0101010101010101; // 1/3
                5'b00011: data <= 16'b0100000000000000; // 1/4
                5'b00100: data <= 16'b0011001100110011; // 1/5                    
                5'b00101: data <= 16'b0010101010101010; // 1/6
                5'b00110: data <= 16'b0010010010010010; // 1/7
                5'b00111: data <= 16'b0010000000000000; // 1/8
                5'b01000: data <= 16'b0001110010010010; // 1/9
                5'b01001: data <= 16'b0001100110011001; // 1/10
                5'b01010: data <= 16'b0001011101011101; // 1/11
                5'b01011: data <= 16'b0001010101010101; // 1/12
                5'b01100: data <= 16'b0001001110110111; // 1/13
                5'b01101: data <= 16'b0001001001001001; // 1/14
                5'b01110: data <= 16'b0001000100010001; // 1/15
                5'b01111: data <= 16'b0001000000000000; // 1/16
                5'b10000: data <= 16'b0000111100001111; // 1/17
                5'b10001: data <= 16'b0000111001111001; // 1/18
                5'b10010: data <= 16'b0000110111010000; // 1/19
                5'b10011: data <= 16'b0000110011001100; // 1/20
                default: data <= 16'b0000000000000000;
            endcase
        end
    end
    assign dout = data;
endmodule



module controller(input clk, rst, start, comperator_output, output reg reset_datapath, reset_n, add_en, count_en, n_en);

parameter [1:0] idle = 2'b00, init = 2'b01, load = 2'b11, adding = 2'b10;
reg [1:0] pstate, nstate;

always @(pstate, start, comperator_output) begin
    nstate = 2'b0;
    {reset_datapath, reset_n, add_en, count_en, n_en} = 5'b00000;

    case(pstate)
        idle: nstate = start ? init : idle;
        init: begin 
            nstate = start ? init : load; 
            reset_n = 1;
        end
        load: begin 
            nstate = adding;
            reset_datapath = 1;
            reset_n = 0;
            n_en = 1;
        end 
        adding: begin 
            nstate = comperator_output ? idle : adding;
            {add_en, count_en} = 2'b11;
        end
    endcase
end

always @(posedge clk, posedge rst) begin
    if (rst)
        pstate <= idle;
    else
        pstate <= nstate;
end

endmodule



module top_level(
    input clk,
    input rst,
    input start,
    input [4:0] n,
    output [19:0] sum,
    output comparator_output
);

wire reset_n;
wire reset_datapath;
wire add_en;
wire count_en;
wire n_en;

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

endmodule