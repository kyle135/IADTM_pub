//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     ALUAgent
// Description:     UVM Agent
//-------------------------------------------------------------------------------------------------
`ifndef __ALUAGENT__SVH
   `define __ALUAGENT__SVH
//-----------------------------------------------------------------------------
// Agent
//-----------------------------------------------------------------------------
class  ALUAgent extends uvm_agent;
    typedef  ALUAgent this_type_t;
    `uvm_component_utils(ALUAgent)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    ALUSequencer alu_sqr;
    ALUDriver    alu_drv;
    ALUMonitor   alu_mon;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new(string name = "ALUAgent", uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        // The driver and, sequencer and monitor are created during the build phase.
        // Create the driver with new() and not the factory. This is because we are not making 
        // any change to the Sequencer.
        alu_sqr =  new("alu_sqr", this); 
        alu_drv =  ALUDriver::type_id::create("alu_drv", this);
        alu_mon =  ALUMonitor::type_id::create("alu_mon", this);
    endfunction : build_phase
 
    function void connect_phase(uvm_phase phase);
       super.connect_phase(phase);
       // The driver port and sequencer export are connected during the connect phase.
       alu_drv.seq_item_port.connect(alu_sqr.seq_item_export);
    endfunction : connect_phase

 endclass :  ALUAgent
 `endif // __ALUAGENT__SVH