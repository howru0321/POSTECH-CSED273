`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/13 13:40:03
// Design Name: 
// Module Name: zerogame
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
 
module encoder(
    input wire [7:0]in,
    output [2:0]out
    );
    
    or(out[2],in[4],in[5],in[6]);
    or(out[1],in[2],in[3],in[6]);
    or(out[0],in[1],in[3],in[5]);

endmodule

module selector(
    input wire [7:0]in,
    input wire clk,
    output [2:0]out
    );
    
    wire [2:0] enc_out; 
    encoder sel(in, enc_out);
    edge_trigger_D_FF ff0(1, enc_out[0], clk, out[0], ~out[0]);
    edge_trigger_D_FF ff1(1, enc_out[1], clk, out[1], ~out[1]);
    edge_trigger_D_FF ff2(1, enc_out[2], clk, out[2], ~out[2]);
    
endmodule

module halfAdder(
    input in_a,
    input in_b,
    output out_s,
    output out_c
    );

    xor(out_s,in_a,in_b);
    and(out_c, in_a, in_b);

endmodule

module fullAdder(
    input in_a,
    input in_b,
    input in_c,
    output out_s,
    output out_c
    );

    halfAdder PPA(in_a, in_b, S, C1);
    halfAdder PPB(in_c, S, out_s, C2);
    or(out_c, C2, C1);

endmodule

module bit2adder( // 3비트 애더 
    input wire [2:0] n1,
    input wire [2:0] n2,
    output wire [2:0] n
);


fullAdder FA1(n1[0], n2[0], 0, n[0], cin_1);
fullAdder FA2(n1[1], n2[1], cin_1, n[1], cin_2);
fullAdder FA3(n1[2], n2[2], cin_2, n[2], cin_3);



endmodule

module edge_trigger_JKFF(input reset_n, input j, input k, input clk, output reg q, output reg q_);  

    initial begin
      q = 0;
      q_ = ~q;
    end //초기화
    
    always @(negedge clk) begin
        q = reset_n & (j&~q | ~k&q);
        q_ = ~reset_n | ~q;
    end

endmodule

module edge_trigger_D_FF(input reset_n, input d, input clk, output q, output q_);   
    edge_trigger_JKFF temp(reset_n,d,~d,clk,q,q_);
endmodule

module player(
    input wire [1:0] player11,
    input wire [1:0] player22,
    input wire [1:0] player33,
    input wire clk,
    output wire [2:0] out
    );
    
    wire [2:0] player1;
    wire [2:0] player2;
    wire [2:0] player3;
    wire [2:0] temp;
    wire [2:0] temp1; 
    wire [2:0] temp2;
    wire [2:0] temp3; 

    edge_trigger_D_FF(1,player11[0],clk,player1[0],~player1[0]);
    edge_trigger_D_FF(1,player11[1],clk,player1[1],~player1[1]);
    edge_trigger_D_FF(1,player22[0],clk,player2[0],~player2[0]);
    edge_trigger_D_FF(1,player22[1],clk,player2[1],~player2[1]);
    edge_trigger_D_FF(1,player33[0],clk,player3[0],~player3[0]);
    edge_trigger_D_FF(1,player33[1],clk,player3[1],~player3[1]);
    
    fullAdder(player1[0],player1[1], 0, temp1[0], temp1[1]);
    fullAdder(player2[0],player2[1], 0, temp2[0], temp2[1]);
    fullAdder(player3[0],player3[1], 0, temp3[0], temp3[1]);
    
   bit2adder BA1(temp1, temp2, temp);
   bit2adder BA2(temp, temp3, out);
   
   
   
    
    
    
endmodule

module compare(
    input wire [2:0]sel,
    input wire [2:0]sum,
    output same
    );
    
    xnor(n2, sel[2],sum[2]);
    xnor(n1, sel[1],sum[1]);
    xnor(n0, sel[0],sum[0]);
    and(same, n2, n1, n0);
    
endmodule

module mux(
    input wire [7:0] data_input,
    input wire [2:0] select_input,
    output wire out
    );

    wire i0, i1, i2, i3, i4, i5, i6, i7;// i7
    and(i0, select_input[2], select_input[1], select_input[0], data_input[0]);
    and(i1, select_input[2], select_input[1],  ~select_input[0], data_input[1]);
    and(i2, select_input[2],  ~select_input[1], select_input[0], data_input[2]);
    and(i3, select_input[2],  ~select_input[1],  ~select_input[0], data_input[3]);
    and(i4,  ~select_input[2], select_input[1], select_input[0], data_input[4]);
    and(i5,  ~select_input[2], select_input[1],  ~select_input[0], data_input[5]);
    and(i6,  ~select_input[2],  ~select_input[1], select_input[0], data_input[6]);
    and(i7,  ~select_input[2],  ~select_input[1],  ~select_input[0], data_input[7]);
    or(out, i0, i1, i2, i3, i4, i5, i6, i7);//,i7

endmodule

module mux_8_1(
    input wire[2:0] select,
    output wire[7:0] out
);

    wire [7:0] a0=8'b10110110; //A
    wire [7:0] a1=8'b11111000; //B
    wire [7:0] a2=8'b11011110; //C
    wire [7:0] a3=8'b10110110; //D
    wire [7:0] a4=8'b10100010; //E
    wire [7:0] a5=8'b10001110; //F
    wire [7:0] a6=8'b00111110; //G
    wire [7:0] a7=8'b00000000; //DOT
    
    mux(a0,select,out[0]);
    mux(a1,select,out[1]);
    mux(a2,select,out[2]);
    mux(a3,select,out[3]);
    mux(a4,select,out[4]);
    mux(a5,select,out[5]);
    mux(a6,select,out[6]);
    mux(a7,select,out[7]);
    

endmodule

module zerogame(

    input wire [7:0] sel_in,
    
    input wire clk, 
    
    input wire [1:0] p1,
    input wire [1:0] p2,
    input wire [1:0] p3,
    output same,
    
    output wire [7:0] seg1,
    output wire [7:0] seg2
    
    );
   
    wire [2:0] sel_out;
    wire [2:0] sum_out;
    

selector sel(sel_in, clk, sel_out);
player sum(p1, p2, p3, clk, sum_out);

compare compare(sel_out, sum_out, same);


mux_8_1 mux_seg1(sel_out,seg1);
mux_8_1 mux_seg2(sum_out,seg2);


endmodule

