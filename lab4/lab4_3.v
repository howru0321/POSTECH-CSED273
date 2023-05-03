/* CSED273 lab4 experiment 3 */
/* lab4_3.v */

/* Implement 5-Bit Ripple Subtractor
 * You must use lab4_2 module in lab4_2.v
 * You may use keword "assign" and bitwise opeartor
 * or just implement with gate-level modeling*/
module lab4_3(
    input [4:0] in_a,
    input [4:0] in_b,
    input in_c,
    output [4:0] out_s,
    output out_c
    );

    ////////////////////////
   wire [4:0] v;
    not(v[0], in_b[0]);
    not(v[1], in_b[1]);
    not(v[2], in_b[2]);
    not(v[3], in_b[3]);
    not(v[4], in_b[4]);
   lab4_2 Ripple(in_a, v, in_c, out_s, out_c);
    ////////////////////////

endmodule