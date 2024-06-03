module FIFO #(parameter
    ADDR_WIDTH           = 5,
    DATA_WIDTH           = 16,
    fifo_size                   =2**ADDR_WIDTH
  )(
    input clk,
    input rst_n,
    input wr_en,
  input reg [DATA_WIDTH-1:0] data_in,
    input rd_en,
    output full,
    output empty,
  output reg [DATA_WIDTH-1:0] data_out
  ); 
    reg  [DATA_WIDTH-1:0] FIFO  [fifo_size-1:0] ;
    reg [ADDR_WIDTH-1:0] write_ptr,read_ptr;

    assign empty   = ( write_ptr == read_ptr ) ? 1'b1 : 1'b0;
    assign full    = ( read_ptr == (write_ptr+1) ) ? 1'b1 : 1'b0;
integer i;
    always @ (posedge clk , posedge rst_n) begin
        if(rst_n) begin
         for(i=0;i<fifo_size;i=i+1) begin
            FIFO[i]<=0;
         end
         write_ptr <=0;
        end
  else if( wr_en && ~full) begin
            FIFO[write_ptr] <= data_in;
              write_ptr <= write_ptr + 1;
        end

    end

    always @ (posedge clk, posedge rst_n) begin

        if(rst_n) begin
            data_out <= 0;
            read_ptr <= 0;
        end

        else if( rd_en && ~empty) begin
            data_out <= FIFO[read_ptr];
            read_ptr <= read_ptr + 1;
        end

    end

endmodule
