
class fifo_agent extends uvm_agent;

	 `uvm_component_utils( fifo_agent)


	 fifo_sequencer seqr;
	 fifo_driver driv;
	 fifo_monitor mon;


	 function new (string name, uvm_component parent);
		 super.new(name, parent);
	 endfunction


	 virtual function void build_phase(uvm_phase phase);
		 super.build_phase(phase);


		 seqr = fifo_sequencer:: type_id :: create("seqr", this);
		 driv = fifo_driver:: type_id :: create("driv", this);
		 mon =fifo_monitor:: type_id :: create("mon", this);
	 endfunction


	 virtual function void connect_phase(uvm_phase phase);
		 super.connect_phase(phase);

		 driv.seq_item_port.connect(seqr.seq_item_export);

	 endfunction
 endclass
