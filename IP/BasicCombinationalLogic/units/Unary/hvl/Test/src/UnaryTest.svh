`ifndef __UNARYTEST__SVH
    `define __UNARYTEST__SVH
//-----------------------------------------------------------------------------
// Test
//-----------------------------------------------------------------------------
class UnaryTest extends uvm_test;
    typedef UnaryTest this_type_t;
    `uvm_component_utils (UnaryTest)
    
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    UnaryEnvironment  env;
    UnaryConfig       cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new (string name = "UnaryTest", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(UnaryConfig)::get(this, "", "cfg", cfg))
            `uvm_fatal ("UnaryTest", {"Configuration object must be set for ", get_full_name(), ".cfg"});
        
        env = UnaryEnvironment::type_id::create("env", this);
        uvm_config_db#(UnaryEnvironment)::set(.cntxt(this), .inst_name("env"), .field_name("env"), .value(env));
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        UnarySequence rseq;
        begin
            phase.raise_objection(.obj(this));

            rseq = UnarySequence::type_id::create("rseq", this);
            rseq.start(env.agt.sqr);

            phase.drop_objection(.obj(this));
        end
    endtask : run_phase

endclass : UnaryTest
`endif // __UNARYTEST__SVH