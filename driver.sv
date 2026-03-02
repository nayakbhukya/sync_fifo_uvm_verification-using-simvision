
`define DRIV_IF vif.driver_cb

class fifo_driver extends uvm_driver #(fifo_seq_item);

  `uvm_component_utils(fifo_driver)

  virtual fifo_interface vif;
  fifo_seq_item trans;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_interface)::get(this,"","vif",vif))
      `uvm_fatal("NO_VIF","Virtual interface not set")
  endfunction

  task run_phase(uvm_phase phase);

    forever begin

      seq_item_port.get_next_item(trans);

      // Drive using clocking block
      @(`DRIV_IF);
      `DRIV_IF.wr  <= trans.wr;
      `DRIV_IF.rd  <= trans.rd;
      `DRIV_IF.data_in  <= trans.data_in;

      seq_item_port.item_done();

      `uvm_info("DRV_DEBUG",
        $sformatf("WR=%0d RD=%0d DATA_IN=%0d",
        trans.wr, trans.rd, trans.data_in),
        UVM_LOW)

    end
  endtask

  task drive_task(fifo_seq_item trans);

    @(posedge vif.clk);

    `DRIV_IF.wr      <= trans.wr;
    `DRIV_IF.rd      <= trans.rd;
    `DRIV_IF.data_in <= trans.data_in;

  endtask

endclass