`ifndef __LOGICALMONITOR__SVH
    `define __LOGICALMONITOR__SVH
class LogicalMonitor extends uvm_monitor;
    typedef LogicalMonitor this_type_t;
    `uvm_component_utils(LogicalMonitor)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    virtual LogicalInterface intf;
    LogicalConfig            cfg;
    // The monitor is a publisher as it broadcasts the ouput of the dut. 
    uvm_analysis_port #(LogicalSequenceItem) out_ap;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------        
    function new (string name = "LogicalMonitor", uvm_component parent);
        super.new (name, parent);
        out_ap = new ("out_ap", this);
    endfunction : new
     
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        if ( !uvm_config_db#(LogicalConfig)::get(this, "", "cfg", cfg ) )
            `uvm_fatal ("LogicalMonitor", { "Configuration object must be set for ", get_full_name ( ), ".cfg" });
        
        if ( !uvm_config_db#(virtual LogicalInterface)::get(this, "", "intf", intf ) )
            `uvm_fatal ("LogicalMonitor", {"Virtual interface must be set for ", get_full_name ( ), ".intf" });

    endfunction : build_phase
     
    task run_phase(uvm_phase phase);
        monitor( );
    endtask : run_phase
     
    virtual task monitor ( );
        LogicalSequenceItem item;
        item = LogicalSequenceItem::type_id::create("item");
     
        forever begin
            // Wait for an event to be triggered
            cfg.capture.wait_trigger ( );
     
            // Wait 1 unit time for the AND gate to propagate result.
            #1 intf.capture_outputs ( item.c );
            `uvm_info ( "LogicalMonitor", item.sprint(), UVM_LOW );
            // Write into scoreboard
            out_ap.write ( item );
        end
    endtask : monitor

endclass : LogicalMonitor
`endif // __LOGICALMONITOR__SVH