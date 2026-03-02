
class fifo_wr_rd_parallel_test extends fifo_test;

	`uvm_component_utils(fifo_wr_rd_parallel_test)

	fifo_wr_rd_parallel_seq seq;

	function new(string name = "fifo_wr_rd_parallel_test",
	             uvm_component parent = null);
		super.new(name, parent);
	endfunction : new


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		seq = fifo_wr_rd_parallel_seq::type_id::create("seq");
	endfunction : build_phase


	virtual task run_phase(uvm_phase phase);

		super.run_phase(phase);

		phase.raise_objection(this);

		// Start parallel read-write sequence
		seq.start(env.agt.seqr);

		// Give scoreboard time to finish
		phase.phase_done.set_drain_time(this, 500);

		phase.drop_objection(this);

	endtask : run_phase

endclass : fifo_wr_rd_parallel_test