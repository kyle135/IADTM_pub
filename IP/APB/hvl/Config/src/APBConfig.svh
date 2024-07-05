`ifndef __APBCONFIG__SVH
    `define __APBCONFIG__SVH
//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf
// Module Name: APBConfig
// Description: Configuration Object for APB Test
//-----------------------------------------------------------------------------
class APBConfig extends uvm_object;
   typedef APBConfig this_type_t;
    `uvm_object_utils(APBConfig);

    //-------------------------------------------------------------------------
    // Class Parametrs
    //-------------------------------------------------------------------------
    parameter string  DUT = "APB";      // Name of DUT
    parameter integer N   = 32;         // Data path bit width   

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "APBConfig");
        super.new(name);
    endfunction : new
 
 endclass : APBConfig
`endif // __APBCONFIG__SVH
