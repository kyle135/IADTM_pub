`ifndef __ADDSCOREBOARD__SVH
   `define __ADDSCOREBOARD__SVH
//---------------------------------------------------------------------------------------
// Scoreboard
//---------------------------------------------------------------------------------------
`uvm_analysis_imp_decl(_monitor)
`uvm_analysis_imp_decl(_driver)
class AddScoreboard extends uvm_scoreboard;
    typedef AddScoreboard this_type_t;
    `uvm_component_utils(AddScoreboard)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    uvm_analysis_imp_monitor #(AddSequenceItem, AddScoreboard) AnalysisOut;
    uvm_analysis_imp_driver #(AddSequenceItem, AddScoreboard) AnalysisIn;
    AddSequenceItem seq_item_queue[$];
    AddConfig       cfg;
    
    logic [31:0] a;
    logic [31:0] b;
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
      
        if (!uvm_config_db#(AddConfig)::get(this, "", "cfg", cfg))
            `uvm_fatal ("AddScoreboard", {"Configuration object must be set for ", get_full_name(), ".cfg" });
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

  	virtual function void write_driver (input AddSequenceItem input_item);
		seq_item_queue.push_front (input_item);
    endfunction : write_driver

    virtual function void write_monitor(input AddSequenceItem output_item);
        // Local Variables
        AddSequenceItem input_item;
        bit           pass;
        begin
            input_item = seq_item_queue.pop_back();

            a = input_item.a;
            c = output_item.c;
            a_b_c_cg.sample ( );

            if      ((cfg.DUT == "Add")  && ({output_item.co, output_item.c} ==  (input_item.a + input_item.b + input_item.ci)))
                `uvm_info ("RESULT", $psprintf("write_monitor: PASSED [a]=0x%08x [b]=0x%08x [ci]=0x%01x [c]=0x%08x [co]=0x%01x [%s]", input_item.a, input_item.b,  input_item.ci, output_item.c,input_item.co, cfg.DUT), UVM_LOW)   
            else
                `uvm_error("RESULT", $psprintf("write_monitor: FAILED [a]=0x%08x [b]=0x%08x [ci]=0x%01x [c]=0x%08x [co]=0x%01x [%s]", input_item.a, input_item.b,  input_item.ci, output_item.c,input_item.co, cfg.DUT))

        end
    endfunction : write_monitor

   virtual function void report ( );
      uvm_report_info(get_type_name(), $psprintf("Scoreboard Report %s", this.sprint()), UVM_LOW);
   endfunction : report

endclass : AddScoreboard
`endif // __ADDSCOREBOARD__SVH
