/*Assignment agenda:

Implement a 24-bit register in a verification environment whose structure is mentioned in the Instruction tab.

*/

`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
 
class slv_reg0 extends uvm_reg;
  `uvm_object_utils(slv_reg0)
  
  //declare the reg fields
  rand uvm_reg_field ctrl;
  rand uvm_reg_field addr;
  rand uvm_reg_field data;
  
  //constructor
  function new(string name = "slv_reg0");
    super.new(name,24,UVM_NO_COVERAGE);
  endfunction
  
  //build
  function void build;
    ctrl = uvm_reg_field::type_id::create("ctrl");
    ctrl.configure(  .parent(this), 
                   .size(6), 
                     .lsb_pos(0), 
                     .access("RW"),  
                     .volatile(0), 
                     .reset(0), 
                     .has_reset(1), 
                     .is_rand(1), 
                     .individually_accessible(1)); 
    
    addr = uvm_reg_field::type_id::create("addr");
    addr.configure(  .parent(this), 
                     .size(6), 
                     .lsb_pos(6), 
                     .access("RW"),  
                     .volatile(0), 
                     .reset(0), 
                     .has_reset(1), 
                     .is_rand(1), 
                     .individually_accessible(1)); 
    
    data = uvm_reg_field::type_id::create("data");
    data.configure(  .parent(this), 
                     .size(8), 
                     .lsb_pos(12), 
                     .access("RW"),  
                     .volatile(0), 
                     .reset(0), 
                     .has_reset(1), 
                     .is_rand(1), 
                     .individually_accessible(1)); 
  
    
  endfunction
  
endclass



//testbench top
module tb;
  
  slv_reg0 register0;
  
  initial begin
    register0 = new("register0");
    register0.build();
  end
  
endmodule
