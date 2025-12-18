`timescale 1ns/1ps
module top_module_tb();

// Parameters
parameter CLOCK_PERIOD = 10;
// parameter CLOCK_DIVISION_RATIO = 8'd10;

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
    // .clk_div_ratio_top(clock_div_ratio_tb),
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

    // Test normal mode
    #(4000*CLOCK_PERIOD);

    // Test set time mode
    mode_change(4'd5);

    increment_tick(4'd1);

    mode_change(4'd6);

    increment_tick(4'd2);   // left hour inc = 2
    // increment_tick();   // left hour inc = 2

    mode_change(4'd1);

    increment_tick(4'd2);   // right hour inc = 2
    // increment_tick();   // right hour inc = 2

    mode_change(4'd1);

    increment_tick(4'd5);   // left minute inc = 1
    // increment_tick();   // left minute inc = 2
    // increment_tick();   // left minute inc = 3
    // increment_tick();   // left minute inc = 4
    // increment_tick();   // left minute inc = 5

    mode_change(4'd1);

    increment_tick(4'd4);   // right minute inc = 1
    // increment_tick();   // right minute inc = 2
    // increment_tick();   // right minute inc = 3
    // increment_tick();   // right minute inc = 4

    mode_change(4'd1);


    #(CLOCK_PERIOD*1000)

    mode_change(4'd6);

    increment_tick(4'd1);   // start

    #(CLOCK_PERIOD*1000)

    mode_change(4'd1);  // split

    #(CLOCK_PERIOD*500)

    mode_change(4'd1);  // split release

    #(CLOCK_PERIOD*500)

    increment_tick(4'd1);    // stop

    #(CLOCK_PERIOD*10)

    mode_change(4'd1); // clear

    #(CLOCK_PERIOD*10)

    mode_change(4'd1);  // go to normal

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
    // clock_div_ratio_tb = CLOCK_DIVISION_RATIO;
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

endmodule