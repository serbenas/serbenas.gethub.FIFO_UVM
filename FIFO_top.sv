import FIFO_test_pkg ::*;
import uvm_pkg ::*;
`include "uvm_macros.svh"

module FIFO_top ();
parameter
    ADDR_WIDTH           = 5,
    DATA_WIDTH           = 16,
    fifo_size=2**ADDR_WIDTH;
	
 bit clk;
  initial begin
   forever #1 clk=~clk;
  end
FIFO_inf #( DATA_WIDTH) FIFO_if(clk);
FIFO #( ADDR_WIDTH, DATA_WIDTH,fifo_size)
                 DUT(.clk          (clk),
                .data_in      (FIFO_if.data_in),
                .data_out     (FIFO_if.data_out),
                .rd_en        (FIFO_if.rd_en),
                .wr_en        (FIFO_if.wr_en),
                .full         (FIFO_if.full),
                .empty        (FIFO_if.empty),
                .rst_n        (FIFO_if.rst_n)
				);
    

 assertions #( DATA_WIDTH,ADDR_WIDTH) 
                asr1(  .clk          (clk),
                .data_in      (DUT.data_in),
                .data_out     (DUT.data_out),
                .rd_en        (DUT.rd_en),
                .wr_en        (DUT.wr_en),
                .full         (DUT.full),
                .empty        (DUT.empty),
                .rst_n        (DUT.rst_n)
				);
  
 initial begin
 uvm_config_db#(virtual FIFO_inf) ::set (null, "uvm_test_top", "FIFO_IF",FIFO_if);
  run_test ("FIFO_test");
 end
endmodule 
