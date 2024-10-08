`ifndef __LOGICALSCOREBOARD__SVH
   `define __LOGICALSCOREBOARD__SVH
//---------------------------------------------------------------------------------------
// Scoreboard
//---------------------------------------------------------------------------------------
`uvm_analysis_imp_decl(_monitor)
`uvm_analysis_imp_decl(_driver)
class LogicalScoreboard extends uvm_scoreboard;
    typedef LogicalScoreboard this_type_t;
    `uvm_component_utils(LogicalScoreboard)

    parameter N = 32;
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    uvm_analysis_imp_monitor #(LogicalSequenceItem, LogicalScoreboard) AnalysisOut;
    uvm_analysis_imp_driver #(LogicalSequenceItem, LogicalScoreboard) AnalysisIn;
    LogicalSequenceItem seq_item_queue[$];
    LogicalConfig       cfg;

    logic [N-1:0] a;
    logic [N-1:0] b;
    logic         c;    

    covergroup a_b_c_cg;
	    cp_a : coverpoint a;
	    cp_b : coverpoint b;
	    cp_c : coverpoint c;
	    a_b: cross cp_a, cp_b;
    endgroup : a_b_c_cg;

    //-------------------------------------------------------------------------
    // Class Methods
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
      
        if (!uvm_config_db#(LogicalConfig)::get(this, "", "cfg", cfg))
            `uvm_fatal ("LogicalScoreboard", {"Configuration object must be set for ", get_full_name(), ".cfg" });
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

  	virtual function void write_driver (input LogicalSequenceItem input_item);
		seq_item_queue.push_front (input_item);
    endfunction : write_driver

    virtual function void write_monitor(input LogicalSequenceItem output_item);
        // Local Variables
        LogicalSequenceItem input_item;
        bit           pass;
        begin
            input_item = seq_item_queue.pop_back();

            a = input_item.a;
            b = input_item.b;
            c = output_item.c;
            a_b_c_cg.sample ( );

            if      ((cfg.DUT == "LogicalAND")  && (output_item.c == (input_item.a && input_item.b)))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]",  input_item.a, input_item.b, output_item.c, cfg.DUT), UVM_LOW)
            else if ((cfg.DUT == "LogicalEQ")   && (output_item.c == (input_item.a == input_item.b)))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]",  input_item.a, input_item.b, output_item.c, cfg.DUT), UVM_LOW)
            else if ((cfg.DUT == "LogicalGT")   && (output_item.c == (input_item.a >  input_item.b)))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]",  input_item.a, input_item.b, output_item.c, cfg.DUT), UVM_LOW)
            else if ((cfg.DUT == "LogicalGTEQ") && (output_item.c == (input_item.a >= input_item.b)))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]",  input_item.a, input_item.b, output_item.c, cfg.DUT), UVM_LOW)
            else if ((cfg.DUT == "LogicalLT")   && (output_item.c == (input_item.a <  input_item.b)))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]",  input_item.a, input_item.b, output_item.c, cfg.DUT), UVM_LOW)
            else if ((cfg.DUT == "LogicalLTEQ") && (output_item.c == (input_item.a <= input_item.b)))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]",  input_item.a, input_item.b, output_item.c, cfg.DUT), UVM_LOW)    
            else if ((cfg.DUT == "LogicalNEQ")  && (output_item.c == (input_item.a != input_item.b)))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [C]=0x%08x [%s]",             input_item.a,               output_item.c, cfg.DUT), UVM_LOW)
            else if ((cfg.DUT == "LogicalNOT")  && (output_item.c == !(input_item.a               )))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]",  input_item.a, input_item.b, output_item.c, cfg.DUT), UVM_LOW)    
            else if ((cfg.DUT == "LogicalOR")   && (output_item.c == input_item.a || input_item.b))
                `uvm_info("RESULT", $psprintf("write_monitor: PASSED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]",  input_item.a, input_item.b, output_item.c, cfg.DUT), UVM_LOW)    
            else
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [B]=0x%08x [C]=0x%08x [%s]", input_item.a, input_item.b, output_item.c, cfg.DUT))
        end
    endfunction : write_monitor

   virtual function void report ( );
      uvm_report_info(get_type_name(), $psprintf("Scoreboard Report %s", this.sprint()), UVM_LOW);
   endfunction : report

endclass : LogicalScoreboard
`endif // __LOGICALSCOREBOARD__SVH
