//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  BitWiseScoreboard
// Module Name:  UVM Scoreboard for testing bitwise designs.
// Dependencies:
//-----------------------------------------------------------------------------
`ifndef __BITWISESCOREBOARD__SVH
    `define __BITWISESCOREBOARD__SVH
`uvm_analysis_imp_decl ( _monitor )
`uvm_analysis_imp_decl ( _driver )
class BitWiseScoreboard extends uvm_scoreboard;
    typedef BitWiseScoreboard this_type_t;
    `uvm_component_utils(BitWiseScoreboard)

    parameter N = 32;
    parameter O = $clog2(N);
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    uvm_analysis_imp_monitor #(BitWiseSequenceItem, BitWiseScoreboard) AnalysisOut;
    uvm_analysis_imp_driver #(BitWiseSequenceItem, BitWiseScoreboard) AnalysisIn;
    BitWiseSequenceItem seq_item_queue[$];
    BitWiseConfig       cfg;

    logic [N-1:0] a;
    logic [N-1:0] b;
    logic [N-1:0] c;

    covergroup a_b_c_cg;
	    cp_a : coverpoint a;
	    cp_b : coverpoint b;
	    cp_c : coverpoint c;
	    a_b: cross cp_a, cp_b;
    endgroup : a_b_c_cg;

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    function new ( string name, uvm_component parent );
        super.new ( name, parent );
        // Creating analysis port
        AnalysisOut = new ("AnalysisOut", this );
        AnalysisIn = new ("AnalysisIn", this );
        // Create cover group
        a_b_c_cg = new ( );
    endfunction : new

    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
      
        if (!uvm_config_db#(BitWiseConfig)::get(this, "", "cfg", cfg))
            `uvm_fatal ("BitWiseScoreboard", {"Configuration object must be set for ", get_full_name(), ".cfg" });
    endfunction : build_phase

    function void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
    endfunction : connect_phase

  	virtual function void write_driver (input BitWiseSequenceItem input_item);
		seq_item_queue.push_front (input_item);
   	endfunction : write_driver

    virtual function void write_monitor ( input BitWiseSequenceItem output_item);
        BitWiseSequenceItem input_item;
        bit [N-1:0] BitWiseAND_expect;
        bit [N-1:0] BitWiseNAND_expect;
        bit [N-1:0] BitWiseOR_expect;
        bit [N-1:0] BitWiseNOR_expect;
        bit [N-1:0] BitWiseXNOR_expect;
        bit [N-1:0] BitWiseXOR_expect;
        bit [N-1:0] BitWiseNOT_expect;
        bit [N-1:0] BitWiseShiftLeft_expect;
        bit [N-1:0] BitWiseShiftRight_expect;
        begin
            input_item = seq_item_queue.pop_back ( );

            a = input_item.a;
            b = input_item.b;
            c = output_item.c;
            a_b_c_cg.sample ( );

            BitWiseAND_expect       =  (input_item.a  & input_item.b);
            BitWiseNAND_expect      = ~(input_item.a  & input_item.b);
            BitWiseOR_expect        =  (input_item.a  | input_item.b);
            BitWiseNOR_expect       = ~(input_item.a  | input_item.b);
            BitWiseXNOR_expect      = ~(input_item.a  ^ input_item.b);
            BitWiseXOR_expect       =  (input_item.a  ^ input_item.b);
            BitWiseNOT_expect       = ~(input_item.a               );
            BitWiseShiftLeft_expect =  (input_item.a << input_item.b[O-1:0]);
            BitWiseShiftRight_expect=  (input_item.a >> input_item.b[O-1:0]);

            if      ((cfg.DUT == "BitWiseAND")       && (output_item.c !== BitWiseAND_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a, input_item.b,        output_item.c, BitWiseAND_expect,        cfg.DUT))
            else if ((cfg.DUT == "BitWiseNAND")      && (output_item.c !== BitWiseNAND_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a, input_item.b,        output_item.c, BitWiseNAND_expect,       cfg.DUT))
            else if ((cfg.DUT == "BitWiseOR")        && (output_item.c !== BitWiseOR_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a, input_item.b,        output_item.c, BitWiseOR_expect,         cfg.DUT))
            else if ((cfg.DUT == "BitWiseNOR")       && (output_item.c !== BitWiseNOR_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a, input_item.b,        output_item.c, BitWiseNOR_expect,        cfg.DUT))
            else if ((cfg.DUT == "BitWiseXNOR")      && (output_item.c !== BitWiseXNOR_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a, input_item.b,        output_item.c, BitWiseXNOR_expect,       cfg.DUT))    
            else if ((cfg.DUT == "BitWiseXOR")       && (output_item.c !== BitWiseXOR_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a, input_item.b,        output_item.c, BitWiseXOR_expect,        cfg.DUT))
            else if ((cfg.DUT == "BitWiseNOT")       && (output_item.c !== BitWiseNOT_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x            [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a,                      output_item.c, BitWiseNOT_expect,        cfg.DUT))
            else if ((cfg.DUT == "BitWiseShiftLeft")  && (output_item.c !== BitWiseShiftLeft_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%01x [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a, input_item.b[O-1:0], output_item.c, BitWiseShiftLeft_expect,  cfg.DUT))
            else if ((cfg.DUT == "BitWiseShiftRight") && (output_item.c !== BitWiseShiftRight_expect))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%01x [CAct]=0x%08x [CExp]=0x%08x [%s]", input_item.a, input_item.b[O-1:0], output_item.c, BitWiseShiftRight_expect, cfg.DUT))
            else
                `uvm_info("RESULT",  $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [CAct]=0x%08x         [%s]", input_item.a, input_item.b,        output_item.c,                           cfg.DUT), UVM_INFO)
        end
    endfunction : write_monitor

    virtual function void report ( );
        uvm_report_info(get_type_name(), $psprintf("Scoreboard Report %s", this.sprint()), UVM_LOW);
    endfunction : report

endclass : BitWiseScoreboard
`endif // __BITWISESCOREBOARD__SVH
