`ifndef __ADDTEST__SVH
    `define __ADDTEST__SVH
//-----------------------------------------------------------------------------
// Test
//-----------------------------------------------------------------------------
class AddTest extends uvm_test;
    typedef AddTest this_type_t;
    `uvm_component_utils (AddTest)
    
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    AddEnvironment  env;
    AddConfig       cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new (string name = "AddTest", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(AddConfig)::get(this, "", "cfg", cfg))
            `uvm_fatal ("AddTest", {"Configuration object must be set for ", get_full_name(), ".cfg"});
        
        env = AddEnvironment::type_id::create("env", this);
        uvm_config_db#(AddEnvironment)::set(.cntxt(this), .inst_name("env"), .field_name("env"), .value(env));
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        AddSequence rseq;
        begin
            phase.raise_objection(.obj(this));

            rseq = AddSequence::type_id::create("rseq", this);
            rseq.start(env.agt.sqr);

            phase.drop_objection(.obj(this));
        end
    endtask : run_phase

endclass : AddTest
`endif // __ADDTEST__SVH