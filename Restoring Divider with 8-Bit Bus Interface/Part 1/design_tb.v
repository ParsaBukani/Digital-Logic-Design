`timescale 1 ns/ 1 ns

module tb_Controller;  

    reg clk;  
    reg rst;  
    reg start;  
    reg [15:0] A; 
    reg [15:0] B; 
    wire [15:0] Quotient;  
    wire [15:0] Remainder;  
    wire error;
    wire ready; 

    Top_Level uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .Quotient(Quotient),
        .Remainder(Remainder),
        .ready(ready),
        .error(error)
    );

    initial begin  
        clk = 0;  
        forever #5 clk = ~clk;
    end  

    initial begin  
        rst = 1;  
        start = 0;  

        #10;  
        rst = 0;  

        A = 16'd20; 
        B = 16'd4;  
        start = 1;  
        #10;  
        start = 0;  

        #500;  

        A = 16'd45; 
        B = 16'd7;  
        start = 1; 
        #10;  
        start = 0;  

        #500;  

        A = 16'd1; 
        B = 16'd0;  
        start = 1; 
        #10;  
        start = 0;

        # 200 $stop;
    end  

endmodule
