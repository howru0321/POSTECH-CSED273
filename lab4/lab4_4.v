/* CSED273 lab4 experiment 4 */
/* lab4_4.v */

/* Implement 5x3 Binary Mutliplier
 * You must use lab4_2 module in lab4_2.v
 * You cannot use fullAdder or halfAdder module directly
 * You may use keword "assign" and bitwise opeartor
 * or just implement with gate-level modeling*/
module lab4_4(
    input [4:0]in_a,
    input [2:0]in_b,
    output [7:0]out_m
    );

    ////////////////////////
    assign out_m[0]=in_a[0]&in_b[0];
    
     wire [4:0]A;
     wire [4:0]B;
     assign A[0]=(in_a[1]&in_b[0]);
     assign A[1]=(in_a[2]&in_b[0]);
     assign A[2]=(in_a[3]&in_b[0]);
     assign A[3]=(in_a[4]&in_b[0]);
     assign A[4]=0;
     assign B[0]=(in_a[0]&in_b[1]);
     assign B[1]=(in_a[1]&in_b[1]);
     assign B[2]=(in_a[2]&in_b[1]);
     assign B[3]=(in_a[3]&in_b[1]);
     assign B[4]=(in_a[4]&in_b[1]);
     
     
 
     wire [4:0] S1;
     wire C1;
     lab4_2 AA (A, B, 0, S1, C1);
     
     assign out_m[1]=S1[0];
        
     wire [4:0]C;
     assign C[0]=S1[1];
     assign C[1]=S1[2];
     assign C[2]=S1[3];
     assign C[3]=S1[4];
     assign C[4]=C1;
   
     wire [4:0]D;
     assign D[0]=(in_a[0]&in_b[2]);
     assign D[1]=(in_a[1]&in_b[2]);
     assign D[2]=(in_a[2]&in_b[2]);
     assign D[3]=(in_a[3]&in_b[2]);
     assign D[4]=(in_a[4]&in_b[2]);
    
     wire [4:0]S2;
     wire C2;
     lab4_2 BB (C, D, 0, S2, C2);
        
     assign out_m[2]=S2[0];
     assign out_m[3]=S2[1];
     assign out_m[4]=S2[2];
     assign out_m[5]=S2[3];
     assign out_m[6]=S2[4];
     assign out_m[7]=C2;
    ////////////////////////
    
endmodule