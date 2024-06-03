package  FIFO_seq_item_pkg;

import uvm_pkg::*;

`include "uvm_macros.svh"
class FIFO_seq_item #(FIFO_WIDTH = 16) extends uvm_sequence_item;
  `uvm_object_utils(FIFO_seq_item )
  rand  bit   rst_n, wr_en, rd_en;
  rand  bit  [FIFO_WIDTH -1:0] data_in;
  bit        [FIFO_WIDTH-1:0] data_out ;
  bit        wr_ack, overflow,clk;
  bit        full, empty, almostfull, almostempty, underflow;
 
  // constraints 
  
  constraint n1 {rst_n dist {1:=1, 0:=99}; 
                 
                 wr_en dist {1:=70, 0:=30}; 
				  
                  }
  
  

  function new(string name="FIFO_seq_item ");
    super.new(name);
  endfunction
  
 
  //print function
  function string convert2string();
    return $sformatf("%s  data_in=0b%b,wr_en=0b%b, rd_en=0b%b, rst_n=0b%b, data_out=0b%b",super.convert2string(),data_in,wr_en, rd_en, rst_n,data_out);
  endfunction
   
  function string convert2string_stimulus();
    return $sformatf("  data_in=0b%b,wr_en=0b%b, rd_en=0b%b, rst_n=0b%b",data_in,wr_en, rd_en, rst_n);
  endfunction
 
  endclass
  endpackage 
  
  
  