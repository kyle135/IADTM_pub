//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  BitWiseTest
// Module Name:  UVM Test for testing bitwise designs.
// Dependencies:
//-----------------------------------------------------------------------------
`ifndef __BITWISETEST__SVH
    `define __BITWISETEST__SVH
class BitWiseTest extends uvm_test;
    typedef BitWiseTest this_type_t;
    `uvm_component_utils(BitWiseTest)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    BitWiseEnvironment env;
    BitWiseConfig      cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new(string name = "BitWiseTest", uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        env = BitWiseEnvironment::type_id::create("env", this);
        uvm_config_db#(BitWiseEnvironment)::set(.cntxt(this), .inst_name("env" ), .field_name( "env"), .value(env)); 

        if (!uvm_config_db#(BitWiseConfig)::get(this, "", "cfg", cfg))
            `uvm_fatal ("BitWiseTest", {"Configuration object must be set for ", get_full_name(), ".cfg"});
    endfunction : build_phase

    task run_phase ( uvm_phase phase );
        BitWiseSequence rseq;
 
        phase.raise_objection(.obj(this));
 
        rseq = BitWiseSequence::type_id::create("rseq", this);
        rseq.start(env.agt.sqr);
 
        phase.drop_objection(.obj(this));
    endtask : run_phase

 endclass : BitWiseTest
`endif // __BITWISETEST__SVH