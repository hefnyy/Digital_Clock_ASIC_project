`timescale 1ps/1ps

module set_alarm_tb ();
    reg clk, rst, set_alarm_en;
    reg mode_button, inc_button;
    wire [1:0] o_hours_left;
    wire [3:0] o_hours_right;
    wire [2:0] o_minutes_left;
    wire [3:0] o_minutes_right;
    wire ack_flag; 
    wire on_off_alarm;

    set_alarm DUT (clk,rst,set_alarm_en,mode_button,inc_button,
        o_hours_left,o_hours_right,o_minutes_left,o_minutes_right,ack_flag,on_off_alarm);

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

        integer i;
    initial begin
        rst = 1;
        @(negedge clk);
        rst = 0;
        @(negedge clk);
        @(negedge clk);
        rst = 1;
        set_alarm_en = 1;
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
        @(negedge clk);
        mode_button = 1;
        @(negedge clk);
        mode_button = 0;
        for (i = 0; i<20 ; i = i + 1  ) begin
            @(negedge clk);
            inc_button = 1;
            @(negedge clk);
            inc_button = 0;
        end
        @(negedge clk);
        mode_button = 1;
        @(negedge clk);
        mode_button = 0;
        @(negedge clk);
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
        @(negedge clk);
        mode_button = 1;
        @(negedge clk);
        mode_button = 0;
        @(negedge clk);
        set_alarm_en = 0;

        #20;
        $finish;

    end
endmodule