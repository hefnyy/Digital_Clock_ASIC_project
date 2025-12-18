module stop_watch (
    // Inputs Declaration
    input wire mode_button,
    input wire inc_button,
    input wire clk,
    input wire rst,
    input wire stop_watch_en,
    // Outputs Declaration
    output wire stop_watch_ack_flag,
    output reg [5:0] o_minutes,
    output reg [5:0] o_seconds
);

reg [5:0] normal_minutes;
reg [5:0] normal_seconds;
reg [5:0] split_min;     // register for freeze minutes after split
reg [5:0] split_sec;     // register for freeze seconds after split

reg [2:0] modes_counter;    // For Split
reg inc_counter;    // if equals 0 -> stop / equals 1 -> start
reg split_flag;
wire clear_flag;

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        o_minutes <= 'b0;
        o_seconds <= 'b0;
        modes_counter <= 'b0;
        inc_counter <= 'b0;
        split_min <= 'b0;
        split_sec <= 'b0;
        normal_minutes <= 'b0;
        normal_seconds <= 'b0;
        split_flag <= 'b0;
    end else if(stop_watch_en) begin
        if (mode_button) begin
            modes_counter <= modes_counter + 1'b1;
        end
        if(modes_counter != 3'd1) begin     // Set split_flag if modes_counter == 1 to make split freeze for minutes and seconds
            split_flag <= 1'b1;
        end
        if (inc_button) begin       
            inc_counter <= ~inc_counter;
        end
        if(inc_counter) begin   // Normal
            normal_seconds <= normal_seconds + 1'b1;
            if(normal_seconds == 6'd59) begin    // Maximum value of seconds handling
                normal_seconds <= 6'b0;
                normal_minutes <= normal_minutes + 1'b1;
                if (normal_minutes == 6'd59) begin  // Maximum value of minutes handling
                    normal_minutes <= 6'b0;
                end
            end
        end
        if (clear_flag) begin       // if clear flag is 1 -> reset
            normal_seconds <= 6'b0;
            normal_minutes <= 6'b0;
        end
        if (modes_counter == 3'd1 & split_flag) begin       // Split is ON
            split_flag <= 1'b0;
            split_min <= normal_minutes;
            split_sec <= normal_seconds;
        end 
    end else begin
        modes_counter <= 'b0;
    end
end

always @(*) begin
    if(~split_flag) begin
        o_minutes = split_min;
        o_seconds = split_sec;
    end else begin
        o_minutes = normal_minutes;
        o_seconds = normal_seconds;
    end
end

assign stop_watch_ack_flag = (clear_flag == 1'b1 & modes_counter == 3'b10) ? 1'b1: (modes_counter == 3'b11) ? 1'b1 : 1'b0;
assign clear_flag = ((modes_counter == 3'b1 | modes_counter == 3'b11) & inc_counter == 1'b0);

endmodule