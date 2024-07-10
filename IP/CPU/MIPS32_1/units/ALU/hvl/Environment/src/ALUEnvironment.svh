//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Module Name:     ALUEnvironment
// Description:     UVM Environment
//-----------------------------------------------------------------------------
`ifndef __ALUENVIRONMENT__SVH
    `define __ALUENVIRONMENT__SVH
class ALUEnvironment extends uvm_env;
    typedef  ALUEnvironment this_type_t;
    `uvm_component_utils(ALUEnvironment);
    
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    ALUAgent      alu_agt;
    ALUScoreBoard alu_sbd;
    ALUConfig     alu_cfg;
    ALUPredictor  alu_pre;

    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new(string name = "ALUEnvironment", uvm_component parent);
        super.new(name, parent);
     endfunction : new
 
    function void build_phase(uvm_phase phase);
    begin
        super.build_phase(phase);
        alu_agt = ALUAgent::type_id::create("alu_agt", this);
        alu_sbd = ALUScoreBoard::type_id::create("alu_sbd", this);
        alu_pre = ALUPredictor::type_id::create("alu_pre", this);

        uvm_config_db#(ALUAgent)::set(this, "", "alu_agt", alu_agt);
        uvm_config_db#(ALUScoreBoard)::set(this, "", "alu_sbd", alu_sbd);
        uvm_config_db#(ALUPredictor)::set(this, "", "alu_pre", alu_pre);

        if ( !uvm_config_db#(ALUConfig)::get(this, "", "alu_cfg", alu_cfg))
            `uvm_fatal(" ALUConfig", {"Configuration object must be set for ", get_full_name(), ".alu_cfg" });
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

        alu_agt.alu_mon.drv_ap.connect(alu_pre.analysis_export);
        // Connect Predictor
        alu_pre.expected_port.connect(alu_sbd.AnalysisIn);
        // Connect all subscribers to monitor
        alu_agt.alu_mon.mon_ap.connect(alu_sbd.AnalysisOut);
    end
    endfunction : connect_phase

endclass :  ALUEnvironment
`endif // __ALUENVIRONMENT__SVH

