
package FIFO_wr_sequence_pkg;
  import uvm_pkg::*;
  import FIFO_seq_item_pkg::*;
`include "uvm_macros.svh"

 class FIFO_wr_sequence extends uvm_sequence #(FIFO_seq_item);
  
    `uvm_object_utils( FIFO_wr_sequence)
	 FIFO_seq_item  seq_item ;
    function new(string name="FIFO_wr_sequence");
      super.new(name);
    endfunction
	
    task body();
   
     repeat(200) begin
        
	    seq_item= FIFO_seq_item #(16) ::type_id::create("seq_item");
	    start_item(seq_item);
	    assert(seq_item.randomize with { wr_en==1; rd_en==0;});
	    finish_item(seq_item);
		
		
	end
	
   endtask
  endclass
  endpackage 