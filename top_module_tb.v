`timescale 1ns/1ps
module top_module_tb();

// Parameters
parameter CLOCK_PERIOD = 10;

// Signals
reg mode_button_tb;
reg inc_button_tb;
reg clk_tb;
reg rst_tb;
reg [7:0] clock_div_ratio_tb;
wire alarm_sound_tb;
wire [5:0] hours_fsm_tb;
wire [5:0] minutes_fsm_tb;

// DUT instance
top_module top_module_inst (
    .mode_button_top(mode_button_tb),
    .inc_button_top(inc_button_tb),
    .clk_top(clk_tb),
    .rst_top(rst_tb),
    .alarm_sound_top(alarm_sound_tb),
    .hours_fsm_top(hours_fsm_tb),
    .minutes_fsm_top(minutes_fsm_tb)
);

// Clock generation
always #(CLOCK_PERIOD/2) clk_tb = ~clk_tb;

initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars();

    // Initialize signals
    initialize();
    // Reset DUT
    reset();

    // TEST NORMAL MODE
    #(400*CLOCK_PERIOD);

    // TEST ALARM MODE
    test_alarm_mode();

    // TEST STOP WATCH MODE
    test_stopwatch_basic();

    // TEST SET TIME MODE and (Test Alarm Sound)
    test_set_time_mode();

    // TEST SPLIT MODE IN STOP WATCH
    test_stopwatch_split();

    mode_change(6);     // Go to Normal Mode

    #(CLOCK_PERIOD*100)

    $stop;

end

// Task to initialize signals
task initialize;
begin
    mode_button_tb = 1'b0;
    inc_button_tb = 1'b0;
    clk_tb = 1'b0;
    rst_tb = 1'b0;
end
endtask

// Task to reset the DUT
task reset;
begin
    rst_tb = 1'b1;
    #(CLOCK_PERIOD);
    rst_tb = 1'b0;
    #(CLOCK_PERIOD);
    rst_tb = 1'b1;
end
endtask


// Task for mode change
task mode_change;
input [3:0] modes_counter;
integer i;
begin
    for ( i = 0 ; i < modes_counter ; i = i + 1 ) begin
        @(negedge clk_tb)
        mode_button_tb = 1'b1;
        @(negedge clk_tb)
        mode_button_tb = 1'b0;
    end
end
endtask

// Task for increment button
task increment_tick;
input [3:0] modes_counter;
integer i;
begin
    for ( i = 0 ; i < modes_counter ; i = i + 1 ) begin
        @(negedge clk_tb)
        inc_button_tb = 1'b1;
        @(negedge clk_tb)
        inc_button_tb = 1'b0;
    end
end
endtask

//==================== TEST ALARM MODE ====================
task test_alarm_mode;
begin
    mode_change(1);     // Go to Alarm Mode

    increment_tick(2);  // left hours = 2
    mode_change(1);     // right hours
    increment_tick(7);  // right hours = 3

    mode_change(1);     // left minutes
    increment_tick(4);  // left minutes = 4

    mode_change(1);     // right minutes
    increment_tick(5);  // right minutes = 5

    mode_change(1);     // Alarm on/off
    increment_tick(1);  // Set alarm ON
end
endtask

//==================== TEST STOP WATCH MODE ====================
task test_stopwatch_basic;
begin
    mode_change(1);     // Go to Stop Watch Mode
    increment_tick(1);  // Start Timer

    #(40*CLOCK_PERIOD);

    increment_tick(1);  // Stop Timer
    mode_change(1);     // Clear
end
endtask

//==================== TEST SET TIME MODE ====================
task test_set_time_mode;
begin
    mode_change(1);     // Go to Set Time Mode (Set left hours) and (Test Alarm Sound)

    increment_tick(2);  // left hours = 2
    mode_change(1);     // right hours
    increment_tick(3);  // right hours = 3

    mode_change(1);     // left minutes
    increment_tick(4);  // left minutes = 4

    mode_change(1);     // right minutes
    increment_tick(4);  // right minutes = 4

    mode_change(1);     // Set Time Active
    increment_tick(1);  // Activate time setting

    mode_change(1);     // Go to Normal Mode
    #(CLOCK_PERIOD*100);
end
endtask

//==================== TEST SPLIT MODE IN STOP WATCH ====================
task test_stopwatch_split;
begin
    mode_change(6);      // Go to Stop Watch Mode

    increment_tick(1);   // Start Timer
    #(CLOCK_PERIOD*50);

    increment_tick(1);   // Stop Timer
    #(CLOCK_PERIOD*10);

    increment_tick(1);   // Start again
    #(CLOCK_PERIOD*50);

    mode_change(1);      // Split
    #(CLOCK_PERIOD*50);

    mode_change(1);      // Split Release
    #(CLOCK_PERIOD*50);

    increment_tick(1);   // Stop Timer
    mode_change(1);      // Clear
end
endtask

endmodule