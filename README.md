#   Synchronous FIFO Design & Verification using SystemVerilog and UVM
## Project Overview

This project implements and verifies a parameterized Synchronous FIFO (First-In-First-Out) using:

SystemVerilog RTL

SystemVerilog Assertions (SVA)

UVM (Universal Verification Methodology)

Functional Coverage

Self-checking Scoreboard

Coverage & Assertion Reporting (Xcelium)

The goal of this project is to demonstrate complete RTL-to-Verification flow, including constrained random testing and coverage-driven verification.

# command to invoke the " cadence xcelium "
To start Cadence Xcelium, first make sure the tool environment is properly loaded on your system. In most lab setups, you need to source the Cadence installation path so that the xrun command becomes available. You can check whether it is accessible by typing which xrun in the terminal. If a valid installation path appears, Xcelium is ready to use. or create the new folder and make it as root directory as triminal to be open in that folder and type Xrun -to your project directory (for example, where your filelist.f and SystemVerilog files are located). To compile and run a UVM-based simulation, use a command like xrun -uvm -f filelist.f, which will compile, elaborate, and execute the design. If you want to debug using the graphical interface, add the -gui option (xrun -uvm -f filelist.f -gui) to open SimVision for waveform viewing. Before re-running simulations, it is good practice to delete previous simulation folders such as xcelium.d to avoid stale data. This is the standard way to start and run simulations in Xcelium for RTL or UVM verification projects. unlike vivado we don't requied to select fpga board for simulation. As it is based on cpu simulator.

#  Design Description
1️⃣ FIFO Type

Synchronous FIFO

Single clock

Single reset

Parameterized depth and data width

parameter DATA_WIDTH = 8;
parameter DEPTH      = 16;
2️⃣ Architecture

The FIFO consists of:

Memory array of dff

Write pointer

Read pointer

Full logic

Empty logic

🔹 Memory
logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
🔹 Pointers

Extended by 1 bit for full detection

Circular increment logic

🔹 Full Condition
(wr_ptr[MSB] != rd_ptr[MSB]) &&
(wr_ptr[LSB] == rd_ptr[LSB])
🔹 Empty Condition
wr_ptr == rd_ptr
🔍 Assertions (SVA)

Embedded SystemVerilog Assertions ensure correctness at RTL level:

✔ No read when empty
✔ No write when full
✔ Correct full flag logic
✔ Correct empty flag logic
✔ No unknow (X) on pointers

Assertions are wrapped using:

`ifndef SYNTHESIS

So they are:

Active during simulation

Ignored during synthesis

🧪 UVM Verification Architecture

The testbench follows standard UVM layered architecture:

```text
uvm_test
└── environment
    ├── agent
    │   ├── driver
    │   ├── monitor
    │   └── sequencer
    └── scoreboard
```
## Interface

Contains:

Clocking blocks

Modports (Driver & Monitor separation)

Ensures clean timing between DUT and testbench.

## Sequence Item (Transaction)

Defines:

wr

rd

data_in

data_out

empty

full

Supports constrained random generation.

##  Sequences

Implemented multiple test scenarios:

Sequence	Purpose
fifo_write_sequence	Write only
fifo_read_sequence	Read only
fifo_wr_then_rd_sequence	Write then Read
fifo_write_read_sequence	Alternating
fifo_wr_rd_parallel_seq	Simultaneous wr/rd
fifo_sequence	Random mixed traffic
## Driver

Drives wr, rd, data_in

Uses clocking block

Controlled via sequencer

## Monitor

Samples DUT outputs

Captures transactions

Sends to scoreboard

Collects functional coverage

## Scoreboard (Self-checking)

Implements reference model using queue:

bit [7:0] ref_fifo[$];

Features:

Push on write

Pop on read

1-cycle delayed comparison

PASS/FAIL reporting

Handles underflow detection

Fully automated verification.

## Functional Coverage

Covergroup tracks:

Write operations

Read operations

Empty condition

Full condition

Cross coverage:

wr × rd

wr × full

rd × empty

Ensures stimulus quality.

## Test Control

Tests selected using:

+UVM_TESTNAME=<test_name>

Example:

xrun -f filelist.f -sv -uvm +UVM_TESTNAME=fifo_wr_rd_test
📈 Coverage Enabled

Simulation includes:

Block coverage

Expression coverage

Toggle coverage

FSM coverage

Functional coverage

Coverage stored in:

cov_work/
## Simulation Tool

Tested using:

Cadence Xcelium 22.09

UVM 1.1d

IEEE 1800-2009 SV semantics

## Synthesis Compatibility

Assertions disabled during synthesis

Clean synthesizable RTL

Suitable for Genus flow

## Key Learning Outcomes

✔ FIFO pointer arithmetic
✔ Full/Empty logic implementation
✔ SystemVerilog Assertions
✔ UVM architecture
✔ Constrained random testing
✔ Scoreboard modeling
✔ Functional coverage
✔ Debugging timing mismatches
✔ Assertion failure debugging
✔ Factory registration & test selection

## Project Highlights

Fully self-checking

Assertion-driven verification

Parameterized design

Multiple test scenarios

Clean UVM architecture

Industry-style verification flow

## Future Improvements

Add Almost Full / Almost Empty

Add overflow/underflow detection

Add error injection tests

Add formal verification

Add AXI-stream wrapper

Add asynchronous FIFO version

## Why This Project is Strong

This project demonstrates:

RTL design skills

Verification skills

UVM knowledge

Assertion-based verification

Coverage-driven testing

Debugging capability

This is not a basic FIFO —
This is industry-style verification implementation.
