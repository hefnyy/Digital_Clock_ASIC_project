`timescale 1ns / 1ps

module stop_watch_tb;

    // ------------------------------------------------
    // 1. Signal Declaration
    // ------------------------------------------------
    // Inputs to DUT (Regs)
    reg clk;
    reg rst;
    reg mode_button;
    reg inc_button;
    reg stop_watch_en;

    // Outputs from DUT (Wires)
    wire stop_watch_ack_flag;
    wire [5:0] o_minutes;
    wire [5:0] o_seconds;

    // Internal Variables for testing
    integer i;

    // ------------------------------------------------
    // 2. DUT Instantiation
    // ------------------------------------------------
    stop_watch uut (
        .clk(clk),
        .rst(rst),
        .mode_button(mode_button),
        .inc_button(inc_button),
        .stop_watch_en(stop_watch_en),
        .stop_watch_ack_flag(stop_watch_ack_flag),
        .o_minutes(o_minutes),
        .o_seconds(o_seconds)
    );

    // ------------------------------------------------
    // 3. Clock Generation
    // ------------------------------------------------
    // 100MHz clock (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ------------------------------------------------
    // 4. Tasks for Button Simulation
    // ------------------------------------------------
    // Simulates a single clock cycle pulse for the Increment/Start button
    task press_inc();
    begin
        @(negedge clk);
        inc_button = 1;
        @(negedge clk);
        inc_button = 0;
    end
    endtask

    // Simulates a single clock cycle pulse for the Mode button
    task press_mode();
    begin
        @(negedge clk);
        mode_button = 1;
        @(negedge clk);
        mode_button = 0;
    end
    endtask

    // ------------------------------------------------
    // 5. Test Stimulus
    // ------------------------------------------------
    initial begin
        // Setup monitoring for easier debugging
        $timeformat(-9, 0, " ns", 6);
        $monitor("Time=%t | En=%b | ModeCnt=%d | IncCnt=%b | Flag=%b | Out=%02d:%02d | ACK=%b", 
                 $time, stop_watch_en, uut.modes_counter, uut.inc_counter, uut.split_flag, o_minutes, o_seconds, stop_watch_ack_flag);

        // --- Initialize Inputs ---
        rst = 1; // Active low reset usually starts high
        mode_button = 0;
        inc_button = 0;
        stop_watch_en = 0;

        // --- Apply Reset ---
        $display("\n--- [1] Applying Reset ---");
        #20 rst = 0; // Assert Reset (Active Low)
        #20 rst = 1; // Deassert Reset
        
        // --- Enable Block ---
        #10 stop_watch_en = 1;

        // --- Start Timer (Normal Counting) ---
        $display("\n--- [2] Start Timer (Normal Mode) ---");
        // Note: Based on your logic, you might need to cycle modes or flags to see 'Normal' time 
        // depending on how split_flag initializes.
        // Let's press Start (Inc Button)
        press_inc(); 

        // Let it run for 10 seconds (10 clock cycles in this design)
        #100; 

        // --- Test Split Feature ---
        $display("\n--- [3] Enter Split Mode (Freeze Display) ---");
        // Pressing mode button increments modes_counter.
        // If modes_counter == 1, split_flag becomes 1.
        press_mode(); 
        
        // Wait and observe: Output should freeze, but internal counters (normal_seconds) continue
        #50; 
        $display("    (Internal Normal Seconds should be higher than Output)");
        $display("    Internal: %0d, Output: %0d", uut.normal_seconds, o_seconds);

        // --- Exit Split / Return to Normal ---
        $display("\n--- [4] Exit Split / Check Count Continuity ---");
        // Depending on logic, pressing mode again or specific conditions exit split.
        press_mode(); // Move modes_counter
        #20;
        
        // --- Stop Timer ---
        $display("\n--- [5] Stop Timer ---");
        press_inc(); // Toggle inc_counter to 0
        #30; // Verify values do not change

        // --- Clear Timer ---
        $display("\n--- [6] Clear Timer ---");
        // Logic requires specific mode and inc_counter=0 to clear
        // We might need to cycle mode to reach the clear state
        press_mode(); 
        #20;
        press_mode(); // Cycle through modes until clear_flag logic is met
        #20;

        // Finish Simulation
        $display("\n--- Simulation Finished ---");
        $finish;
    end

endmodule