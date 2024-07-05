//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  BitWiseMonitor
// Module Name:  UVM Monitor for bitwise designs.
// Dependencies:
//-----------------------------------------------------------------------------
`ifndef __BITWISEMONITOR__SVH
    `define __BITWISEMONITOR__SVH
class BitWiseMonitor extends uvm_driver#(BitWiseSequenceItem);
    typedef BitWiseMonitor this_type_t;
    `uvm_component_utils(BitWiseMonitor)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    virtual BitWiseInterface intf;
    BitWiseConfig            cfg;
    // The monitor is a publisher as it broadcasts the ouput of the dut. 
    uvm_analysis_port #(BitWiseSequenceItem) out_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------    
    function new ( string name="BitWiseMonitor", uvm_component parent );
        super.new ( name, parent );
        out_ap = new ( "out_ap", this );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
       super.build_phase ( phase );
 
        if ( !uvm_config_db#(virtual BitWiseInterface)::get(this, "", "intf", intf ) )
            `uvm_fatal ("BitWiseMonitor", {"Virtual interface must be set for ", get_full_name ( ), ".intf" });
        if ( !uvm_config_db#(BitWiseConfig)::get(this, "", "cfg", cfg ) )
            `uvm_fatal ("BitWiseMonitor", { "Configuration object must be set for ", get_full_name ( ), ".cfg" });
    endfunction : build_phase
 
    task run_phase ( uvm_phase phase );
        monitor ( );
    endtask : run_phase
 
    virtual task monitor ( );
        BitWiseSequenceItem item;
        item = BitWiseSequenceItem::type_id::create ( "item" );
 
        forever begin
            // Wait for an event to be triggered
            cfg.capture.wait_trigger ( );
 
            // Wait 1 unit time for the AND gate to propagate result.
            #1 intf.capture_outputs ( item.c );
            `uvm_info ( "BitWiseMonitor", item.sprint(), UVM_LOW );
            // Write into scoreboard
            out_ap.write ( item );
        end
    endtask : monitor
 endclass : BitWiseMonitor
 `endif // __BITWISEMONITOR__SVH