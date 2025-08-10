`timescale 1 ns/ 1 ns

module SequentialDivider_Datapath (  
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

module Controller_SequentialDivider (
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
        idle: nstate = start ? init : idle;
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
            ready = cout ? 1 : 0;
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


module inputWrapper_Datapath (
    input clk, rst,
    input [7:0] Data_in,
    input init_IC,
    input inc_IC,
    input ie,
    output [15:0] A,
    output [15:0] B,
    output IC
);

reg [1:0] count;
reg [7:0] A1, A2, B1, B2;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        A1 <= 0; A2 <= 0; 
        B1 <= 0; B2 <= 0;
    end
    else if (ie) begin
        case (count)
            2'b00: A1 <= Data_in;
            2'b01: A2 <= Data_in;
            2'b10: B1 <= Data_in;
            2'b11: B2 <= Data_in;
        endcase
    end
end

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 2'b00;
    else if (init_IC)
        count <= 2'b00;
    else if (inc_IC)
        count <= count + 1;
end

assign IC = &count;
assign A = {A2, A1};
assign B = {B2, B1};

endmodule

module Controller_inputWrapper (
    input clk, rst,
    input IC,
    input dataready, 
    input readyforinput,
    output reg init_IC,
    output reg inc_IC,
    output reg ie,
    output reg start, 
    output reg readyToAccept
);

parameter [1:0] idle = 2'b00, init = 2'b01, receiving_data = 2'b11, getting = 2'b10;
reg [1:0] pstate, nstate;

always @(pstate, readyforinput, IC, dataready) begin
    nstate = 2'b0;
    {init_IC, inc_IC, ie, start, readyToAccept} = 5'b00000;

    case(pstate)
        idle: nstate = dataready ? init : idle;
        init: begin 
            {init_IC, ie} = 2'b11;
            nstate = receiving_data; 
        end
        receiving_data: begin 
            {readyToAccept, ie} = 2'b11;
            nstate = dataready ? receiving_data : getting; 
        end 
        getting: begin 
            start = (IC & readyforinput) ? 1 : 0;
            inc_IC = (~IC & dataready) ? 1 : 0;
            nstate = (~IC & dataready) ? receiving_data : 
                     (~dataready & ~IC) ? getting :
                     idle;
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


module outputWrapper_Datapath (
    input clk, rst,
    input [15:0] remainder,
    input [15:0] quotient,
    input init_OC,
    input inc_OC,
    input load,
    output [7:0] Data_out,
    output OC
);

reg [1:0] count;
reg [15:0] Quotient_reg;
reg [15:0] Remainder_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Quotient_reg = 0;
        Remainder_reg = 0;
    end
    else if (load) begin
        Quotient_reg = quotient;
        Remainder_reg = remainder;
    end  
end

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 2'b00;
    else if (init_OC)
        count <= 2'b00;
    else if (inc_OC)
        count <= count + 1;
end

assign Data_out = (count == 2'b00) ? Quotient_reg[7:0] :
                  (count == 2'b01) ? Quotient_reg[15:8] :
                  (count == 2'b10) ? Remainder_reg[7:0] :
                  (count == 2'b11) ? Remainder_reg[15:8] : 8'bz;

assign OC = &count;

endmodule

module Controller_outputWrapper (
    input clk, rst,
    input OC,
    input receiveData, 
    input ready,
    output reg init_OC,
    output reg inc_OC,
    output reg load,
    output reg readyforinput, 
    output reg OutBuffFull
);

parameter [1:0] idle = 2'b00, loading = 2'b01, providing_data = 2'b11, waiting = 2'b10;
reg [1:0] pstate, nstate;

always @(pstate, ready, OC, receiveData) begin
    nstate = 2'b0;
    {init_OC, inc_OC, load, OutBuffFull, readyforinput} = 5'b00000;

    case(pstate)
        idle: begin 
            readyforinput = 1;
            nstate = ready ? loading : idle;
        end
        loading: begin 
            {init_OC, load} = 2'b11;
            nstate = providing_data; 
        end
        providing_data: begin 
            OutBuffFull = 1;
            nstate = receiveData ? waiting : providing_data;
        end 
        waiting: begin 
            inc_OC = (~OC & ~receiveData) ? 1 : 0;
            nstate = OC ? idle : 
                     (~OC & ~receiveData) ? providing_data:
                     waiting;
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


module sequentialDivider (
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

Controller_SequentialDivider controller (
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

SequentialDivider_Datapath sequential_divider (
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


module inputWrapper (
    input clk, rst,
    input [7:0] Data_in,
    input dataready, readyforinput,
    output [15:0] A, B,
    output start, readyToAccept
);

wire init_IC, inc_IC, ie, IC;

inputWrapper_Datapath datapath (
    .clk(clk),
    .rst(rst),
    .Data_in(Data_in),
    .init_IC(init_IC),
    .inc_IC(inc_IC),
    .ie(ie),
    .A(A),
    .B(B),
    .IC(IC)
);

Controller_inputWrapper controller (
    .clk(clk),
    .rst(rst),
    .IC(IC),
    .dataready(dataready),
    .readyforinput(readyforinput),
    .init_IC(init_IC),
    .inc_IC(inc_IC),
    .ie(ie),
    .start(start),
    .readyToAccept(readyToAccept)
);

endmodule


module outputWrapper (
    input clk, rst,
    input [15:0] remainder, quotient,
    input receiveData, ready,
    output [7:0] Data_out,
    output OutBuffFull, readyforinput
);

wire init_OC, inc_OC, load, OC;

outputWrapper_Datapath datapath (
    .clk(clk),
    .rst(rst),
    .remainder(remainder),
    .quotient(quotient),
    .init_OC(init_OC),
    .inc_OC(inc_OC),
    .load(load),
    .Data_out(Data_out),
    .OC(OC) 
);

Controller_outputWrapper controller (
    .clk(clk),
    .rst(rst),
    .OC(OC),
    .receiveData(receiveData),
    .ready(ready),
    .init_OC(init_OC),
    .inc_OC(inc_OC),
    .load(load),
    .readyforinput(readyforinput),
    .OutBuffFull(OutBuffFull)
);

endmodule


module System (
    input clk, rst,
    input dataready,                
    input [7:0] Data_in,          
    input receiveData,            
    output [7:0] Data_out,         
    output OutBuffFull,             
    output error,                    
    output readyToAccept             
);

wire [15:0] A, B;               
wire ready, start;  
wire [15:0] remainder, quotient; 
wire readyforinput; 

inputWrapper input_wrapper (
    .clk(clk),
    .rst(rst),
    .Data_in(Data_in),         
    .dataready(dataready),    
    .readyforinput(readyforinput),
    .A(A),                     
    .B(B),                     
    .start(start),
    .readyToAccept(readyToAccept)
);

sequentialDivider seq_divider (
    .clk(clk),
    .rst(rst),
    .start(start),
    .A(A),
    .B(B),
    .Quotient(quotient),
    .Remainder(remainder),
    .ready(ready),
    .error(error)
);

outputWrapper output_wrapper (
    .clk(clk),
    .rst(rst),
    .remainder(remainder),
    .quotient(quotient),
    .receiveData(receiveData),   
    .ready(ready),
    .Data_out(Data_out),         
    .OutBuffFull(OutBuffFull),
    .readyforinput(readyforinput)
);

endmodule
