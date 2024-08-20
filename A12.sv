/*Assignment agenda:

Implement a 64 x 32 RAM memory in Verification environment whose structure is mentioned in the Instruction tab.

*/

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
 
class RAM1 extends uvm_mem;
  `uvm_object_utils(RAM1)
  
  //constructor
  function new(string name = "RAM1");
    super.new(name,64,32,"RW",UVM_NO_COVERAGE);
  endfunction
  
endclass



//testbench top
module tb;
  
  RAM1 memory1;
  
  initial begin
    memory1 = new("memory1");
  end
  
endmodule
