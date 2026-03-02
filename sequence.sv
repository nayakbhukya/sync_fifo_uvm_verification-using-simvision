
class fifo_sequence extends uvm_sequence #(fifo_seq_item);

	`uvm_object_utils(fifo_sequence)

	function new(string name ="fifo_sequence");
		super.new(name);
	endfunction

	virtual task body();
		repeat(15) begin
			fifo_seq_item req;
			req = fifo_seq_item::type_id::create("req");

			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

class fifo_write_sequence extends uvm_sequence#(fifo_seq_item);

	`uvm_object_utils(fifo_write_sequence)

	fifo_seq_item item;

	function new(string name ="fifo_write_sequence");
		super.new(name);
	endfunction

	virtual task body();
		repeat(8) begin
			 
			item = fifo_seq_item :: type_id:: create ("item");

			start_item(item);
			assert(item.randomize() with {
    				item.wr == 1;
    				item.rd == 0;
			});
			finish_item(item);

			set_response_queue_depth(15);
		end
	endtask
endclass



class fifo_read_sequence extends uvm_sequence#(fifo_seq_item);

	`uvm_object_utils (fifo_read_sequence)

	function new(string name="fifo_read_sequence");
		super.new(name);
	endfunction

	virtual task body();
		repeat(8) begin
			fifo_seq_item req;
			req = fifo_seq_item::type_id::create("req");

			start_item(req);
			assert(req.randomize() with { rd == 1; wr == 0; });
			finish_item(req);
		end
	endtask
 endclass



 class fifo_wr_then_rd_sequence extends uvm_sequence#(fifo_seq_item);

	 

	 `uvm_object_utils(fifo_wr_then_rd_sequence)
		
	 fifo_write_sequence wr_seq;
	 fifo_read_sequence rd_seq;


	 function new(string name ="fifo_wr_then_rd_sequence");
		 super.new(name);
	 endfunction

	 virtual task body();
		 repeat(8) begin

			 `uvm_do(wr_seq)
			 `uvm_do(rd_seq)
		 end
	 endtask
 endclass




class fifo_write_read_sequence extends uvm_sequence #(fifo_seq_item);

	`uvm_object_utils(fifo_write_read_sequence)

	function new(string name= "fifo_write_read_sequence");
		super.new(name);
	endfunction

	virtual task body();
		repeat(5) begin

			`uvm_do_with(req,{req.wr==1;req.rd==0;})
			`uvm_do_with(req,{req.wr==0;req.rd==1;})

			set_response_queue_error_report_disabled(1);

		end
	endtask
endclass



class fifo_wr_rd_parallel_seq extends uvm_sequence #(fifo_seq_item);

	`uvm_object_utils(fifo_wr_rd_parallel_seq)

	function new(string name ="fifo_wr_rd_parallel_seq");
		super.new(name);
	endfunction

	virtual task body();

		repeat(8) begin
			fifo_seq_item req;
			req = fifo_seq_item::type_id::create("req");

			start_item(req);
			assert(req.randomize() with { wr == 1; rd == 1; });
			finish_item(req);
		end

	endtask

endclass