/* CSED273 lab6 experiment 3 */
/* lab6_3.v */

`timescale 1ps / 1fs

/* Implement 369 game counter (0, 3, 6, 9, 13, 6, 9, 13, 6 ...)
 * You must first implement D flip-flop in lab6_ff.v
 * then you use D flip-flop of lab6_ff.v */
module counter_369(input reset_n, input clk, output [3:0] count);

    ////////////////////////
    wire [3:0] C_temp;
    edge_trigger_D_FF Ad(reset_n,~count[0]|(count[3]&~count[2]),clk,count[0],C_temp[0]);
    edge_trigger_D_FF Bd(reset_n,(~count[3]&~count[2])|(count[3]&count[2]),clk,count[1],C_temp[1]);
    edge_trigger_D_FF Cd(reset_n,count[0],clk,count[2],C_temp[2]);
    edge_trigger_D_FF Dd(reset_n,(count[1]&~count[0])|(count[3]&~count[2]),clk,count[3],C_temp[3]);
    ////////////////////////
	
endmodule
