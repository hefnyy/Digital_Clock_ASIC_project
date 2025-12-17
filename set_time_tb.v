`timescale 1ps/1ps

module set_time_tb ();
    reg clk, rst, set_time_en;
    reg mode_button, inc_button;
    wire [4:0] o_hours;
    wire [5:0] o_minutes;
    wire ack_flag; 

    set_time DUT (clk,rst,set_time_en,mode_button,inc_button,
        o_hours,o_minutes,ack_flag);

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
        set_time_en = 1;
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
        @(negedge clk);
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
        @(negedge clk);
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
        @(negedge clk); // hours = 3
        mode_button = 1;
        @(negedge clk);
        mode_button = 0;
        @(negedge clk);
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
        @(negedge clk);
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
        @(negedge clk); // minutes = 2
        mode_button = 1;
        @(negedge clk)
        set_time_en = 0;


        #20;
        $stop;

    end
endmodule