# Digital_Clock_ASIC_project
# Project 1: FSM Front-End Design

## Project Overview
This project involves the front-end design of a Finite State Machine (FSM) for a **hh:mm 4-digit 24h-format watch controller**[cite: 1, 4]. [cite_start]The design includes the FSM diagram, Verilog RTL implementation, and a comprehensive testbench[cite: 4, 12, 14].

## Team Information
* **Structure:** Work as teams of 3 students[cite: 3].
* **Group ID:** Gxx (Replace `xx` with your assigned 2-digit group number).

## Functional Requirements
[cite_start]The FSM controller operates in **4 modes**, cycled through using the **Mode** button[cite: 4, 9]:
1.  [cite_start]**Normal:** Displays time (hh:mm)[cite: 5].
2.  [cite_start]**Set Time:** Set 1 digit at a time from left to right[cite: 6].
3.  [cite_start]**Set Alarm:** Set 1 digit at a time from left to right[cite: 7].
4.  [cite_start]**Stop-Watch:** Perform start-stop and split time (measured as mm:ss)[cite: 8].

### Inputs
[cite_start]The system uses only 2 push-buttons[cite: 9]:
* [cite_start]**Mode:** Press to go sequentially through the 4 modes and through digits[cite: 9].
* [cite_start]**Set:** Press to increment the digits[cite: 10].

[cite_start]*Note: All needed peripherals and interfaces are assumed[cite: 11].*

## Directory Structure
[cite_start]The project must be submitted as a single zip file `<Gxx_project1>.zip` containing a top-level directory named `<Gxx>` with the following structure[cite: 17]:

```text
Gxx/
├── Gxx_project1.pdf       # Report containing Cover, Intro, FSM Design, RTL Design, TB Design, Simulation [cite: 18-24]
└── files/                 # Directory containing all source and output files [cite: 25]
