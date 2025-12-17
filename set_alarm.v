module set_alarm (
    input clk, rst, set_alarm_en,
    input mode_button, inc_button,
    output reg [1:0] o_hours_left,
    output reg [3:0] o_hours_right,
    output reg [2:0] o_minutes_left,
    output reg [3:0] o_minutes_right,
    output ack_flag, 
    output reg on_off_alarm
);
    reg [2:0] modes;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            o_hours_left <= 0;
            o_hours_right <= 0;
            o_minutes_left <= 0;
            o_minutes_right <= 0;
            modes <= 0;
            on_off_alarm <= 0;
        end else if(set_alarm_en) begin            
                if (modes == 0) begin                       // Modify on (h)h:mm
                    if (mode_button) begin  
                        modes <= modes + 1; 
                    end else if (inc_button == 1) begin     
                        o_hours_left <= o_hours_left + 1;
                        if (o_hours_left == 2) begin
                            o_hours_left <= 0;
                        end
                    end
                end else if (modes == 1) begin              // Modify h(h):mm
                    if (mode_button) begin 
                        modes <= modes + 1; 
                    end else if (inc_button == 1) begin     
                        if (o_hours_left == 2) begin
                            if (o_hours_right == 3) begin
                                o_hours_right <= 0;
                            end else begin
                                o_hours_right <= o_hours_right + 1;
                            end
                        end else begin
                            o_hours_right <= o_hours_right + 1;
                            if (o_hours_right == 9) begin
                                o_hours_right <= 0;
                            end
                        end
                    end
                end else if (modes == 2) begin              // Modify h(h):(m)m
                    if (mode_button) begin
                        modes <= modes + 1;
                    end else if (inc_button == 1) begin
                        o_minutes_left <= o_minutes_left + 1;
                        if (o_hours_left == 5) begin
                            o_minutes_left <= 0;
                        end
                    end
                end else if (modes == 3) begin             // Modify on (h)h:m(m)
                    if (mode_button) begin
                        modes <= modes + 1;
                    end else if (inc_button == 1) begin
                        o_minutes_right <= o_minutes_right + 1;
                        if (o_hours_right == 9) begin
                            o_minutes_right <= 0;
                        end
                    end
                end else if (modes == 4) begin             // Set Alarm On or Off
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
        end
    end

    assign ack_flag = (modes == 5);


endmodule