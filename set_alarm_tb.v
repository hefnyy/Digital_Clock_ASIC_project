`timescale 1ps/1ps

module set_alarm_tb ();
    reg clk, rst, set_alarm_en;
    reg mode_button, inc_button;
    wire [4:0] o_hours;
    wire [5:0] o_minutes;
    wire ack_flag; 
    wire on_off_alarm;

    set_alarm DUT (clk,rst,set_alarm_en,mode_button,inc_button,
        o_hours,o_minutes,ack_flag,on_off_alarm);

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

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
        @(negedge clk);
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
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