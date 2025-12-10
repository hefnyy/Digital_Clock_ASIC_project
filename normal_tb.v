`timescale 1ns / 1ps

module normal_tb;

    // Inputs
    reg clk;
    reg rst;
    reg set_time_flag;
    reg [4:0] i_hours;
    reg [5:0] i_minutes;

    // Outputs
    wire [4:0] o_hours;
    wire [5:0] o_minutes;

    // Instantiate the Unit Under Test (UUT)
    normal uut (
        .clk(clk),
        .rst(rst),
        .set_time_flag(set_time_flag),
        .i_hours(i_hours),
        .i_minutes(i_minutes),
        .o_hours(o_hours),
        .o_minutes(o_minutes)
    );

    // Clock generation
    initial begin
        clk = 0;
       forever begin
            #500000000 clk = ~clk; // 100 MHz clock (10ns period)
       end 
    end

    initial begin
        // Initialize Inputs
        rst = 0; // Active low reset
        set_time_flag = 0;
        i_hours = 0;
        i_minutes = 0;

        // Apply Reset
        #10 rst = 1; // Release reset
        
        // Test Case 1: Initial state after reset (should be 00:00)
        #20 $display("Time = %0d:%0d", o_hours, o_minutes);

        // Test Case 2: Set initial time to 10:30
        set_time_flag = 1;
        i_hours = 5'd10;
        i_minutes = 6'd30;
        #10 set_time_flag = 0; // Deassert set_time_flag
        #20 $display("Set Time = %0d:%0d", o_hours, o_minutes);

        // Test Case 3: Let the clock run for a few minutes
        $display("---------------------------------");
        $display("Simulating time progression:");
        $display("Time after some cycles = %0d:%0d", o_hours, o_minutes);
        $display("---------------------------------");

        // Test Case 4: Simulate passing an hour (e.g., from 23:59 to 00:00)
        // This would require a longer simulation or specific forcing of minutes/hours,
        // For a simple test, let's just observe progression from a set time.
        // Let's set time near midnight and observe it passing.
        set_time_flag = 1;
        i_hours = 5'd23;
        i_minutes = 6'd58;
        #10 set_time_flag = 0;
        #20 $display("Set Time near midnight = %0d:%0d", o_hours, o_minutes);
        $display("Time after more cycles (near midnight) = %0d:%0d", o_hours, o_minutes);

        $finish; // End simulation
    end

    // Optional: Define a macro for number of cycles to simulate
    `define N_CYCLES 600 // Simulate 600 seconds, which is 10 minutes

    // Monitor changes for debugging
    initial begin
        $monitor("Time %0t: Current Time = %0d:%0d, set_time_flag = %b, i_hours = %0d, i_minutes = %0d", 
                 $time, o_hours, o_minutes, set_time_flag, i_hours, i_minutes);
    end

    // Dump waveforms (optional)
    initial begin
        $dumpfile("normal_tb.vcd");
        $dumpvars(0, normal_tb);
    end

endmodule
