/*Assignment agenda:

Implement an adapter class for the design whose code is mentioned in the instruction tab.

The functionality of I/O ports is as follows:

1) clk is the global clock signal

2) rst is active high synchronous reset

3) addrin is used to specify address of register where read or write operation will be performed.

4) datain is an input data bus

5) dataout is the output data bus.

6) wr is mode control pin (if wr is high then specific register will be updated with datain value based on address specified on addrin bus else content of register will be returned on dataout bus  based on address specified on addrin bus )
*/

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

//transaction class
class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)

  bit wr;
  bit [3:0]  addr;
  bit [31:0]  din;
  bit [31:0] dout;
  
  function new(string name = "transaction");
    super.new(name);
  endfunction
  
endclass
 
class top_adapter extends uvm_reg_adapter;
  `uvm_object_utils(top_adapter)
  
  //Constructor
  function new(string name = "top_adapter");
    super.new(name);
  endfunction
  
  //reg2bus
  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    
    transaction tr;
    tr = transaction::type_id::create("tr");
    
    tr.wr = (rw.kind == UVM_WRITE) ? 1'b1 : 1'b0;
    tr.addr = rw.addr;
    if(tr.wr == 1'b1) tr.din = rw.data;
    if(tr.wr == 1'b0) tr.dout = rw.data;
    
    return tr;
  endfunction
  
  
  //bus2reg
  function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    transaction tr;
    
    assert($cast(tr,bus_item));
    
    rw.kind = (tr.wr == 1'b1) ? UVM_WRITE : UVM_READ;
    rw.data = tr.dout;
    rw.addr = tr.addr;
    rw.status = UVM_IS_OK;
    
  endfunction
  
endclass
