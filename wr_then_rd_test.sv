
class fifo_wr_then_rd_test extends fifo_test;

	`uvm_component_utils(fifo_wr_then_rd_test)

	fifo_wr_then_rd_sequence seq;

	function new (string name = "fifo_wr_then_rd_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction :new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase (phase);

		seq= fifo_wr_then_rd_sequence:: type_id::create("seq");
	endfunction:build_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		seq.start(env.agt.seqr);
		phase.drop_objection(this);
		
		phase.phase_done.set_drain_time(this,500);

	endtask :run_phase
endclass: fifo_wr_then_rd_test
