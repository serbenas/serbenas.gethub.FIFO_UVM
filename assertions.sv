module assertions  #(parameter DATA_WIDTH = 16,ADDR_WIDTH = 5) (
 
  input  clk ,
  input  rst_n, wr_en, rd_en,
  input [DATA_WIDTH-1:0] data_in,
  input [DATA_WIDTH-1:0] data_out ,
  input full, empty);
  integer i;

//assertions to check incrementing of write pointer
assertion_WR_inc: assert property(@(posedge clk) disable iff (rst_n) (wr_en && !full) |=> (DUT.write_ptr == ($past(DUT.write_ptr) + 1'd1))); 
assertion_WR_inc_c: cover property(@(posedge clk) disable iff (rst_n) (wr_en && !full) |=> (DUT.write_ptr == ($past(DUT.write_ptr) + 1'd1)));
 
 
//assertions to check writing operation
assertion_WR_en:assert property(@(posedge clk) disable iff (rst_n) (wr_en && !full) |=> ( (DUT.FIFO[$past(DUT.write_ptr)])==$past(data_in)));
assertion_WR_en_c: cover property(@(posedge clk) disable iff (rst_n) (wr_en && !full) |=> ( (DUT.FIFO[$past(DUT.write_ptr)])==$past(data_in)));

//assertions to check incrementing of read pointer
assertion_RD_inc: assert property(@(posedge clk) disable iff (rst_n) (rd_en && !empty) |=> (DUT.read_ptr == ($past(DUT.read_ptr) + 1'd1))); 
assertion_RD__inc_c: cover property(@(posedge clk) disable iff (rst_n) (rd_en && !empty) |=> (DUT.read_ptr == ($past(DUT.read_ptr) + 1'd1)));
 

//assertions to check reading operation
assertion_RD_en:assert property(@(posedge clk) disable iff (rst_n) (rd_en && !empty) |=> ( (data_out==DUT.FIFO[$past(DUT.read_ptr)])));
assertion_RD_en_c:cover property(@(posedge clk) disable iff (rst_n) (rd_en && !empty) |=> ( (data_out==DUT.FIFO[$past(DUT.read_ptr)])));

//assertions to check reset operation
always_comb begin
    if (rst_n) begin
        assert final (data_out==0);
        assert final (DUT.write_ptr==0);
        assert final (DUT.read_ptr==0);
		for (i=0;i<(ADDR_WIDTH*2);i++) begin 
		  assert final(DUT.FIFO[i]==0);
		end 
	end
end	
endmodule