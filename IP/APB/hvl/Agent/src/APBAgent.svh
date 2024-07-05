//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     APBAgent
// Description:     UVM Agent
//-------------------------------------------------------------------------------------------------
`ifndef __APBAGENT__SVH
   `define __APBAGENT__SVH
//-----------------------------------------------------------------------------
// Agent
//-----------------------------------------------------------------------------
class  APBAgent extends uvm_agent;
    typedef  APBAgent this_type_t;
    `uvm_component_utils(APBAgent)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    APBSequencer apb_sqr;
    APBDriver    apb_drv;
    APBMonitor   apb_mon;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new(string name = "APBAgent", uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        // The driver and, sequencer and monitor are created during the build phase.
        // Create the driver with new() and not the factory. This is because we are not making 
        // any change to the Sequencer.
        apb_sqr =  new("apb_sqr", this); 
        apb_drv =  APBDriver::type_id::create("apb_drv", this);
        apb_mon =  APBMonitor::type_id::create("apb_mon", this);
    endfunction : build_phase
 
    function void connect_phase(uvm_phase phase);
       super.connect_phase(phase);
       // The driver port and sequencer export are connected during the connect phase.
       apb_drv.seq_item_port.connect(apb_sqr.seq_item_export);
    endfunction : connect_phase

 endclass :  APBAgent
 `endif // __APBAGENT__SVH