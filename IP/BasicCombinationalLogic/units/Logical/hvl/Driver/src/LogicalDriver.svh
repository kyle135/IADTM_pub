`ifndef __LOGICALDRIVER__SVH
    `define __LOGICALDRIVER__SVH
//---------------------------------------------------------------------------------
// Driver
//---------------------------------------------------------------------------------
class LogicalDriver extends uvm_driver #(LogicalSequenceItem);
    typedef LogicalDriver this_type_t;
    `uvm_component_utils(LogicalDriver)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    virtual LogicalInterface                 intf;
    LogicalConfig                            cfg; 
    uvm_analysis_port #(LogicalSequenceItem) in_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new ( string name = "LogicalDriver", uvm_component parent );
       super.new ( name, parent );
 
       in_ap = new ( "in_ap", this );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );

        if (!uvm_config_db#(virtual LogicalInterface)::get (this, "", "intf", intf))
            `uvm_fatal ("LogicalDriver", { "Virtual interface must be set for ", get_full_name ( ), ".intf"})
        if (!uvm_config_db#(LogicalConfig)::get (this, "", "cfg", cfg))
            `uvm_fatal ("LogicalDriver", { "Configuration Object connect be set for ", get_full_name ( ), ".cfg"})
    endfunction : build_phase
 
    task run_phase ( uvm_phase phase );
        drive ( );
    endtask : run_phase
 
    virtual task drive ( );
        LogicalSequenceItem item;
        intf.drive_inputs ( 1'b0, 1'b0 );
 
        forever begin
            seq_item_port.get_next_item ( item );
 
            `uvm_info ("LogicalDriver", item.sprint(), UVM_LOW );
            intf.drive_inputs ( item.a, item.b );
 
            // Ping the event so that the monitor knows to capture the output
            cfg.capture.trigger();
            in_ap.write(item);
            seq_item_port.item_done();
            #10;
        end
    endtask : drive
 endclass : LogicalDriver
 `endif // __LOGICALDRIVER__SVH