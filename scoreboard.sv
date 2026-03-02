class fifo_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(fifo_scoreboard)

  uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) analysis_export;

  fifo_seq_item que[$];

  bit [7:0] ref_fifo[$];     // reference model
  bit [7:0] exp_queue[$];    // delayed expected outputs

  fifo_seq_item trans;
  bit [7:0] exp_data;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    analysis_export = new("analysis_export", this);
  endfunction

  // Monitor pushes transactions here
  function void write(fifo_seq_item transaction);
    que.push_back(transaction);
  endfunction

 virtual task run_phase(uvm_phase phase);

  bit read_pending = 0;
  bit [7:0] expected_data;

  forever begin

    wait (que.size() > 0);
    trans = que.pop_front();

    // ---------------------------------
    // 1️⃣ Compare previous cycle read
    // ---------------------------------
    if (read_pending) begin
      if (trans.data_out == expected_data) begin
        `uvm_info("SCOREBOARD",
          $sformatf("PASS :: Expected=%0d Received=%0d",
            expected_data, trans.data_out),
          UVM_MEDIUM)
      end
      else begin
        `uvm_error("SCOREBOARD",
          $sformatf("FAIL :: Expected=%0d Received=%0d",
            expected_data, trans.data_out))
      end
      read_pending = 0;
    end

    // ---------------------------------
    // 2️⃣ READ MODEL (generate expected for next cycle)
    // ---------------------------------
    if (trans.rd && !trans.empty) begin
      if (ref_fifo.size() > 0) begin
        expected_data = ref_fifo.pop_front();
        read_pending = 1;
      end
      else begin
        `uvm_error("SCOREBOARD", "Read when reference FIFO empty")
      end
    end

    // ---------------------------------
    // 3️⃣ WRITE MODEL
    // ---------------------------------
    if (trans.wr && !trans.full) begin
      ref_fifo.push_back(trans.data_in);
    end

  end

endtask

endclass