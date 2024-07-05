//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  UVM Drive object for BitWise logic designs.
// Module Name:  BitWiseDriver
// Dependencies: 
//-----------------------------------------------------------------------------
`ifndef __BITWISEDRIVER__SVH
    `define __BITWISEDRIVER__SVH
//-----------------------------------------------------------------------------
// Driver
//-----------------------------------------------------------------------------
class BitWiseDriver extends uvm_driver #(BitWiseSequenceItem);
    typedef BitWiseDriver this_type_t;
    `uvm_component_utils(BitWiseDriver)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    virtual BitWiseInterface   intf;
    BitWiseConfig              cfg; 
    uvm_analysis_port #(BitWiseSequenceItem) in_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new ( string name = "BitWiseDriver", uvm_component parent );
       super.new ( name, parent );
 
       in_ap = new ( "in_ap", this );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );

        if (!uvm_config_db#(virtual BitWiseInterface)::get (this, "", "intf", intf ) )
            `uvm_fatal ("BitWiseDriver", { "Virtual interface must be set for ", get_full_name ( ), ".intf" } )
        if (!uvm_config_db#(BitWiseConfig)::get (this, "", "cfg", cfg))
            `uvm_fatal ("BitWiseDriver", { "Configuration Object connect be set for ", get_full_name ( ), ".cfg" } )
    endfunction : build_phase
 
    task run_phase ( uvm_phase phase );
        drive ( );
    endtask : run_phase
 
    virtual task drive ( );
        BitWiseSequenceItem item;
        intf.drive_inputs ( 1'b0, 1'b0 );
 
        forever begin
            seq_item_port.get_next_item ( item );
 
            `uvm_info ("BitWiseDriver", item.sprint(), UVM_LOW );
            intf.drive_inputs ( item.a, item.b );
 
            // Ping the event so that the monitor knows to capture the output
            cfg.capture.trigger();
            in_ap.write(item);
            seq_item_port.item_done();
            #10;
        end
    endtask : drive
 endclass : BitWiseDriver
 `endif // __BITWISEDRIVER__SVH