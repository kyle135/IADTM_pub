`ifndef __ADDDRIVER__SVH
    `define __ADDDRIVER__SVH
//---------------------------------------------------------------------------------
// Driver
//---------------------------------------------------------------------------------
class AddDriver extends uvm_driver #(AddSequenceItem);
    typedef AddDriver this_type_t;
    `uvm_component_utils(AddDriver)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    virtual AddInterface                 intf;
    AddConfig                            cfg; 
    uvm_analysis_port #(AddSequenceItem) in_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new ( string name, uvm_component parent );
       super.new ( name, parent );
 
       in_ap = new ( "in_ap", this );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );

        if (!uvm_config_db#(virtual AddInterface)::get (this, "", "intf", intf))
            `uvm_fatal ("AddDriver", { "Virtual interface must be set for ", get_full_name ( ), ".intf"})
        if (!uvm_config_db#(AddConfig)::get (this, "", "cfg", cfg))
            `uvm_fatal ("AddDriver", { "Configuration Object connect be set for ", get_full_name ( ), ".cfg"})
    endfunction : build_phase
 
    task run_phase ( uvm_phase phase );
        drive ( );
    endtask : run_phase
 
    virtual task drive ( );
        AddSequenceItem item;
        intf.drive_inputs ('d0, 'd0, 1'b0);
 
        forever begin
            seq_item_port.get_next_item ( item );
 
            `uvm_info ("AddDriver", item.sprint(), UVM_LOW );
            intf.drive_inputs ( item.a, item.b, item.carry_in);
 
            // Ping the event so that the monitor knows to capture the output
            cfg.capture.trigger();
            in_ap.write(item);
            seq_item_port.item_done();
            #10;
        end
    endtask : drive

 endclass : AddDriver
 `endif // __ADDDRIVER__SVH