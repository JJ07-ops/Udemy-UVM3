//design code given in the question

module top(
  input clk, rst,
  input wr,
  input [3:0]  addrin,
  input [31:0]  datain,
  output [31:0] dataout
);
  
  ////////////DUT registers
  logic [31:0] reg1;///offset addr : 0
  logic [31:0] reg2;///offset addr : 1
  logic [31:0] reg3;///offset addr : 2
  logic [31:0] reg4;///offset addr : 3
  
  //////////// temporary register to store read data
  logic [31:0] temp;
  
  
  always@(posedge clk)
    begin
      if(rst)
        begin
        reg1 <= 32'h0;
        reg2 <= 32'h0;
        reg3 <= 32'h0;
        reg4 <= 32'h0;
        temp <= 32'h0;  
        end
      else 
        begin
          if(wr) 
           begin
            case(addrin)
              2'b00: reg1 <= datain;
              2'b01: reg2 <= datain;
              2'b10: reg3 <= datain;
              2'b11: reg4 <= datain;
            endcase
          end
          else
           begin
            case(addrin)
              2'b00: temp <= reg1;
              2'b01: temp <= reg2;
              2'b10: temp <= reg3;
              2'b11: temp <= reg4;
            endcase
          end
        end
    end
  assign dataout = temp;
  
endmodule
 
 
//////////////////////////////////////
 
interface top_if ;
  
  logic clk, rst;
  logic wr;
  logic [3:0]  addrin;
  logic [31:0]  datain;
  logic [31:0] dataout;
  
  
endinterface

