//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  UVM Configuration object for BitWise logic designs.
// Module Name:  BitWiseConfig
// Dependencies: 
//-----------------------------------------------------------------------------
`ifndef __BITWISECONFIG__SVH
    `define __BITWISECONFIG__SVH
//-----------------------------------------------------------------------------
// Configuration Object
//-----------------------------------------------------------------------------
class BitWiseConfig extends uvm_object;
   typedef BitWiseConfig this_type_t;
    `uvm_object_utils(BitWiseConfig);
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    // We use the module_name to tell us what function we should use to compare
    // against the DUT.
    string  DUT = "unknown_module_name";
    // This is a fixed value. Probably need to make this better.
    integer N = 32;
    // We need an event so that we cna test combinational logic (no clock).
    uvm_event capture;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------    
    //  Constructor: new
    function new (string name = "BitWiseConfig" );
        super.new ( name );
        capture = new ( "capture" );
    endfunction : new
 
 endclass : BitWiseConfig
`endif // __BITWISECONFIG__SVH
