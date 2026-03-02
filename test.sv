
class fifo_test extends uvm_test;
	`uvm_component_utils (fifo_test)
	fifo_environment env;
	fifo_sequence fifo_seq;


	//constructor


	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	//build phase

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		env=fifo_environment::type_id::create ("env", this);
	endfunction

	//end of elaboration phase

	virtual function void end_of_elaboration();

		//prints the topology

		print();

	endfunction


	//run phase


	task run_phase(uvm_phase phase);
		
		fifo_seq = fifo_sequence:: type_id::create("fifo_seq");

		phase.raise_objection(this);
		fifo_seq.start(env.agt.seqr);
		phase.drop_objection(this);
	endtask
endclass
