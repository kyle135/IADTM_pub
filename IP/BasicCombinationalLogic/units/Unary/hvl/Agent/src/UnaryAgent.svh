`ifndef __UNARYAGENT__SVH
`define     __UNARYAGENT__SVH
//---------------------------------------------------------------------------------
// Agent
//---------------------------------------------------------------------------------
class UnaryAgent extends uvm_agent;
    typedef UnaryAgent this_type_t;
    `uvm_component_utils(UnaryAgent)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    UnarySequencer sqr;
    UnaryDriver    drv;
    UnaryMonitor   mtr;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------    
    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );
 
       sqr = UnarySequencer::type_id::create("sqr", this);
       drv = UnaryDriver::type_id::create("drv", this);
       mtr = UnaryMonitor::type_id::create("mtr", this);
    endfunction : build_phase
 
    function void connect_phase(uvm_phase phase);
       super.connect_phase(phase);
       drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction : connect_phase

 endclass : UnaryAgent

 `endif // __UNARYAGENT__SVH