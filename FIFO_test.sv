package FIFO_test_pkg;

import FIFO_config_pkg::*;
import FIFO_env_pkg::*;
import FIFO_wr_sequence_pkg::*;
import FIFO_rd_sequence_pkg::*;
import FIFO_wr_rd_sequence_pkg::*;
import FIFO_reset_sequence_pkg::*;
import FIFO_agent_pkg::*;
import FIFO_scoreboard_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_test extends uvm_test;
  `uvm_component_utils(FIFO_test)
 
  FIFO_env env;
  
  FIFO_config FIFO_cfg;
  
  FIFO_wr_sequence wr_seq;
  FIFO_rd_sequence rd_seq;
  FIFO_wr_rd_sequence wr_rd_seq;
  FIFO_reset_sequence reset_seq;
  
  
  function new (string name ="FIFO_test", uvm_component parent= null);
     super.new(name,parent);
  endfunction

  function void build_phase (uvm_phase phase);
     super.build_phase(phase);
  
     env=FIFO_env::type_id::create("env",this);
     FIFO_cfg= FIFO_config::type_id::create("FIFO_cfg",this);
     wr_seq=FIFO_wr_sequence::type_id::create("wr_seq",this);
     rd_seq=FIFO_rd_sequence::type_id::create("rd_seq",this);
     wr_rd_seq=FIFO_wr_rd_sequence::type_id::create("wr_rd_seq",this);
     reset_seq= FIFO_reset_sequence::type_id::create("reset_seq",this);
	  
	  
	  
    if(!uvm_config_db #(virtual FIFO_inf) ::get (this,"","FIFO_IF",FIFO_cfg.FIFO_vif))
      `uvm_fatal("build_phase","test-unable to get virtual interface of FIFO");
	
    uvm_config_db #(FIFO_config)	::set(this,"*","CFG",FIFO_cfg);
 
   endfunction
 
  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     phase.raise_objection(this);
 
    

    //resetfuction
   `uvm_info("run_phase", "reset_asserted",UVM_LOW)
    reset_seq.start(env.agt.sqr);
   `uvm_info("run_phase", "reset_deasserted",UVM_LOW)
  
    //wr sequence
   `uvm_info("run_phase", "wr_seq_asserted",UVM_LOW)
    wr_seq.start(env.agt.sqr);
   `uvm_info("run_phase", "wr_seq_deasserted",UVM_LOW)
   
    
    //resetfuction
   `uvm_info("run_phase", "reset_asserted",UVM_LOW)
    reset_seq.start(env.agt.sqr);
   `uvm_info("run_phase", "reset_deasserted",UVM_LOW)
   
    //rd sequence
   `uvm_info("run_phase", "rd_asserted",UVM_LOW)
    rd_seq.start(env.agt.sqr);
   `uvm_info("run_phase", "rd_deasserted",UVM_LOW)
   
    
    //resetfuction
   `uvm_info("run_phase", "reset_asserted",UVM_LOW)
    reset_seq.start(env.agt.sqr);
   `uvm_info("run_phase", "reset_deasserted",UVM_LOW)
   
	//wr&rd sequence
   `uvm_info("run_phase", "wr_rd_asserted",UVM_LOW)
    wr_rd_seq.start(env.agt.sqr);
   `uvm_info("run_phase", "wr_rd_deasserted",UVM_LOW) 
   
     phase.drop_objection(this);
   
 endtask
endclass
endpackage