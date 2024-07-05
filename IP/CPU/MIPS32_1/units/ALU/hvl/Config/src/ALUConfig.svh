`ifndef __ALUCONFIG__SVH
    `define __ALUCONFIG__SVH
//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     ALUConfig
// Description:     Configuration Object for ALU Test
//-------------------------------------------------------------------------------------------------
class ALUConfig extends uvm_object;
   typedef ALUConfig this_type_t;
    `uvm_object_utils(ALUConfig);

    //---------------------------------------------------------------------------------------------
    // Class Parametrs
    //---------------------------------------------------------------------------------------------   
    parameter string  DUT = "ALU";      // Name of DUT
    parameter integer N   = 32;         // Data path bit width   

    //---------------------------------------------------------------------------------------------
    // Class Attributes
    //---------------------------------------------------------------------------------------------
    typedef uvm_sequencer #(ALUSequenceItem)  ALUSequencer; //
    
    //---------------------------------------------------------------------------------------------
    // Class Methods
    //---------------------------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "ALUConfig");
        super.new(name);
    endfunction : new
 
 endclass : ALUConfig
`endif // __ALUCONFIG__SVH
