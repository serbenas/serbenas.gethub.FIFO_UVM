package FIFO_scoreboard_pkg ;

     import uvm_pkg::*;
    `include "uvm_macros.svh"
     import FIFO_seq_item_pkg::*;
	 
  class   FIFO_scoreboard #(DATA_WIDTH = 16,ADDR_WIDTH = 5) extends uvm_scoreboard;
     `uvm_component_utils( FIFO_scoreboard)
	  uvm_analysis_export   #(FIFO_seq_item) sb_export;
	  uvm_tlm_analysis_fifo #(FIFO_seq_item) sb_fifo;
	  FIFO_seq_item  seq_item_sb;
	  virtual FIFO_inf  FIFO_vif;
      
	  logic [DATA_WIDTH-1:0] data_out_ref;
	  reg  [DATA_WIDTH-1:0] mem  [10-1:0] ;
	  reg [ADDR_WIDTH-1:0]rd_ptr_ref,wr_ptr_ref;
	  logic full,empty;
	  int i;
	  int error_count=0;
	  int correct_count=0;
	  
	  function new (string name="FIFO_scoreboard ", uvm_component parent= null);
	    super.new(name,parent);
	  endfunction
    
     function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        sb_export =new("sb_export", this);
		sb_fifo =new("sb_fifo", this);
		
     endfunction	
	 function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);
	endfunction
	
	task run_phase(uvm_phase phase);
	  super.run_phase(phase);
	  forever begin
	    sb_fifo.get(seq_item_sb);
		ref_model(seq_item_sb);
		if (seq_item_sb.data_out != data_out_ref) begin 
		    `uvm_error("run_phase", $sformatf ("comparsion failed, transaction received by DUT :%s, while ref out :0b%0b, rd_ptr_ref=0b%0b,wr_ptr_ref=0b%0b",seq_item_sb.convert2string(),data_out_ref,rd_ptr_ref,wr_ptr_ref));
			 error_count++;
		end

        else begin
             `uvm_info("run_phase", $sformatf ("correct FIFO_out: %s",seq_item_sb.convert2string()),UVM_HIGH);		
		      correct_count++;
		end	
     end		
     endtask

    task ref_model (FIFO_seq_item seq_item_chk);
	 
      if (seq_item_chk.rst_n)begin
        data_out_ref=0;
		wr_ptr_ref=0;
		rd_ptr_ref=0;
        for(i=0;i<(ADDR_WIDTH*2);i++)begin
            mem[i]=0;
		end	
	  end
      else begin
	    if(seq_item_chk.wr_en && ~full)begin
            mem[wr_ptr_ref]=seq_item_chk.data_in;
			wr_ptr_ref++;
		end
		if(seq_item_chk.rd_en && ~empty)begin   
		    data_out_ref=mem[rd_ptr_ref];
			rd_ptr_ref++;
		end

      end	
		if (rd_ptr_ref==(wr_ptr_ref+1))
		  full=1;
		else
		  full=0;
		if (rd_ptr_ref==wr_ptr_ref)
		  empty=1;
		else
		  empty=0;  
  
	endtask


    function void report_phase(uvm_phase  phase);
        super.report_phase(phase);
        `uvm_info("report_phase", $sformatf("total succesful transactions: %0d",correct_count),UVM_MEDIUM);
      	`uvm_info("report_phase", $sformatf("total failled transactions: %0d",error_count),UVM_MEDIUM);	
	endfunction
	
  endclass
endpackage	
