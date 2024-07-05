`ifndef __UNARYDRIVER__SVH
    `define __UNARYDRIVER__SVH
//---------------------------------------------------------------------------------
// Driver
//---------------------------------------------------------------------------------
class UnaryDriver extends uvm_driver #(UnarySequenceItem);
    typedef UnaryDriver this_type_t;
    `uvm_component_utils(UnaryDriver)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    virtual UnaryInterface                 intf;
    UnaryConfig                            cfg; 
    uvm_analysis_port #(UnarySequenceItem) in_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new ( string name, uvm_component parent );
       super.new ( name, parent );
 
       in_ap = new ( "in_ap", this );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );

        if (!uvm_config_db#(virtual UnaryInterface)::get (this, "", "intf", intf))
            `uvm_fatal ("UnaryDriver", { "Virtual interface must be set for ", get_full_name ( ), ".intf"})
        if (!uvm_config_db#(UnaryConfig)::get (this, "", "cfg", cfg))
            `uvm_fatal ("UnaryDriver", { "Configuration Object connect be set for ", get_full_name ( ), ".cfg"})
    endfunction : build_phase
 
    task run_phase ( uvm_phase phase );
        drive ( );
    endtask : run_phase
 
    virtual task drive ( );
        UnarySequenceItem item;
        intf.drive_inputs ('d0);
 
        forever begin
            seq_item_port.get_next_item ( item );
 
            `uvm_info ("UnaryDriver", item.sprint(), UVM_LOW );
            intf.drive_inputs ( item.a);
 
            // Ping the event so that the monitor knows to capture the output
            cfg.capture.trigger();
            in_ap.write(item);
            seq_item_port.item_done();
            #10;
        end
    endtask : drive

 endclass : UnaryDriver
 `endif // __UNARYDRIVER__SVH