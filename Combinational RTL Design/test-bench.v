`timescale 1ns/1ns

module one_bit_adder_TB();
    reg A = 0, B = 0, Cin = 0;
    wire S, Cout;
    oneBitAdder uut(A, B, Cin, S, Cout);       // unit under test

    initial begin 
	#150 A = 1;
	#100 B = 1;
	#150 $stop;
    end
endmodule


module two_bit_adder_TB();
    reg [1:0] A;       
    reg [1:0] B;       
    reg Cin = 0;           
    wire [2:0] S;                 

     
    twoBitAdder uut(
        .A(A),  
        .B(B),  
        .Cin(Cin),  
        .S(S)
    ); 

    initial begin
	A = 2'd0; B = 2'd0;
	#150 A = 2'd1; B = 2'd0;
	#100 A = 2'd1; B = 2'd1;
	#100 A = 2'd1; B = 2'd2;
	#100 A = 2'd1; B = 2'd3;
	#100 A = 2'd2; B = 2'd2;
	#100 A = 2'd2; B = 2'd3;
	#100 A = 2'd3; B = 2'd3;
	#150 $stop;
     end
endmodule


module three_bit_adder_TB();
    reg [2:0] A;       
    reg [2:0] B;       
    reg Cin = 0;           
    wire [3:0] S;                 

    threeBitAdder uut(
        .A(A),  
        .B(B),  
        .Cin(Cin),  
        .S(S) 
    ); 

    initial begin
	A = 3'd3; B = 3'd2;
	#150 A = 3'd1; B = 3'd2;
	#150 A = 3'd1; B = 3'd3;
	#150 A = 3'd1; B = 3'd5;
	#150 A = 3'd1; B = 3'd7;
	#150 A = 3'd2; B = 3'd4;
	#100 A = 3'd2; B = 3'd5;
	#100 A = 3'd3; B = 3'd6;
	#100 A = 3'd3; B = 3'd7;
	#100 A = 3'd4; B = 3'd4;
	#100 A = 3'd4; B = 3'd5;
	#100 A = 3'd4; B = 3'd6;
	#100 A = 3'd4; B = 3'd7;
	#100 A = 3'd5; B = 3'd5;
	#100 A = 3'd5; B = 3'd6;
	#100 A = 3'd5; B = 3'd7;
	#100 A = 3'd6; B = 3'd6;
	#100 A = 3'd6; B = 3'd7;
	#100 A = 3'd7; B = 3'd7;
	#150 $stop;
     end
endmodule


module four_bit_adder_TB();
    reg [3:0] A;       
    reg [3:0] B;       
    reg Cin = 0;           
    wire [4:0] S;                 

    fourBitAdder uut(
        .A(A),  
        .B(B),  
        .Cin(Cin),  
        .S(S) 
    ); 

    initial begin
	A = 4'd5; B = 4'd7;
	#150 A = 4'd5; B = 4'd8;
	#100 A = 4'd5; B = 4'd9;
	#100 A = 4'd5; B = 4'd12;
	#100 A = 4'd5; B = 4'd14;
	#100 A = 4'd5; B = 4'd15;
	#100 A = 4'd12; B = 4'd13;
	#100 A = 4'd14; B = 4'd13;
	#100 A = 4'd15; B = 4'd14;
	#100 A = 4'd15; B = 4'd15;
	#250 $stop;
     end
endmodule


module five_bit_adder_TB();
    reg [4:0] A;       
    reg [4:0] B;       
    reg Cin = 0;           
    wire [5:0] S;                 

    fiveBitAdder uut(
        .A(A),  
        .B(B),  
        .Cin(Cin),  
        .S(S) 
    ); 

    initial begin
	A = 5'd20; B = 5'd10;
	#150 A = 5'd20; B = 5'd11;
	#100 A = 5'd20; B = 5'd12;
	#100 A = 5'd20; B = 5'd13;
	#100 A = 5'd30; B = 5'd28;
	#100 A = 5'd30; B = 5'd30;
	#100 A = 5'd30; B = 5'd31;
	#100 A = 5'd31; B = 5'd31;
	#150 $stop;
     end
endmodule


module OnesCounter7_TB();
	reg [6:0] A;
	wire [2:0] S;

	OnesCounter7 uut(A, S);
	initial begin
	     A = 7'b0010101;
	#150 A = 7'b1110101;
	#150 A = 7'b0001001;
	#200 $stop;
	end
endmodule

module OnesCounter15_TB();
	reg [14:0] A;
	wire [3:0] S;

	OnesCounter15 uut(A, S);
	initial begin
	     A = 15'b001010100000000;
	#250 A = 15'b111010101010000;
	#250 A = 15'b010110101010101;
	#500 $stop;
	end
endmodule

module OnesCounter31_TB();
	reg [30:0] A;
	wire [4:0] S;

	OnesCounter31 uut(A, S);
	initial begin
	     A = 31'b0010101000000000100001000010001;
	#450 A = 31'b1110101010100001000100010001000;
	#450 A = 31'b0101101010101010010010010010010;
	#1000 $stop;
	end
endmodule

module OnesCounter63_TB();
	reg [62:0] A;
	wire [5:0] S;

	OnesCounter63 uut(A, S);
	initial begin
	     A = 63'b001010100000000010000100001000100010001000100010001000100010001;
	#700 A = 63'b111010101010000100010001000100010000001010001001001001001001001;
	#700 A = 63'b010110101010101001001001001001010101010101010101010101010101010;
	#700 A = 63'b110110101010101101101101101101010101010101010101010101010101011;
	#1000 $stop;
	end
endmodule



