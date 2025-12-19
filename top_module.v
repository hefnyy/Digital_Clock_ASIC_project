module top_module (
    input wire mode_button_top,
    input wire inc_button_top,
    input wire clk_top,
    input wire rst_top,
    output wire alarm_sound_top,
    output wire [5:0] hours_fsm_top,
    output wire [5:0] minutes_fsm_top
);

// Internal Signals
wire set_time_en_top;
wire set_time_ack_top;
wire set_time;
wire [1:0] set_time_hours_left_top;
wire [3:0] set_time_hours_right_top;
wire [2:0] set_time_minutes_left_top;
wire [3:0] set_time_minutes_right_top;

wire normal_en_top;
wire [4:0] normal_hours_top;
wire [5:0] normal_minutes_top;

wire set_alarm_en_top;
wire set_alarm_ack_flag_top;
wire on_off_alarm_top;
wire [1:0] set_alarm_hours_left_top;
wire [3:0] set_alarm_hours_right_top;
wire [2:0] set_alarm_minutes_left_top;
wire [3:0] set_alarm_minutes_right_top;

wire stop_watch_en_top;
wire stop_watch_ack_flag_top;
wire [5:0] stop_watch_minutes_top;
wire [5:0] stop_watch_seconds_top;

wire clock_div_output_top;
wire clock_div_enable_top;

// Modules Instanciation

fsm fsm_inst(
    .mode_button(mode_button_top),
    .inc_button(inc_button_top),
    .set_time_hours_left(set_time_hours_left_top),
    .set_time_hours_right(set_time_hours_right_top),
    .set_time_minutes_left(set_time_minutes_left_top),
    .set_time_minutes_right(set_time_minutes_right_top),
    .normal_hours(normal_hours_top),
    .normal_minutes(normal_minutes_top),
    .set_time_ack_flag(set_time_ack_top),
    .stop_watch_minutes(stop_watch_minutes_top),
    .stop_watch_seconds(stop_watch_seconds_top),
    .stop_watch_ack_flag(stop_watch_ack_flag_top),
    .set_alarm_hours_left(set_alarm_hours_left_top),
    .set_alarm_hours_right(set_alarm_hours_right_top),
    .set_alarm_minutes_left(set_alarm_minutes_left_top),
    .set_alarm_minutes_right(set_alarm_minutes_right_top),
    .set_alarm_ack_flag(set_alarm_ack_flag_top),
    .on_off_alarm(on_off_alarm_top),
    .clk(clk_top),
    .rst(rst_top),
    .set_time_en(set_time_en_top),
    .set_alarm_en(set_alarm_en_top),
    .stop_watch_en(stop_watch_en_top),
    .normal_en(normal_en_top),
    .alarm_sound(alarm_sound_top),
    .hours_fsm(hours_fsm_top),
    .minutes_fsm(minutes_fsm_top),
    .set_time_active(set_time_active)
);

normal normal_inst(
    .clk(clk_top),
    .rst(rst_top),
    .normal_en(normal_en_top),
    .i_hours_left(set_time_hours_left_top),
    .i_hours_right(set_time_hours_right_top),
    .i_minutes_left(set_time_minutes_left_top),
    .i_minutes_right(set_time_minutes_right_top),
    .o_hours(normal_hours_top),
    .o_minutes(normal_minutes_top)
);

set_time set_time_inst(
    .clk(clk_top),
    .rst(rst_top),
    .set_time_en(set_time_en_top),
    .mode_button(mode_button_top),
    .inc_button(inc_button_top),
    .o_hours_left(set_time_hours_left_top),
    .o_hours_right(set_time_hours_right_top),
    .o_minutes_left(set_time_minutes_left_top),
    .o_minutes_right(set_time_minutes_right_top),
    .ack_flag(set_time_ack_top),
    .set_time_active(set_time_active)
);

set_alarm set_alarm_inst(
    .clk(clk_top),
    .rst(rst_top),
    .set_alarm_en(set_alarm_en_top),
    .mode_button(mode_button_top),
    .inc_button(inc_button_top),
    .o_hours_left(set_alarm_hours_left_top),
    .o_hours_right(set_alarm_hours_right_top),
    .o_minutes_left(set_alarm_minutes_left_top),
    .o_minutes_right(set_alarm_minutes_right_top),
    .ack_flag(set_alarm_ack_flag_top),
    .on_off_alarm(on_off_alarm_top)
);

stop_watch stop_watch_inst(
    .clk(clk_top),
    .rst(rst_top),
    .stop_watch_en(stop_watch_en_top),
    .mode_button(mode_button_top),
    .inc_button(inc_button_top),
    .o_minutes(stop_watch_minutes_top),
    .o_seconds(stop_watch_seconds_top),
    .stop_watch_ack_flag(stop_watch_ack_flag_top)
);


endmodule