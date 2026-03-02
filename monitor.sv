`define MON_IF vif.MONITOR.monitor_cb

class fifo_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_monitor)

  virtual fifo_interface vif;
  fifo_seq_item trans;

  uvm_analysis_port #(fifo_seq_item) ap;

  // -------------------------
  // COVERAGE
  // -------------------------
  covergroup fifo_cg with function sample(
    bit wr,
    bit rd,
    bit empty,
    bit full
  );

    option.per_instance = 1;

    wr_cp    : coverpoint wr;
    rd_cp    : coverpoint rd;
    empty_cp : coverpoint empty;
    full_cp  : coverpoint full;

    wr_rd_cross    : cross wr_cp, rd_cp;
    wr_full_cross  : cross wr_cp, full_cp;
    rd_empty_cross : cross rd_cp, empty_cp;

  endgroup


  function new(string name, uvm_component parent);
    super.new(name,parent);
    ap = new("ap",this);
    fifo_cg = new();
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual fifo_interface)::get(this,"","vif",vif))
      `uvm_fatal("MON","No virtual interface specified")
  endfunction


  virtual task run_phase(uvm_phase phase);
    forever begin

      @(vif.monitor_cb);   

      trans = fifo_seq_item::type_id::create("trans", this);

      trans.wr       = `MON_IF.wr;
      trans.rd       = `MON_IF.rd;
      trans.data_in  = `MON_IF.data_in;
      trans.data_out = `MON_IF.data_out;
      trans.empty    = `MON_IF.empty;
      trans.full     = `MON_IF.full;

      ap.write(trans);

      fifo_cg.sample(
        trans.wr,
        trans.rd,
        trans.empty,
        trans.full
      );

      `uvm_info("MON_DEBUG",
        $sformatf("WR=%0d RD=%0d DIN=%0d DOUT=%0d EMPTY=%0d FULL=%0d",
          trans.wr,
          trans.rd,
          trans.data_in,
          trans.data_out,
          trans.empty,
          trans.full),
        UVM_LOW)

    end
  endtask

endclass