`ifndef __ADDMONITOR__SVH
    `define __ADDMONITOR__SVH
class AddMonitor extends uvm_monitor;
    typedef AddMonitor this_type_t;
    `uvm_component_utils(AddMonitor)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    parameter integer N = 32;

    virtual AddInterface intf;
    AddConfig            cfg;
    // The monitor is a publisher as it broadcasts the ouput of the dut. Therefore
    // we use uvm_analysis_port.
    uvm_analysis_port #(AddSequenceItem) out_ap;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------        
    function new (string name = "AddMonitor", uvm_component parent);
        super.new (name, parent);
        out_ap = new ("out_ap", this);
    endfunction : new
     
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        if ( !uvm_config_db#(AddConfig)::get(this, "", "cfg", cfg ) )
            `uvm_fatal ("AddMonitor", { "Configuration object must be set for ", get_full_name ( ), ".cfg" });
        
        if ( !uvm_config_db#(virtual AddInterface)::get(this, "", "intf", intf ) )
            `uvm_fatal ("AddMonitor", {"Virtual interface must be set for ", get_full_name ( ), ".intf" });

    endfunction : build_phase
     
    task run_phase(uvm_phase phase);
        monitor( );
    endtask : run_phase
     
    virtual task monitor ( );
        AddSequenceItem item;
        item = AddSequenceItem::type_id::create("item");
     
        forever begin
            // Wait for an event to be triggered
            cfg.capture.wait_trigger ( );
     
            // Wait 1 unit time for the AND gate to propagate result.
            #1 intf.capture_outputs ( item.c, item.carry_out );
            `uvm_info ( "AddMonitor", item.sprint(), UVM_LOW );
            // Write into scoreboard
            out_ap.write ( item );
        end
    endtask : monitor

endclass : AddMonitor
`endif // __ADDMONITOR__SVH