`ifndef __UNARYENVIRONMENT__SVH
    `define __UNARYENVIRONMENT__SVH
class UnaryEnvironment extends uvm_env;
    typedef UnaryEnvironment this_type_t;
    `uvm_component_utils (UnaryEnvironment);

    
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    UnaryAgent      agt;
    UnaryScoreboard sbd;
    UnaryConfig     cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------     
    function new ( string name = "UnaryEnvironment", uvm_component parent );
       super.new ( name, parent );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        agt = UnaryAgent::type_id::create ("agt", this );
        sbd = UnaryScoreboard::type_id::create ("sbd", this );
        if ( !uvm_config_db#(UnaryConfig)::get(this, "", "cfg", cfg ) )
            `uvm_fatal ("UnaryConfig", {"Configuration object must be set for ", get_full_name(), ".cfg" });
    endfunction : build_phase
 
    function void connect_phase ( uvm_phase phase );
        super.connect_phase ( phase );
        // Connect all subscribers to monitor
        agt.mtr.out_ap.connect ( sbd.AnalysisOut );
        // Connect all subscribers to driver
        agt.drv.in_ap.connect ( sbd.AnalysisIn );
    endfunction : connect_phase

endclass : UnaryEnvironment
`endif // __UNARYENVIRONMENT__SVH