# Digital_Clock_ASIC_project
# Project 1: FSM Front-End Design

## Project Overview
This project involves the front-end design of a Finite State Machine (FSM) for a **hh:mm 4-digit 24h-format watch controller**. The design includes the FSM diagram, Verilog RTL implementation, and a comprehensive testbench.

## Team Information
* **Structure:** Work as teams of 3 students.
* **Group ID:** Gxx (Replace `xx` with your assigned 2-digit group number).

## Functional Requirements
The FSM controller operates in **4 modes**, cycled through using the **Mode** button:
1. **Normal Mode**: Displays the current time (hh:mm) and checks for alarm conditions. If the alarm is active and the current time matches the alarm time, the alarm will sound.
2. **Alarm Mode**: Allows setting the alarm time. The alarm can be toggled on or off.
3. **Stop-Watch Mode**: Displays stopwatch minutes and seconds. Supports start, stop, and split time functionality.
4. **Set Time Mode**: Allows setting the current time. Time is set digit by digit from left to right.

### Inputs
The system uses only 2 push-buttons:
* **Mode Button**: Cycles through the 4 modes and selects digits in Set Time and Alarm modes.
* **Set Button**: Increments the selected digit in Set Time and Alarm modes.

### Outputs
* **Alarm Sound**: Activates when the alarm conditions are met in Normal Mode.
* **Time Display**: Shows hours and minutes in Normal and Set Time modes, and minutes and seconds in Stop-Watch mode.

### FSM State Transitions
The FSM transitions between states based on the `mode_button` and acknowledgment flags:
* **Normal → Alarm Mode**: Triggered by `mode_button`.
* **Alarm → Stop-Watch Mode**: Triggered by `mode_button` and `set_alarm_ack_flag`.
* **Stop-Watch → Set Time Mode**: Triggered by `mode_button` and `stop_watch_ack_flag`.
* **Set Time → Normal Mode**: Triggered by `mode_button` and `set_time_ack_flag`.
* **Digit Selection**: In Set Time and Alarm modes, pressing `mode_button` selects the next digit to set. After the last digit, it goes to the Next Mode.
* **Digit Increment**: In Set Time and Alarm modes, pressing `set_button` increments the selected digit.
### State Diagram
![FSM State Diagram](fsm_state_diagram.png) 