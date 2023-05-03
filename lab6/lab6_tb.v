/* CSED273 lab6 experiments */
/* lab6_tb.v */

`timescale 1ps / 1fs

module lab6_tb();

    integer Passed;
    integer Failed;

    /* Define input, output and instantiate module */
    ////////////////////////
    reg reset_n_d1,reset_n_d2,reset_n_369,clk;
    wire q,q_;
    wire [3:0] count_d1; 
    wire [7:0] count_d2;
    wire [3:0] count_369;
    decade_counter C_d1(
        .reset_n(reset_n_d1),
        .clk(clk),
        .count(count_d1)
        );
    decade_counter_2digits C_d2(
        .reset_n(reset_n_d2),
        .clk(clk),
        .count(count_d2)
        );
    counter_369 C_369(
        .reset_n(reset_n_369),
        .clk(clk),
        .count(count_369)
        );
    ////////////////////////

    initial begin
        Passed = 0;
        Failed = 0;

        lab6_1_test;
        lab6_2_test;
        lab6_3_test;

        $display("Lab6 Passed = %0d, Failed = %0d", Passed, Failed);
        $finish;
    end

    /* Implement test task for lab6_1 */
    task lab6_1_test;
        ////////////////////////
        integer i,j; 
        reg [3:0] count_6_1;
        begin
        reset_n_d1=0;
        reset_n_d2=0;
        reset_n_369=0;
        #1
        reset_n_d1=1;
        clk=1;
        for(i=0;i<10;i=i+1)
        begin
        count_6_1=4'b0000;
        for(j=0;j<10;j=j+1)
        begin
        if(count_d1===count_6_1)
        begin
        Passed=Passed+1;
        end
        else
        begin
        Failed=Failed+1;
        end
        #1
        clk=0;
        #1
        clk=1;
        count_6_1=count_6_1+4'b0001;
        end
        end
        end
        ////////////////////////
    endtask

    /* Implement test task for lab6_2 */
    task lab6_2_test;
        ////////////////////////
        integer i,j,k; 
        reg [3:0] count_6_2_1;
        reg [3:0] count_6_2_10;
        begin
        #1
        reset_n_d2=1;
        clk = 1;
        for(k=0;k<4;k =k+1)
        begin
        count_6_2_10=4'b0000;
        for(i=0;i<10;i=i+1)
        begin
        count_6_2_1=4'b0000;
        for(j=0;j<10;j=j+1)begin
        if(count_d2==={count_6_2_10,count_6_2_1})
        begin
        Passed=Passed+1;
        end
        else begin
        Failed=Failed+1;
        end
        #1
        clk = 0;
        #1
        clk=1;
        count_6_2_1=count_6_2_1+4'b0001;
        end
        count_6_2_10=count_6_2_10+4'b0001;
        end
        end
        end
        ////////////////////////
    endtask

    /* Implement test task for lab6_3 */
    task lab6_3_test;
        ////////////////////////
        integer i;
        reg [3:0] count_6_3;
        begin
        count_6_3=4'b0000;
        reset_n_369=1;
        for(i=0;i<57;i=i+1)
        begin
        if(count_369===count_6_3)
        begin
        Passed=Passed+1;
        end
        else begin
        Failed=Failed+1;
        end
        #1 
        clk=0;
        #1
        clk=1;
        if (count_6_3===4'b0000)
        begin
        count_6_3=4'b0011;
        end
        else if(count_6_3===4'b0011)
        begin
        count_6_3=4'b0110;
        end
        else if(count_6_3===4'b0110)
        begin
        count_6_3=4'b1001;
        end
        else if(count_6_3===4'b1001)
        begin
        count_6_3=4'b1101;
        end
        else if(count_6_3===4'b1101)
        begin
        count_6_3=4'b0110;
        end
        end
        end
        ////////////////////////
    endtask

endmodule