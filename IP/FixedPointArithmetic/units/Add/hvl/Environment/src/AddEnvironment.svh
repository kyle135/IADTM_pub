`ifndef __ADDENVIRONMENT__SVH
    `define __ADDENVIRONMENT__SVH
class AddEnvironment extends uvm_env;
    typedef AddEnvironment this_type_t;
    `uvm_component_utils (AddEnvironment);

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    AddAgent      agt;
    AddScoreboard sbd;
    AddConfig     cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------     
    function new ( string name = "AddEnvironment", uvm_component parent );
       super.new ( name, parent );
    endfunction : new
 
    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
        agt = AddAgent::type_id::create ("agt", this );
        sbd = AddScoreboard::type_id::create ("sbd", this );
        if ( !uvm_config_db#(AddConfig)::get(this, "", "cfg", cfg ) )
            `uvm_fatal ("AddConfig", {"Configuration object must be set for ", get_full_name(), ".cfg" });
    endfunction : build_phase
 
    function void connect_phase ( uvm_phase phase );
        super.connect_phase ( phase );
        // Connect all subscribers to monitor
        agt.mtr.out_ap.connect ( sbd.AnalysisOut );
        // Connect all subscribers to driver
        agt.drv.in_ap.connect ( sbd.AnalysisIn );
    endfunction : connect_phase

endclass : AddEnvironment
`endif // __ADDNVIRONMENT__SVH