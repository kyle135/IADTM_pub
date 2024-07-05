//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module:          UVM ScoreBoard Class for ALU
//-------------------------------------------------------------------------------------------------
`ifndef __ALUSCOREBOARD__SVH
    `define __ALUSCOREBOARD__SVH
//-------------------------------------------------------------------------------------------------
// Scoreboard
//-------------------------------------------------------------------------------------------------
`uvm_analysis_imp_decl(_monitor)
`uvm_analysis_imp_decl(_driver)
class  ALUScoreBoard extends uvm_scoreboard;
    typedef  ALUScoreBoard this_type_t;
    `uvm_component_utils(ALUScoreBoard)

    parameter integer N = 32;
    parameter integer O = $clog2(N);
    //---------------------------------------------------------------------------------------------
    // Class Attributes
    //---------------------------------------------------------------------------------------------
    uvm_analysis_imp_monitor #(ALUSequenceItem, ALUScoreBoard) AnalysisOut;
    uvm_analysis_imp_driver  #(ALUSequenceItem, ALUScoreBoard) AnalysisIn;
    ALUSequenceItem seq_item_queue[$];
    ALUConfig       alu_cfg;
    uvm_packer      alu_pkr;
    //
    bit             m_bits[];
    int             m_number_of_bits;
    //---------------------------------------------------------------------------------------------
    // Coverage
    //---------------------------------------------------------------------------------------------
    // logic [N-1:0] Instruction;          // Encoded ALU Operation Commands from ALU Decoder
    // logic [N-1:0] ProgramCounter;       //
    // logic [N-1:0] GPR_a;                //
    // logic [N-1:0] GPR_b;                //
    // logic [N-1:0] GPR_c;                //
    // logic [N-1:0] SPR_h;                //
    // logic [N-1:0] SPR_l;                //
    // logic [N-1:0] GPR_a_dat;            // Register write back data for GPR a
    // logic         GPR_a_val;            // Register write back data of GPR a is valid.
    // logic [N-1:0] GPR_b_dat;            // Register write back data for GPR b
    // logic         GPR_b_val;            // Register write back data of GPR b is valid.
    // logic [N-1:0] GPR_c_dat;            // Register write back data for GPR c
    // logic         GPR_c_val;            // Register write back data of GPR c is valid.
    // logic [N-1:0] SPR_h_dat;            //
    // logic         SPR_h_val;            // Special Purpose Register H
    // logic [N-1:0] SPR_l_dat;            //
    // logic         SPR_l_val;            //
    // logic         SPR_o_val;            // OverFlow
    // logic         SPR_z_val;            // Zero    

    // covergroup Instruction_cg;
    //    coverpoint Instruction {
    //       wildcard bins OR  = { OR_OP,    5'b?????, 5'b?????, 5'b?????, 5'b00000, OR_FUNC    }; 
    //       wildcard bins XOR = { XOR_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, XOR_FUNC   };
    //       wildcard bins NOR = { NOR_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, NOR_FUNC   };
    //       wildcard bins SLT = { SLT_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, SLT_FUNC   };
    //    }
    // endgroup
    
    //---------------------------------------------------------------------------------------------
    // Class Attributes
    //---------------------------------------------------------------------------------------------
    function new(string name, uvm_component parent);
        super.new(name, parent);
        // Create cover groups
        // Instruction_cg = new ( );
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Creating analysis port
        AnalysisOut = new("AnalysisOut", this);
        AnalysisIn = new("AnalysisIn", this);

        if (!uvm_config_db#(ALUConfig)::get(this, "", "alu_cfg", alu_cfg))
            `uvm_fatal ("ALUScoreBoard", {"Configuration object must be set for ", get_full_name(), ".alu_cfg"});
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
    begin
        super.connect_phase(phase);
    end
    endfunction : connect_phase

    virtual function void write_driver(input ALUSequenceItem input_item);
        seq_item_queue.push_front(input_item);
   	endfunction : write_driver

    virtual function void write_monitor(input ALUSequenceItem output_item);
        ALUSequenceItem input_item;  //
        begin
            input_item = seq_item_queue.pop_back( );
            // We are going to create a single sequence item that represents the inputs and the 
            // outputs of the ALU. This will be used to compare against the C-Model.
            // Create a complete expected transaction.
            output_item.Instruction    = input_item.Instruction;
            output_item.ProgramCounter = input_item.ProgramCounter;
            output_item.GPR_a          = input_item.GPR_a;
            output_item.GPR_b          = input_item.GPR_b;
            output_item.GPR_c          = input_item.GPR_c;
            output_item.SPR_h          = input_item.SPR_h;
            output_item.SPR_l          = input_item.SPR_l;
            // Compare the two actual and expected transactions.
            if (output_item.compare(input_item)) begin
                // Never call using do_compare()
                `uvm_info(get_type_name(), $psprintf("PASSED"), UVM_LOW)
            end else begin
                `uvm_info("input_item", input_item.convert2string(), UVM_LOW)
                `uvm_info("output_item", output_item.convert2string(), UVM_LOW)
            end
        end
    endfunction : write_monitor

    virtual function void report ( );
        uvm_report_info(get_type_name(), $psprintf("Scoreboard Report %s", this.sprint()), UVM_LOW);
    endfunction : report

endclass : ALUScoreBoard
`endif // __ALUSCOREBOARD__SVH
