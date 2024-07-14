//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`ifndef __LOGICALTEST__SVH
    `define __LOGICALTEST__SVH
class LogicalTest extends uvm_test;
    typedef LogicalTest this_type_t;
    `uvm_component_utils(LogicalTest)
    
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    LogicalEnvironment  env;
    LogicalConfig       cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new(string name = "LogicalTest", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
    begin
        super.build_phase(phase);
        
        env = LogicalEnvironment::type_id::create("env", this);
        uvm_config_db#(LogicalEnvironment)::set(
            .cntxt      ( this  ), 
            .inst_name  ( "env" ), 
            .field_name ( "env" ), 
            .value      ( env   )
        );

        if (!uvm_config_db#(LogicalConfig)::get(this, "", "cfg", cfg))
            `uvm_fatal ("LogicalTest", {"Configuration object must be set for ", get_full_name(), ".cfg"});
    end
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        LogicalSequence rseq;
        begin
            phase.raise_objection(.obj(this));

            rseq = LogicalSequence::type_id::create("rseq", this);
            rseq.start(env.agt.sqr);

            phase.drop_objection(.obj(this));
        end
    endtask : run_phase

endclass : LogicalTest
`endif // __LOGICALTEST__SVH