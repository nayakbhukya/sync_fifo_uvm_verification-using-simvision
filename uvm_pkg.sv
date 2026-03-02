package fifo_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // 1️⃣ Transaction
  `include "sequence_item.sv"

  // 2️⃣ Sequencer
  `include "sequencer.sv"

  // 3️⃣ ALL Sequences (THIS FILE)
  `include "sequence.sv"

  // 4️⃣ Driver
  `include "driver.sv"

  // 5️⃣ Monitor
  `include "monitor.sv"

  // 6️⃣ Agent
  `include "agent.sv"

  // 7️⃣ Scoreboard
  `include "scoreboard.sv"

  // 8️⃣ Environment
  `include "env.sv"

  // 9️⃣ Tests (ALWAYS LAST)
  `include "test.sv"
  `include "wr_test.sv"
  `include "wr_rd_test.sv"
  `include "wr_then_rd_test.sv"
  `include "fifo_wr_rd_parallel_test.sv"

endpackage