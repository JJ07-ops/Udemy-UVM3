/*Assignment agenda:

Implement register block in the verification environment for the DUT, which consists of two 24-bit registers whose structure is mentioned in Instruction tab.

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

class slv_reg1 extends uvm_reg;
  `uvm_object_utils(slv_reg1)
  
  //declare the reg fields
  rand uvm_reg_field addr;
  rand uvm_reg_field data;
  
  //constructor
  function new(string name = "slv_reg1");
    super.new(name,24,UVM_NO_COVERAGE);
  endfunction
  
  //build
  function void build;
    
    addr = uvm_reg_field::type_id::create("addr");
    addr.configure(  .parent(this), 
                     .size(12), 
                     .lsb_pos(0), 
                     .access("RW"),  
                     .volatile(0), 
                     .reset(0), 
                     .has_reset(1), 
                     .is_rand(1), 
                     .individually_accessible(1)); 
    
    data = uvm_reg_field::type_id::create("data");
    data.configure(  .parent(this), 
                     .size(12), 
                     .lsb_pos(12), 
                     .access("RW"),  
                     .volatile(0), 
                     .reset(0), 
                     .has_reset(1), 
                     .is_rand(1), 
                     .individually_accessible(1)); 
  
    
  endfunction
  
endclass

//regblock
class top_reg_block extends uvm_reg_block;
  `uvm_object_utils(slv_reg1)
  
  //declare the two registers
  rand slv_reg0 reg0;
  rand slv_reg1 reg1;
  
  //constructor
  function new(string name = "top_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction
  
  //build function
  function build();
    //build the two registers
    reg0 = slv_reg0::type_id::create("reg0");
    reg0.build();
    reg0.configure(this);
    
    reg1 = slv_reg1::type_id::create("reg0");
    reg1.build();
    reg1.configure(this);
    
    //build the address map and add the two registers
    default_map = create_map("default_map",0,3,UVM_LITTLE_ENDIAN);
    default_map.add_reg(reg0,0,"RW");
    default_map.add_reg(reg1,3,"RW");
    
    //lock the model
    lock_model();
  endfunction
  
endclass



//testbench top
module tb;
  
  top_reg_block rb;
  
  initial begin
    rb = new("rb");
    rb.build();
  end
  
endmodule
