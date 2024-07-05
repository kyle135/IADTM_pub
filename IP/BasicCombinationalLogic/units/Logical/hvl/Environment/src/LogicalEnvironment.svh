`ifndef __LOGICALENVIRONMENT__SVH
    `define __LOGICALENVIRONMENT__SVH
//-----------------------------------------------------------------------------
// Environment
//-----------------------------------------------------------------------------
class LogicalEnvironment extends uvm_env;
    typedef LogicalEnvironment this_type_t;
    `uvm_component_utils (LogicalEnvironment);

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    LogicalAgent      agt;
    LogicalScoreboard sbd;
    LogicalConfig     cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new ( string name = "LogicalEnvironment", uvm_component parent );
       super.new ( name, parent );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        agt = LogicalAgent::type_id::create ("agt", this );
        sbd = LogicalScoreboard::type_id::create ("sbd", this );
        if ( !uvm_config_db#(LogicalConfig)::get(this, "", "cfg", cfg ) )
            `uvm_fatal ("LogicalConfig", {"Configuration object must be set for ", get_full_name(), ".cfg" });
    endfunction : build_phase
 
    function void connect_phase ( uvm_phase phase );
        super.connect_phase ( phase );
        // Connect all subscribers to monitor
        agt.mtr.out_ap.connect ( sbd.AnalysisOut );
        // Connect all subscribers to driver
        agt.drv.in_ap.connect ( sbd.AnalysisIn );
    endfunction : connect_phase

endclass : LogicalEnvironment
`endif // __LOGICALENVIRONMENT__SVH