`timescale 1 ns/ 1 ns

module testbench;

    reg clk;
    reg rst;
    reg dataready;
    reg [7:0] Data_in;
    reg receiveData;

    wire [7:0] Data_out;
    wire OutBuffFull;
    wire error;
    wire readyToAccept;

    System uut (
        .clk(clk),
        .rst(rst),
        .dataready(dataready),
        .Data_in(Data_in),
        .receiveData(receiveData),
        .Data_out(Data_out),
        .OutBuffFull(OutBuffFull),
        .error(error),
        .readyToAccept(readyToAccept)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;
        dataready = 0;
        receiveData = 0;

        #6; rst = 1; #6; rst = 0; 

        #20;
        dataready = 1;
        Data_in = 8'b00101101;
        #20;
        if (readyToAccept) 
            dataready = 0;
        #20;
        dataready = 1;
        Data_in = 8'b00000000;
        #10;
        if (readyToAccept) 
            dataready = 0;
        #20;
        dataready = 1;
        Data_in = 8'b00000111;
        #10;
        if (readyToAccept)  
            dataready = 0;
        #20;
        dataready = 1;
        Data_in = 8'b00000000;
        #10;
        if (readyToAccept)  
            dataready = 0;

        #200;

        if (OutBuffFull)
            receiveData = 1;
        #10;
        receiveData = 0;
        #10;
        if (OutBuffFull)
            receiveData = 1;
        #10;
        receiveData = 0;
        #10;
        if (OutBuffFull)
            receiveData = 1;
        #10;
        receiveData = 0;
        #10;
        if (OutBuffFull)
            receiveData = 1;
        #10;
        receiveData = 0;

        #200;
        $stop;
    end

endmodule

