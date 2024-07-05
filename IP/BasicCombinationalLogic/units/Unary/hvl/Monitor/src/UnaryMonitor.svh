`ifndef __UNARYMONITOR__SVH
    `define __UNARYMONITOR__SVH
class UnaryMonitor extends uvm_monitor;
    typedef UnaryMonitor this_type_t;
    `uvm_component_utils(UnaryMonitor)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    parameter integer N = 32;

    virtual UnaryInterface intf;
    UnaryConfig            cfg;
    // The monitor is a publisher as it broadcasts the ouput of the dut. Therefore
    // we use uvm_analysis_port.
    uvm_analysis_port #(UnarySequenceItem) out_ap;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------        
    function new (string name = "UnaryMonitor", uvm_component parent);
        super.new (name, parent);
        out_ap = new ("out_ap", this);
    endfunction : new
     
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        if ( !uvm_config_db#(UnaryConfig)::get(this, "", "cfg", cfg ) )
            `uvm_fatal ("UnaryMonitor", { "Configuration object must be set for ", get_full_name ( ), ".cfg" });
        
        if ( !uvm_config_db#(virtual UnaryInterface)::get(this, "", "intf", intf ) )
            `uvm_fatal ("UnaryMonitor", {"Virtual interface must be set for ", get_full_name ( ), ".intf" });

    endfunction : build_phase
     
    task run_phase(uvm_phase phase);
        monitor( );
    endtask : run_phase
     
    virtual task monitor ( );
        UnarySequenceItem item;
        item = UnarySequenceItem::type_id::create("item");
     
        forever begin
            // Wait for an event to be triggered
            cfg.capture.wait_trigger ( );
     
            // Wait 1 unit time for the AND gate to propagate result.
            #1 intf.capture_outputs ( item.c );
            `uvm_info ( "UnaryMonitor", item.sprint(), UVM_LOW );
            // Write into scoreboard
            out_ap.write ( item );
        end
    endtask : monitor

endclass : UnaryMonitor
`endif // __UNARYMONITOR__SVH