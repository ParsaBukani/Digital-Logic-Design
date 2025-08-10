`timescale 1ns/1ns

module OnesCounter7(input [6:0] A, output [2:0] S);

	wire [1:0] sum0, sum1;

	oneBitAdder adder1 (  
        .A(A[0]),   
        .B(A[1]),   
        .Cin(A[2]),     
        .S(sum0[0]),     
        .Cout(sum0[1])   
	);
	oneBitAdder adder2 (  
        .A(A[3]),   
        .B(A[4]),   
        .Cin(A[5]),     
        .S(sum1[0]),     
        .Cout(sum1[1])   
	);
	twoBitAdder adder3 (  
        .A(sum0),     
        .B(sum1),   
        .Cin(A[6]),      
        .S(S)
	);
endmodule


module OnesCounter15(input [14:0] A, output [3:0] S);

	wire [2:0] sum0, sum1;

	OnesCounter7 adder1(
	.A(A[6:0]), 
	.S(sum0)
	);
	OnesCounter7 adder2(
	.A(A[13:7]),
	.S(sum1)
	);
	threeBitAdder adder3(  
        .A(sum0),       
        .B(sum1),       
        .Cin(A[14]),       
        .S(S)        
        );
endmodule


module OnesCounter31(input [30:0] A, output [4:0] S);

	wire [3:0] sum0, sum1;

	OnesCounter15 adder1(
	.A(A[14:0]), 
	.S(sum0)
	);
	OnesCounter15 adder2(
	.A(A[29:15]),
	.S(sum1)
	);
	fourBitAdder adder3(  
        .A(sum0),       
        .B(sum1),       
        .Cin(A[30]),       
        .S(S)        
        );
endmodule


module OnesCounter63(input [62:0] A, output [5:0] S);

	wire [4:0] sum0, sum1;

	OnesCounter31 adder1(
	.A(A[30:0]), 
	.S(sum0)
	);
	OnesCounter31 adder2(
	.A(A[61:31]),
	.S(sum1)
	);
	fiveBitAdder adder3(  
        .A(sum0),       
        .B(sum1),       
        .Cin(A[62]),       
        .S(S)        
        );
endmodule


