`timescale 1ns/1ps

interface fifo_interface (input logic clk,input logic reset);

   logic [7:0] data_in;
   logic [7:0] data_out;
   logic empty;
   logic full;
   logic rd;
   logic wr;

    // Driver clocking block
  clocking driver_cb @(posedge clk);
    default input #1step output #0;
    output wr;
    output rd;
    output data_in;
  endclocking
 // Monitor clocking block
  clocking monitor_cb @(posedge clk);
    default input #1step output #0;
    input wr;
    input rd;
    input data_in;
    input data_out;
    input empty;
    input full;
  endclocking


   modport DRIVER  (clocking driver_cb, input clk, reset);
   modport MONITOR (clocking monitor_cb, input clk, reset);

endinterface