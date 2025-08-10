`timescale 1ns/1ns

module Odd3(input a, b, c, output w);
assign #(50, 50) w = ~a&~b&c | ~a&b&~c | a&~b&~c | a&b&c;
endmodule

module Majority(input a, b, c, output w);
assign #(30, 25) w = a&b | a&c | b&c;
endmodule

module oneBitAdder(input A, B, Cin, output S, Cout);
    Odd3 odd3(A, B, Cin, S);
    Majority maj(A, B, Cin, Cout);
endmodule

module twoBitAdder(  
    input [1:0] A,      
    input [1:0] B,      
    input Cin,            
    output [2:0] S               
);  
    wire carry0;  
 
    oneBitAdder adder0 (  
        .A(A[0]),   
        .B(B[0]),   
        .Cin(Cin),     
        .S(S[0]),     
        .Cout(carry0)   
    );  

     
    oneBitAdder adder1 (  
        .A(A[1]),   
        .B(B[1]),   
        .Cin(carry0),     
        .S(S[1]),      
        .Cout(S[2])    
    );  

endmodule


module threeBitAdder(  
    input [2:0] A,        
    input [2:0] B,        
    input Cin,             
    output [3:0] S        
);     

    twoBitAdder adder0 (  
        .A(A[1:0]),     
        .B(B[1:0]),   
        .Cin(Cin),      
        .S(S[1:0])
    ); 

    assign carry0 = adder0.S[2]; 
  
    oneBitAdder adder1 (  
        .A(A[2]),         
        .B(B[2]),           
        .Cin(carry0),      
        .S(S[2]),      
        .Cout(S[3])      
    );  
   
endmodule


module fourBitAdder(  
    input [3:0] A,         
    input [3:0] B,         
    input Cin,           
    output [4:0] S            
);   
 
    twoBitAdder adder0 (  
        .A(A[1:0]),         
        .B(B[1:0]),        
        .Cin(Cin),         
        .S(S[1:0])            
    );  

    assign carry0 = adder0.S[2];
  
    twoBitAdder adder1 (  
        .A(A[3:2]),         
        .B(B[3:2]),         
        .Cin(carry0),       
        .S(S[4:2])           
    );  

endmodule


module fiveBitAdder(  
    input [4:0] A,         
    input [4:0] B,         
    input Cin,           
    output [5:0] S         
);    
  
    threeBitAdder adder0 (  
        .A(A[2:0]),       
        .B(B[2:0]),       
        .Cin(Cin),       
        .S(S[2:0])        
    );  

    assign carry0 = adder0.S[3]; 

    twoBitAdder adder1 (  
        .A(A[4:3]),       
        .B(B[4:3]),     
        .Cin(carry0), 
        .S(S[5:3]) 
    );    
endmodule