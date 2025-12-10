module normal (
    input clk,rst,set_time_flag,
    input [4:0] i_hours,
    input [5:0] i_minutes,
    output reg [4:0] o_hours,
    output reg [5:0] o_minutes
);
    reg [5:0] seconds; 

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            o_hours <= 0;
            o_minutes <= 0;
            seconds <= 0;
        end else if (set_time_flag) begin
            o_hours <= i_hours;
            o_minutes <= i_minutes;
        end else begin
                seconds <= seconds + 1;
                if (seconds == 59) begin
                    seconds <= 0;
                    o_minutes <= o_minutes + 1;
                    if (o_minutes == 59) begin
                        o_minutes <= 0;
                        o_hours <= o_hours + 1;
                        if (o_hours == 23) begin
                            o_hours <= 0;
                        end
                    end
                end
            end
    end

    
endmodule