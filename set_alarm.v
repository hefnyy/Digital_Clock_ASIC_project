module set_alarm (
    input clk, rst, set_alarm_en,
    input mode_button, inc_button,
    output reg [4:0] o_hours,
    output reg [5:0] o_minutes,
    output ack_flag, 
    output reg on_off_alarm
);
    reg [1:0] modes;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            o_hours <= 0;
            o_minutes <= 0;
            modes <= 0;
            on_off_alarm <= 0;
        end else if(set_alarm_en) begin           
                if (modes == 0) begin
                    if (mode_button) begin
                        modes <= modes + 1;
                    end else if (inc_button == 1) begin
                        o_hours <= o_hours + 1;
                    end
                end else if (modes == 1) begin
                    if (mode_button) begin
                        modes <= modes + 1;
                    end else if (inc_button == 1) begin
                        o_minutes <= o_minutes + 1;
                    end
                end else if (modes == 2) begin
                    if (mode_button) begin
                        modes <= modes + 1;
                    end else if (inc_button) begin
                        on_off_alarm <= 1;
                    end else begin
                        on_off_alarm <= 0;
                    end
                end else begin
                    modes <= 0;
                end
        end else begin
            modes <= 'b0;
        end
    end

    assign ack_flag = (modes == 3);


endmodule