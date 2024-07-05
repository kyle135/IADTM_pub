//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  UVM Environment object for BitWise logic designs.
// Module Name:  BitWiseEnvironment
// Dependencies:
//-----------------------------------------------------------------------------
`ifndef __BITWISEENVIRONMENT__SVH
    `define __BITWISEENVIRONMENT__SVH
//-----------------------------------------------------------------------------
// Environment
//-----------------------------------------------------------------------------
class BitWiseEnvironment extends uvm_env;
    typedef BitWiseEnvironment this_type_t;
    `uvm_component_utils(BitWiseEnvironment);
    
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    BitWiseAgent      agt;
    BitWiseScoreboard sbd;
    BitWiseConfig     cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new ( string name = "BitWiseEnvironment", uvm_component parent );
       super.new ( name, parent );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        agt = BitWiseAgent::type_id::create ("agt", this );
        sbd = BitWiseScoreboard::type_id::create ("sbd", this );
        if ( !uvm_config_db#(BitWiseConfig)::get(this, "", "cfg", cfg ) )
            `uvm_fatal ("BitWiseConfig", {"Configuration object must be set for ", get_full_name(), ".cfg" });
    endfunction : build_phase
 
    function void connect_phase ( uvm_phase phase );
        super.connect_phase ( phase );
        // Connect all subscribers to monitor
        agt.mtr.out_ap.connect ( sbd.AnalysisOut );
        // Connect all subscribers to driver
        agt.drv.in_ap.connect ( sbd.AnalysisIn );
    endfunction : connect_phase

endclass : BitWiseEnvironment
`endif // __BITWISEENVIRONMENT__SVH