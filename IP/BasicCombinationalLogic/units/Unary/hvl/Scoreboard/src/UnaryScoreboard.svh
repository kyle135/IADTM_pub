`ifndef __UNARYSCOREBOARD__SVH
   `define __UNARYSCOREBOARD__SVH
//---------------------------------------------------------------------------------------
// Scoreboard
//---------------------------------------------------------------------------------------
`uvm_analysis_imp_decl(_monitor)
`uvm_analysis_imp_decl(_driver)
class UnaryScoreboard extends uvm_scoreboard;
    typedef UnaryScoreboard this_type_t;
    `uvm_component_utils(UnaryScoreboard)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    uvm_analysis_imp_monitor #(UnarySequenceItem, UnaryScoreboard) AnalysisOut;
    uvm_analysis_imp_driver #(UnarySequenceItem, UnaryScoreboard) AnalysisIn;
    UnarySequenceItem seq_item_queue[$];
    UnaryConfig       cfg;
    
    logic [31:0] a;
    logic        c;    

    covergroup a_c_cg;
	    cp_a : coverpoint a;
	    cp_c : coverpoint c;
    endgroup : a_c_cg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------    
    function new ( string name, uvm_component parent );
        super.new ( name, parent );
        // Creating analysis port
        AnalysisOut = new ("AnalysisOut", this );
        AnalysisIn = new ("AnalysisIn", this );
        // Create cover group
        a_c_cg = new ( );
    endfunction : new

    function void build_phase ( uvm_phase phase );
        super.build_phase ( phase );
      
        if (!uvm_config_db#(UnaryConfig)::get(this, "", "cfg", cfg))
            `uvm_fatal ("UnaryScoreboard", {"Configuration object must be set for ", get_full_name(), ".cfg" });
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

  	virtual function void write_driver (input UnarySequenceItem input_item);
		seq_item_queue.push_front (input_item);
    endfunction : write_driver

    virtual function void write_monitor(input UnarySequenceItem output_item);
        // Local Variables
        UnarySequenceItem input_item;
        bit           pass;
        begin
            input_item = seq_item_queue.pop_back();

            a = input_item.a;
            c = output_item.c;
            a_c_cg.sample ( );

            if      ((cfg.DUT == "UnaryAND")  && (output_item.c !==  (&input_item.a)))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]",  input_item.a, output_item.c,  (&input_item.a), cfg.DUT))
            else if ((cfg.DUT == "UnaryNAND") && (output_item.c !== ~(&input_item.a)))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]",  input_item.a, output_item.c, ~(&input_item.a), cfg.DUT))
            else if ((cfg.DUT == "UnaryNOR")  && (output_item.c !== ~(|input_item.a)))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]",  input_item.a, output_item.c, ~(|input_item.a), cfg.DUT))
            else if ((cfg.DUT == "UnaryNXOR") && (output_item.c !== ^(~input_item.a)))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]",  input_item.a, output_item.c, ^(~input_item.a), cfg.DUT))
            else if ((cfg.DUT == "UnaryOR")   && (output_item.c !==  (|input_item.a)))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]",  input_item.a, output_item.c,  (|input_item.a), cfg.DUT))
            else if ((cfg.DUT == "UnaryXNOR") && (output_item.c !== ~(^input_item.a)))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]",  input_item.a, output_item.c, ~(^input_item.a), cfg.DUT))
            else if ((cfg.DUT == "UnaryXOR")  && (output_item.c !==  (^input_item.a)))
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [A]=0x%08x [CAct]=0x%08x [CExp]=0x%08x [%s]",  input_item.a, output_item.c,  (^input_item.a), cfg.DUT))
        end
    endfunction : write_monitor

   virtual function void report ( );
      uvm_report_info(get_type_name(), $psprintf("Scoreboard Report %s", this.sprint()), UVM_LOW);
   endfunction : report

endclass : UnaryScoreboard
`endif // __UNARYSCOREBOARD__SVH
