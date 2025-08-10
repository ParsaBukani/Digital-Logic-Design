`timescale 1 ns/ 1 ns

module Sequential_Divider (  
    input [15:0] A,   
    input [15:0] B,   
    input load_A,   
    input load_B,   
    input sh1,   
    input sh2,   
    input inz_0,   
    input load_sub,  
    input rst, clk,
    output [15:0] Quotient,  
    output [15:0] Remainder,
    output [15:0] Re,
    output cout,
    output reg error
);

reg [3:0] count;
reg [15:0] B_reg;
reg [15:0] Quotient_reg;
reg [15:0] Remainder_reg;
wire signed [15:0] subtracted;
wire serial_input;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        B_reg <= 16'd0;
        error <= 0;
    end
    else if (load_B) begin
        B_reg <= B;
        if (B == 16'd0)
            error <= 1;
        else
            error <= 0;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) 
        Quotient_reg <= 16'd0;
    else if (load_A)
        Quotient_reg <= A;
    else if (sh1)
        Quotient_reg <= {Quotient_reg[14:0], serial_input};
end

always @(posedge clk or posedge rst) begin
    if (rst) 
        Remainder_reg <= 16'd0;
    else if (inz_0)
        Remainder_reg <= 16'd0;
    else if (load_sub)
        Remainder_reg <= subtracted;
    else if (sh2)
        Remainder_reg <= {Remainder_reg[14:0], Quotient_reg[15]};
end

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 4'd0;
    else if (inz_0)
        count <= 4'd0;
    else 
        count <= count + 1;
end

assign cout = &count;
assign subtracted = {Remainder_reg[14:0], Quotient_reg[15]} - B_reg;
assign serial_input = subtracted[15] ? 1'b0 : 1'b1;

assign Quotient = Quotient_reg;  
assign Remainder = Remainder_reg;
assign Re = subtracted;

endmodule


module Controller (
    input clk, rst, start,
    input [15:0] Re,
    input cout,
    input error,  
    output reg load_A, load_B,
    output reg sh1, sh2,
    output reg inz_0, 
    output reg load_sub,
    output reg ready  
);

parameter [1:0] idle = 2'b00, init = 2'b01, load = 2'b11, dividing = 2'b10;
reg [1:0] pstate, nstate;

always @(pstate, start, Re, cout, error) begin
    nstate = 2'b0;
    {ready, load_A, load_B, sh1, sh2, inz_0, load_sub} = 7'b0000000;

    case(pstate)
        idle: begin
            ready = 1;
            nstate = start ? init : idle;
        end
        init: begin 
            nstate = start ? init : load; 
        end
        load: begin 
            nstate = dividing;
            {load_A, load_B, inz_0} = 3'b111;
        end 
        dividing: begin 
            nstate = cout ? idle : dividing;
            sh1 = 1;
            sh2 = Re[15] ? 1 : 0;
            load_sub = Re[15] ? 0 : 1;
            if (error) 
                nstate = idle;
        end
    endcase
end

always @(posedge clk or posedge rst) begin
    if (rst)
        pstate <= idle;
    else
        pstate <= nstate;
end

endmodule


module Top_Level (
    input clk,
    input rst,
    input start,
    input [15:0] A,
    input [15:0] B,
    output [15:0] Quotient,
    output [15:0] Remainder,
    output ready,
    output error
);

wire load_A, load_B, sh1, sh2, inz_0, load_sub;
wire cout;
wire [15:0] Re;

Controller controller (
    .clk(clk),
    .rst(rst),
    .start(start),
    .Re(Re),
    .cout(cout),
    .error(error),
    .load_A(load_A),
    .load_B(load_B),
    .sh1(sh1),
    .sh2(sh2),
    .inz_0(inz_0),
    .load_sub(load_sub),
    .ready(ready)
);

Sequential_Divider sequential_divider (
    .A(A),
    .B(B),
    .load_A(load_A),
    .load_B(load_B),
    .sh1(sh1),
    .sh2(sh2),
    .inz_0(inz_0),
    .load_sub(load_sub),
    .rst(rst),
    .clk(clk),
    .Quotient(Quotient),
    .Remainder(Remainder),
    .Re(Re),
    .cout(cout),
    .error(error)
);

endmodule
