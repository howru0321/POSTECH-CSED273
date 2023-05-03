/* CSED273 lab5 experiment 2 */
/* lab5_2.v */

`timescale 1ns / 1ps

/* Implement srLatch */
module srLatch(
    input s, r,
    output q, q_
    );

    ////////////////////////
    assign q=~(r|q_);
    assign q_=~(q|s);
    ////////////////////////

endmodule

/* Implement master-slave JK flip-flop with srLatch module */
module lab5_2(
    input reset_n, j, k, clk,
    output q, q_
    );

    ////////////////////////
    assign MR=clk&k&q&reset_n|~reset_n;
    assign MS=clk&j&q_&reset_n;
    srLatch M(MS,MR,p,p_);
    assign SR=p_&~clk;
    assign SS=p&~clk;
    srLatch S(SS,SR,q,q_);
    ////////////////////////
    
endmodule