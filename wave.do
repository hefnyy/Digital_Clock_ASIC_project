onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color White /top_module_tb/mode_button_tb
add wave -noupdate -color White /top_module_tb/inc_button_tb
add wave -noupdate /top_module_tb/clk_tb
add wave -noupdate /top_module_tb/rst_tb
add wave -noupdate /top_module_tb/alarm_sound_tb
add wave -noupdate -color Yellow -radix unsigned /top_module_tb/hours_fsm_tb
add wave -noupdate -color Yellow -radix unsigned /top_module_tb/minutes_fsm_tb
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/mode_button
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_time_hours_left
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_time_hours_right
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_time_minutes_left
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_time_minutes_right
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/normal_hours
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/normal_minutes
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_time_ack_flag
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/stop_watch_minutes
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/stop_watch_seconds
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/stop_watch_ack_flag
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_alarm_hours_left
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_alarm_hours_right
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_alarm_minutes_left
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_alarm_minutes_right
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_alarm_ack_flag
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/on_off_alarm
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/clk
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/rst
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_time_en
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_alarm_en
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/stop_watch_en
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/normal_en
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/alarm_sound
add wave -noupdate -expand -group FSM -radix unsigned /top_module_tb/top_module_inst/fsm_inst/hours_fsm
add wave -noupdate -expand -group FSM -radix unsigned /top_module_tb/top_module_inst/fsm_inst/minutes_fsm
add wave -noupdate -expand -group FSM -color Blue /top_module_tb/top_module_inst/fsm_inst/current_state
add wave -noupdate -expand -group FSM -color Magenta /top_module_tb/top_module_inst/fsm_inst/next_state
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_alarm_hours_total
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_alarm_minutes_total
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/set_time_active
add wave -noupdate -expand -group FSM /top_module_tb/top_module_inst/fsm_inst/alarm_status
add wave -noupdate -group NORMAL /top_module_tb/top_module_inst/normal_inst/normal_en
add wave -noupdate -group NORMAL /top_module_tb/top_module_inst/normal_inst/i_hours_left
add wave -noupdate -group NORMAL /top_module_tb/top_module_inst/normal_inst/i_hours_right
add wave -noupdate -group NORMAL /top_module_tb/top_module_inst/normal_inst/i_minutes_left
add wave -noupdate -group NORMAL /top_module_tb/top_module_inst/normal_inst/i_minutes_right
add wave -noupdate -group NORMAL -radix unsigned /top_module_tb/top_module_inst/normal_inst/o_hours
add wave -noupdate -group NORMAL -radix unsigned /top_module_tb/top_module_inst/normal_inst/o_minutes
add wave -noupdate -group NORMAL -radix unsigned /top_module_tb/top_module_inst/normal_inst/seconds
add wave -noupdate -group SET_TIME /top_module_tb/top_module_inst/set_time_inst/set_time_en
add wave -noupdate -group SET_TIME /top_module_tb/top_module_inst/set_time_inst/mode_button
add wave -noupdate -group SET_TIME /top_module_tb/top_module_inst/set_time_inst/inc_button
add wave -noupdate -group SET_TIME -radix unsigned /top_module_tb/top_module_inst/set_time_inst/o_hours_left
add wave -noupdate -group SET_TIME -radix unsigned /top_module_tb/top_module_inst/set_time_inst/o_hours_right
add wave -noupdate -group SET_TIME -radix unsigned /top_module_tb/top_module_inst/set_time_inst/o_minutes_left
add wave -noupdate -group SET_TIME -radix unsigned /top_module_tb/top_module_inst/set_time_inst/o_minutes_right
add wave -noupdate -group SET_TIME /top_module_tb/top_module_inst/set_time_inst/ack_flag
add wave -noupdate -group SET_TIME /top_module_tb/top_module_inst/set_time_inst/set_time_active
add wave -noupdate -group SET_TIME -radix unsigned /top_module_tb/top_module_inst/set_time_inst/modes
add wave -noupdate -group SET_ALARM /top_module_tb/top_module_inst/set_alarm_inst/set_alarm_en
add wave -noupdate -group SET_ALARM /top_module_tb/top_module_inst/set_alarm_inst/mode_button
add wave -noupdate -group SET_ALARM /top_module_tb/top_module_inst/set_alarm_inst/inc_button
add wave -noupdate -group SET_ALARM -radix unsigned /top_module_tb/top_module_inst/set_alarm_inst/o_hours_left
add wave -noupdate -group SET_ALARM -radix unsigned /top_module_tb/top_module_inst/set_alarm_inst/o_hours_right
add wave -noupdate -group SET_ALARM -radix unsigned /top_module_tb/top_module_inst/set_alarm_inst/o_minutes_left
add wave -noupdate -group SET_ALARM -radix unsigned /top_module_tb/top_module_inst/set_alarm_inst/o_minutes_right
add wave -noupdate -group SET_ALARM /top_module_tb/top_module_inst/set_alarm_inst/ack_flag
add wave -noupdate -group SET_ALARM /top_module_tb/top_module_inst/set_alarm_inst/on_off_alarm
add wave -noupdate -group SET_ALARM /top_module_tb/top_module_inst/set_alarm_inst/modes
add wave -noupdate -group STOP_WATCH /top_module_tb/top_module_inst/stop_watch_inst/mode_button
add wave -noupdate -group STOP_WATCH /top_module_tb/top_module_inst/stop_watch_inst/inc_button
add wave -noupdate -group STOP_WATCH /top_module_tb/top_module_inst/stop_watch_inst/stop_watch_en
add wave -noupdate -group STOP_WATCH /top_module_tb/top_module_inst/stop_watch_inst/stop_watch_ack_flag
add wave -noupdate -group STOP_WATCH -radix unsigned /top_module_tb/top_module_inst/stop_watch_inst/o_minutes
add wave -noupdate -group STOP_WATCH -radix unsigned /top_module_tb/top_module_inst/stop_watch_inst/o_seconds
add wave -noupdate -group STOP_WATCH -radix unsigned /top_module_tb/top_module_inst/stop_watch_inst/normal_minutes
add wave -noupdate -group STOP_WATCH -radix unsigned /top_module_tb/top_module_inst/stop_watch_inst/normal_seconds
add wave -noupdate -group STOP_WATCH -radix unsigned /top_module_tb/top_module_inst/stop_watch_inst/split_min
add wave -noupdate -group STOP_WATCH -radix unsigned /top_module_tb/top_module_inst/stop_watch_inst/split_sec
add wave -noupdate -group STOP_WATCH -radix unsigned /top_module_tb/top_module_inst/stop_watch_inst/modes_counter
add wave -noupdate -group STOP_WATCH /top_module_tb/top_module_inst/stop_watch_inst/inc_counter
add wave -noupdate -group STOP_WATCH /top_module_tb/top_module_inst/stop_watch_inst/split_flag
add wave -noupdate -group STOP_WATCH /top_module_tb/top_module_inst/stop_watch_inst/clear_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5541490 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
configure wave -valuecolwidth 55
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {5402825 ps} {6389325 ps}
