module normal (
    // inputs Declaration
    input wire clk,
    input wire rst,
    input wire normal_en,
    input wire [1:0] i_hours_left,
    input wire [3:0] i_hours_right,
    input wire [2:0] i_minutes_left,
    input wire [3:0] i_minutes_right,
    // outputs Declaration
    output reg [4:0] o_hours,
    output reg [5:0] o_minutes
);
reg [5:0] seconds; 

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        o_hours <= 0;
        o_minutes <= 0;
        seconds <= 0;
    end else if (normal_en) begin   // If time set take the time and assign in the normal
        o_hours <= i_hours_left * 10 + i_hours_right;
        o_minutes <= i_minutes_left * 10 + i_minutes_right;
    end else begin
            // normal clock behavior
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