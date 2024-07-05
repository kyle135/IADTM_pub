`ifndef __ADDAGENT__SVH
   `define __ADDAGENT__SVH
//---------------------------------------------------------------------------------
// Agent
//---------------------------------------------------------------------------------
class AddAgent extends uvm_agent;
    typedef AddAgent this_type_t;
    `uvm_component_utils(AddAgent)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    AddSequencer sqr;
    AddDriver    drv;
    AddMonitor   mtr;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------    
    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );
 
       sqr = AddSequencer::type_id::create("sqr", this);
       drv = AddDriver::type_id::create("drv", this);
       mtr = AddMonitor::type_id::create("mtr", this);
    endfunction : build_phase
 
    function void connect_phase(uvm_phase phase);
       super.connect_phase(phase);
       drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction : connect_phase

 endclass : AddAgent

 `endif // __ADDAGENT__SVH