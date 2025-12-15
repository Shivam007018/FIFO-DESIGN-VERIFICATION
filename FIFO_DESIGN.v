
//// DESIGN OF SYNCHRONOUS FIFO //// 


module FIFO(input clk,
            input rst , 
            input  wr, rd,
            
            input [7:0] din,
            output reg [7:0] dout,
            output empty, full);
  
 
  reg [3:0] wptr = 0;  /// pointer to write next location 
  reg [3:0]rptr = 0;   //// pointer to read next location
  
 
  reg [4:0] cnt = 0;   /// to track no. of elements 
  
  
  reg [7:0] mem [15:0];   /// 16 locations to store 8 bit wide 
 
  always @(posedge clk)
    begin
      if (rst == 1'b1)
        begin

          wptr <= 0;
          rptr <= 0;
          cnt  <= 0;
        end
      else if (wr && !full)     /// wr and not full 
        begin
         
          mem[wptr] <= din;
          wptr      <= wptr + 1;
          cnt       <= cnt + 1;
        end
      else if (rd && !empty)         // rd and not empty 
        begin
         
          dout <= mem[rptr];
          rptr <= rptr + 1;
          cnt  <= cnt - 1;
        end
    end
 

  assign empty = (cnt == 0) ? 1'b1 : 1'b0;
  assign full  = (cnt == 16) ? 1'b1 : 1'b0;
 
endmodule
 

