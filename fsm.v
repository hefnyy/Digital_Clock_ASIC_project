module fsm (
    // Input Declaration
    input wire mode_button,
    input wire [1:0] set_time_hours_left,
    input wire [3:0] set_time_hours_right,
    input wire [2:0] set_time_minutes_left,
    input wire [3:0] set_time_minutes_right,
    input wire [4:0] normal_hours,
    input wire [5:0] normal_minutes,
    input wire set_time_ack_flag,
    input wire [5:0] stop_watch_minutes,
    input wire [5:0] stop_watch_seconds,
    input wire stop_watch_ack_flag,
    input wire set_time_active,
    input wire [1:0] set_alarm_hours_left,
    input wire [3:0] set_alarm_hours_right,
    input wire [2:0] set_alarm_minutes_left,
    input wire [3:0] set_alarm_minutes_right,
    input wire set_alarm_ack_flag,
    input wire on_off_alarm,
    input wire clk,
    input wire rst,
    // Output Declaration
    output reg set_time_en,
    output reg set_alarm_en,
    output reg stop_watch_en,
    output reg normal_en,
    output reg alarm_sound,
    output reg [5:0] hours_fsm,
    output reg [5:0] minutes_fsm
);

// FSM Encoding
localparam normal = 2'b00,
           alarm_mode = 2'b01,
           stop_watch = 2'b11,
           set_time = 2'b10;

reg [1:0] current_state, next_state;
reg alarm_status;

// internal wires for alarm
wire [4:0] set_alarm_hours_total;
wire [5:0] set_alarm_minutes_total;



// transition logic
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        current_state <= normal;
        alarm_status <= 'b0;
    end else begin
        current_state <= next_state;
    end
end

// next state logic
always @(*) begin
    case (current_state)
        normal: begin
            if(mode_button) begin
                next_state = alarm_mode;
            end else begin
                next_state = current_state;
            end
        end

        alarm_mode: begin
            if(mode_button & set_alarm_ack_flag) begin
                next_state = stop_watch;
            end else begin
                next_state = current_state;
            end
        end

        stop_watch: begin
            if (mode_button & stop_watch_ack_flag) begin
                next_state = set_time;
            end else begin
                next_state = current_state;
            end
        end

        set_time: begin
            if(mode_button & set_time_ack_flag) begin
                next_state = normal;
            end else begin
                next_state = current_state;
            end
        end

        default: next_state = current_state;
    endcase
end

// output logic
always @(*) begin
    set_time_en = 1'b0;
    set_alarm_en = 1'b0;
    stop_watch_en = 1'b0;
    normal_en = 1'b0;
    hours_fsm = 'b0;
    minutes_fsm = 'b0;
    case (current_state)
        normal: begin
            hours_fsm = normal_hours;
            minutes_fsm = normal_minutes;
            if(alarm_status & (normal_minutes == set_alarm_minutes_total) & (normal_hours == set_alarm_hours_total)) begin
                alarm_sound = 1'b1;
                alarm_status = 1'b0;
            end else begin
                alarm_sound = 1'b0;
            end
        end

        alarm_mode: begin
            hours_fsm = set_alarm_hours_left*10 + set_alarm_hours_right;
            minutes_fsm = set_alarm_minutes_left*10 + set_alarm_minutes_right;
            set_alarm_en = 1'b1;
            if (on_off_alarm) begin
                alarm_status = 1'b1;
            end else begin
                alarm_status = 'b0;
            end
        end

        stop_watch: begin
            hours_fsm = stop_watch_minutes;
            minutes_fsm = stop_watch_seconds;
            stop_watch_en = 1'b1;
        end

        set_time: begin
            hours_fsm = set_time_hours_left*10 + set_time_hours_right;
            minutes_fsm = set_time_minutes_left*10 + set_time_minutes_right;
            set_time_en = 1'b1;
            if(set_time_ack_flag && set_time_active) begin
                normal_en = 1'b1;
            end
        end
    endcase
end

assign set_alarm_hours_total = set_alarm_hours_left*10 + set_alarm_hours_right;
assign set_alarm_minutes_total = set_alarm_minutes_left*10 + set_alarm_minutes_right;

endmodule