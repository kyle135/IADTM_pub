//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  UVM Agent for BitWise logic designs.
// Module Name:  BitWiseAgent
// Dependencies: 
// - Verilog ['xor', 'not']
//-----------------------------------------------------------------------------
`ifndef __BITWISEAGENT__SVH
   `define __BITWISEAGENT__SVH
//-----------------------------------------------------------------------------
// Agent
//-----------------------------------------------------------------------------
class BitWiseAgent extends uvm_agent;
    typedef BitWiseAgent this_type_t;
    `uvm_component_utils(BitWiseAgent)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    BitWiseSequencer sqr;
    BitWiseDriver    drv;
    BitWiseMonitor   mtr;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new(string name = "BitWiseAgent", uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );
 
       sqr = BitWiseSequencer::type_id::create("sqr", this);
       drv = BitWiseDriver::type_id::create("drv", this);
       mtr = BitWiseMonitor::type_id::create("mtr", this);
    endfunction : build_phase
 
    function void connect_phase(uvm_phase phase);
       super.connect_phase(phase);
       drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction : connect_phase

 endclass : BitWiseAgent
 `endif // __BITWISEAGENT__SVH