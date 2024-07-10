//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Module Name:     ALUTest
// Description:     UVM Test
//-----------------------------------------------------------------------------
`ifndef __ALUTEST__SVH
    `define __ALUTEST__SVH
class ALUTest extends uvm_test;
    typedef ALUTest this_type_t;
    `uvm_component_utils(ALUTest)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    ALUEnvironment alu_env;
    ALUConfig      alu_cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new(string name = "ALUTest", uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase(uvm_phase phase);
    begin
        super.build_phase(phase);
        
        alu_env = ALUEnvironment::type_id::create("alu_env", this);
        uvm_config_db#(ALUEnvironment)::set(.cntxt(this), .inst_name("alu_env" ), .field_name("alu_env"), .value(alu_env)); 

        if (!uvm_config_db#(ALUConfig)::get(this, "", "alu_cfg", alu_cfg))
            `uvm_fatal ("ALUTest", {"Configuration object must be set for ", get_full_name(), ".alu_cfg"});
    end
    endfunction : build_phase

    task run_phase ( uvm_phase phase );
    // Local Task variables.
    ALUSequence rseq; // Declare a handle to sequence.
    begin    
        phase.raise_objection(.obj(this));
 
        rseq = ALUSequence::type_id::create("rseq", this);

        rseq.start(alu_env.alu_agt.alu_sqr);
 
        phase.drop_objection(.obj(this));
    end
    endtask : run_phase

 endclass : ALUTest
`endif // __ALUTEST__SVH