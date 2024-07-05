//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf
// Module Name: APBEnvironment
// Description: UVM Environment
//-----------------------------------------------------------------------------
`ifndef __APBENVIRONMENT__SVH
    `define __APBENVIRONMENT__SVH
class APBEnvironment extends uvm_env;
    typedef  APBEnvironment this_type_t;
    `uvm_component_utils(APBEnvironment);
    
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    APBAgent      apb_agt;
    APBScoreBoard apb_sbd;
    APBConfig     apb_cfg;
    APBPredictor  apb_pre;

    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new(string name = "APBEnvironment", uvm_component parent);
        super.new(name, parent);
     endfunction : new
 
    function void build_phase(uvm_phase phase);
    begin
        super.build_phase(phase);
        apb_agt = APBAgent::type_id::create("apb_agt", this);
        apb_sbd = APBScoreBoard::type_id::create("apb_sbd", this);
        apb_pre = APBPredictor::type_id::create("apb_pre", this);

        uvm_config_db#(APBAgent)::set(this, "", "apb_agt", apb_agt);
        uvm_config_db#(APBScoreBoard)::set(this, "", "apb_sbd", apb_sbd);
        uvm_config_db#(APBPredictor)::set(this, "", "apb_pre", apb_pre);

        if ( !uvm_config_db#(APBConfig)::get(this, "", "apb_cfg", apb_cfg))
            `uvm_fatal(" APBConfig", {"Configuration object must be set for ", get_full_name(), ".apb_cfg" });
    end
    endfunction : build_phase
 
    function void connect_phase(uvm_phase phase);
    //-------------------------------------------------------------
    // .---------.       .-----------.       .------------.
    // | Monitor |       | Predictor |       | Scoreboard |
    // |         |<>--->O|           |<>--->O|            |O<-----
    // '---------'       '-----------'       '------------'
    //
    begin
        super.connect_phase(phase);

        apb_agt.apb_mon.drv_ap.connect(apb_pre.analysis_export);
        // Connect Predictor
        apb_pre.expected_port.connect(apb_sbd.AnalysisIn);
        // Connect all subscribers to monitor
        apb_agt.apb_mon.mon_ap.connect(apb_sbd.AnalysisOut);
    end
    endfunction : connect_phase

endclass :  APBEnvironment
`endif // __APBENVIRONMENT__SVH

