`timescale 1ns/1ps
import uvm_pkg::*;
import fifo_pkg::*;
`include "uvm_macros.svh"

module testbench_top;
bit clk;
bit reset;


//clock generation
initial begin
	clk=0;
	forever #2.5 clk=~clk;
end

// reset generation (active HIGH reset)
initial begin
  reset = 1;      // assert reset
  #10;            // hold reset for few cycles
  reset = 0;      // release reset
end
// interface instance
 fifo_interface in(clk,reset);

 // dut instance
 sync_fifo dut(.wdata(in.data_in), .clk(in.clk), .wr_en(in.wr), .rd_en(in.rd), .empty(in.empty), .full(in.full), .rst(in.reset),  .rdata(in.data_out ));

 // config db
 
 initial begin 
	 // set interface into config db, virtual intf, to get access in
	 // dynamic class
	  uvm_config_db #(virtual fifo_interface)::set(null, "*", "vif", in);
 end

 initial begin
	 run_test();
 end


 initial begin
    $dumpfile("dump_vcd.vcd");
    $dumpvars(0, testbench_top);
end
 endmodule
