🔷 Synchronous FIFO Design & Verification using SystemVerilog and UVM
📌 Project Overview

This project implements and verifies a parameterized Synchronous FIFO (First-In-First-Out) using:

SystemVerilog RTL

SystemVerilog Assertions (SVA)

UVM (Universal Verification Methodology)

Functional Coverage

Self-checking Scoreboard

Coverage & Assertion Reporting (Xcelium)

The goal of this project is to demonstrate complete RTL-to-Verification flow, including constrained random testing and coverage-driven verification.

🧠 Design Description
1️⃣ FIFO Type

Synchronous FIFO

Single clock

Single reset

Parameterized depth and data width

parameter DATA_WIDTH = 8;
parameter DEPTH      = 16;
2️⃣ Architecture

The FIFO consists of:

Memory array

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
✔ No X on pointers

Assertions are wrapped using:

`ifndef SYNTHESIS

So they are:

Active during simulation

Ignored during synthesis

🧪 UVM Verification Architecture

The testbench follows standard UVM layered architecture:

uvm_test
  └── environment
        ├── agent
        │     ├── driver
        │     ├── monitor
        │     └── sequencer
        └── scoreboard
🧩 UVM Components
1️⃣ Interface

Contains:

Clocking blocks

Modports (Driver & Monitor separation)

Ensures clean timing between DUT and testbench.

2️⃣ Sequence Item (Transaction)

Defines:

wr

rd

data_in

data_out

empty

full

Supports constrained random generation.

3️⃣ Sequences

Implemented multiple test scenarios:

Sequence	Purpose
fifo_write_sequence	Write only
fifo_read_sequence	Read only
fifo_wr_then_rd_sequence	Write then Read
fifo_write_read_sequence	Alternating
fifo_wr_rd_parallel_seq	Simultaneous wr/rd
fifo_sequence	Random mixed traffic
4️⃣ Driver

Drives wr, rd, data_in

Uses clocking block

Controlled via sequencer

5️⃣ Monitor

Samples DUT outputs

Captures transactions

Sends to scoreboard

Collects functional coverage

6️⃣ Scoreboard (Self-checking)

Implements reference model using queue:

bit [7:0] ref_fifo[$];

Features:

Push on write

Pop on read

1-cycle delayed comparison

PASS/FAIL reporting

Handles underflow detection

Fully automated verification.

📊 Functional Coverage

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

🔁 Test Control

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
🏁 Simulation Tool

Tested using:

Cadence Xcelium 22.09

UVM 1.1d

IEEE 1800-2009 SV semantics

🧱 Synthesis Compatibility

Assertions disabled during synthesis

Clean synthesizable RTL

Suitable for Genus flow

🚀 Key Learning Outcomes

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

🎯 Project Highlights

Fully self-checking

Assertion-driven verification

Parameterized design

Multiple test scenarios

Clean UVM architecture

Industry-style verification flow

🔥 Future Improvements

Add Almost Full / Almost Empty

Add overflow/underflow detection

Add error injection tests

Add formal verification

Add AXI-stream wrapper

Add asynchronous FIFO version

🧠 Why This Project is Strong

This project demonstrates:

RTL design skills

Verification skills

UVM knowledge

Assertion-based verification

Coverage-driven testing

Debugging capability

This is not a basic FIFO —
This is industry-style verification implementation.
