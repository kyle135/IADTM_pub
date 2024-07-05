`ifndef __LOGICALAGENT__SVH
   `define __LOGICALAGENT__SVH
//---------------------------------------------------------------------------------
// Agent
//---------------------------------------------------------------------------------
class LogicalAgent extends uvm_agent;
   typedef LogicalAgent this_type_t;
    `uvm_component_utils(LogicalAgent)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------   
    LogicalSequencer sqr;
    LogicalDriver    drv;
    LogicalMonitor   mtr;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------    
    function new(string name = "LogicalAgent", uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );
 
       sqr = LogicalSequencer::type_id::create("sqr", this);
       drv = LogicalDriver::type_id::create("drv", this);
       mtr = LogicalMonitor::type_id::create("mtr", this);
    endfunction : build_phase
 
    function void connect_phase(uvm_phase phase);
       super.connect_phase(phase);
       drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction : connect_phase

 endclass : LogicalAgent
 `endif // __LOGICALAGENT__SVH
