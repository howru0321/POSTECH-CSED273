/* CSED273 lab5 experiment 1 */
/* lab5_1.v */

`timescale 1ps / 1fs

/* Implement adder 
 * You must not use Verilog arithmetic operators */
module adder(
    input [3:0] x,
    input [3:0] y,
    input c_in,             // Carry in
    output [3:0] out,
    output c_out            // Carry out
); 

    ////////////////////////
    assign c0_xor=x[0]^y[0];
    assign c0_and1=x[0]&y[0];
    assign c0_and2=c_in&c0_xor;
    
    assign c1=c0_and2|c0_and1;
    assign out[0]=c0_xor^c_in;
    
    
    assign c1_xor=x[1]^y[1];
    assign c1_and1=x[1]&y[1];
    assign c1_and2=c1&c1_xor;
    
    assign c2=c1_and2|c1_and1;
    assign out[1]=c1_xor^c1;
    
    
    assign c2_xor=x[2]^y[2];
    assign c2_and1=x[2]&y[2];
    assign c2_and2=c2&c2_xor;
    
    assign c3=c2_and2|c2_and1;
    assign out[2]=c2_xor^c2;
    
    
    assign c3_xor=x[3]^y[3];
    assign c3_and1=x[3]&y[3];
    assign c3_and2=c3&c3_xor;
    
    assign c_out=c3_and2|c3_and1;
    assign out[3]=c3_xor^c3;
    ////////////////////////

endmodule

/* Implement arithmeticUnit with adder module
 * You must use one adder module.
 * You must not use Verilog arithmetic operators */
module arithmeticUnit(
    input [3:0] x,
    input [3:0] y,
    input [2:0] select,
    output [3:0] out,
    output c_out            // Carry out
);

    ////////////////////////
    wire [3:0] A;
    
    assign A[3]=select[2]&~y[3]|select[1]&y[3];
    assign A[2]=select[2]&~y[2]|select[1]&y[2];
    assign A[1]=select[2]&~y[1]|select[1]&y[1];
    assign A[0]=select[2]&~y[0]|select[1]&y[0];
    
    adder ADDER(A[3:0], x[3:0], select[0], out[3:0], c_out);///////////////////////

endmodule

/* Implement 4:1 mux */
module mux4to1(
    input [3:0] in,
    input [1:0] select,
    output out
);

    ////////////////////////
    assign out=~select[0]&~select[1]&in[0]|select[0]&~select[1]&in[1]|~select[0]&select[1]&in[2]|select[0]&select[1]&in[3];
    ////////////////////////

endmodule

/* Implement logicUnit with mux4to1 */
module logicUnit(
    input [3:0] x,
    input [3:0] y,
    input [1:0] select,
    output [3:0] out
);

    ////////////////////////
    wire [3:0] A;
    wire [3:0] B;
    wire [3:0] C;
    wire [3:0] D;

    assign A[0]=x[3]&y[3];
    assign A[1]=x[3]|y[3];
    assign A[2]=x[3]^y[3];
    assign A[3]=~x[3];
    
    assign B[0]=x[2]&y[2];
    assign B[1]=x[2]|y[2];
    assign B[2]=x[2]^y[2];
    assign B[3]=~x[2];
    
    assign C[0]=x[1]&y[1];
    assign C[1]=x[1]|y[1];
    assign C[2]=x[1]^y[1];
    assign C[3]=~x[1];
    
    assign D[0]=x[0]&y[0];
    assign D[1]=x[0]|y[0];
    assign D[2]=x[0]^y[0];
    assign D[3]=~x[0];
    
    mux4to1 MUX1(A, select[1:0], out[3]);
    mux4to1 MUX2(B, select[1:0], out[2]);
    mux4to1 MUX3(C, select[1:0], out[1]);
    mux4to1 MUX4(D, select[1:0], out[0]);
    ////////////////////////

endmodule

/* Implement 2:1 mux */
module mux2to1(
    input [1:0] in,
    input  select,
    output out
);

    ////////////////////////
    assign out=~select&in[0]|select&in[1];
    ////////////////////////

endmodule

/* Implement ALU with mux2to1 */
module lab5_1(
    input [3:0] x,
    input [3:0] y,
    input [3:0] select,
    output [3:0] out,
    output c_out            // Carry out
);

    ////////////////////////
   wire [3:0] Ar;
   wire [3:0] Lo;
   
   arithmeticUnit ArUnit(x,y,select[2:0],Ar,c_out);
   
   logicUnit LoUnit(x,y,select[1:0],Lo);
   
    mux2to1 MUX210({Lo[0],Ar[0]}, select[3],out[0]);
    mux2to1 MUX211({Lo[1],Ar[1]}, select[3],out[1]);
    mux2to1 MUX212({Lo[2],Ar[2]}, select[3],out[2]);
    mux2to1 MUX213({Lo[3],Ar[3]}, select[3],out[3]);
    ////////////////////////

endmodule
