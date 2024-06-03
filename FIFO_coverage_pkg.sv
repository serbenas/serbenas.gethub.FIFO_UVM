package FIFO_coverage_pkg;

   import FIFO_seq_item_pkg::*;
   import uvm_pkg::*;
  `include "uvm_macros.svh"
   class FIFO_coverage extends uvm_component;
      `uvm_component_utils (FIFO_coverage)
       uvm_analysis_export #(FIFO_seq_item) cov_export; 
	   uvm_tlm_analysis_fifo #(FIFO_seq_item) cov_fifo;
       FIFO_seq_item seq_item_cov;
       
	   
          covergroup cvr_grp  ;
             rst_n_g:  coverpoint seq_item_cov.rst_n;
             wr_en_g:  coverpoint seq_item_cov.wr_en;
             rd_en_g:  coverpoint seq_item_cov.rd_en;
             
             full_g: coverpoint seq_item_cov.full;
             empty_g: coverpoint seq_item_cov.empty;
          
             wr_rd: cross wr_en_g,rd_en_g;
            
		  endgroup;
			
			
       function new(string name = "FIFO_coverage", uvm_component parent = null);
          super.new (name, parent);
          cvr_grp = new();
       endfunction
	   
	   
       function void build_phase (uvm_phase phase);
          super.build_phase (phase);
          cov_export = new("cov_export", this);
          cov_fifo = new("cov_fifo", this);
       endfunction
	   
        function void connect_phase (uvm_phase phase);
           super. connect_phase (phase);
           cov_export.connect (cov_fifo.analysis_export);
        endfunction
		
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                cov_fifo.get (seq_item_cov); 
				cvr_grp.sample();
            end
        endtask
		
    endclass
endpackage	