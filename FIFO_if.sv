interface FIFO_inf #(parameter DATA_WIDTH=16 ) (clk);
 
  input bit  clk ;
  logic  rst_n, wr_en, rd_en;
  logic  [DATA_WIDTH-1:0]  data_in;
  logic  [DATA_WIDTH-1:0]  data_out ;
 
  logic full, empty;

 


endinterface 