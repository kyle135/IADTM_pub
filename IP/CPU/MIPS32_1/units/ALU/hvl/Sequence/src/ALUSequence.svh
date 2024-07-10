//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Description: Sequence
//-----------------------------------------------------------------------------
`ifndef __ALUSEQUENCE__SVH
    `define __ALUSEQUENCE__SVH
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
class  ALUSequence extends uvm_sequence#(ALUSequenceItem);
    typedef  ALUSequence this_type_t;
    `uvm_object_utils( ALUSequence)

    //-------------------------------------------------------------------------
    //  Class Attributes
    //-------------------------------------------------------------------------
    parameter N = 32;
    //-------------------------------------------------------------------------
    //  Class Methods
    //-------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "ALUSequence");
       super.new(name);
    endfunction: new


    // Task: pre_start
    // This task is a user-definable callback that is called before the optional 
    // execution of <pre_body>.
    // extern virtual task pre_start();



    // Task: pre_body
    // This task is a user-definable callback that is called before the execution 
    // of <body> ~only~ when the sequence is started with <start>.
    // If <start> is called with ~call_pre_post~ set to 0, ~pre_body~ is not called.
    // extern virtual task pre_body();

    // Task: pre_do
    // This task is a user-definable callback task that is called ~on the parent 
    // sequence~, if any. The sequence has issued a wait_for_grant() call and after
    // the sequencer has selected this sequence, and before the item is randomized.
    //
    // Although pre_do is a task, consuming simulation cycles may result in unexpected
    // behavior on the driver.
    // extern virtual task pre_do(bit is_item);

    // Function: mid_do
    // This function is a user-definable callback function that is called after the 
    // sequence item has been randomized, and just before the item is sent to the 
    // driver.
    // extern virtual function void mid_do(uvm_sequence_item this_item);

    // Task: body
    // This is the user-defined task where the main sequence code resides.
    task body();
    // Local Variables for task.
    ALUSequenceItem item;
    begin
        super.body();
        
        item =  ALUSequenceItem::type_id::create("item"); // Construct the sequence item.
        // Addition Signed
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADD_OP;  Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADD_FUNC;  GPR_a == 32'h0000_0000; GPR_b == 32'h0000_0000;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADD_OP;  Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADD_FUNC;  GPR_a == 32'h0000_0000; GPR_b == 32'hFFFF_FFFF;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADD_OP;  Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADD_FUNC;  GPR_a == 32'hFFFF_FFFF; GPR_b == 32'hFFFF_FFFF;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADD_OP;  Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADD_FUNC;  GPR_a == 32'hFFFF_FFFF; GPR_b == 32'h0000_0000;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADD_OP;  Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADD_FUNC;  GPR_a == 32'h0F0F_0F0F; GPR_b == 32'hF0F0_F0F0;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADD_OP;  Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADD_FUNC;  GPR_a == 32'hDEAD_BEEF; GPR_b == 32'hFEED_CAFE;})
        
        // Addition Unsigned
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADDU_OP; Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADDU_FUNC; GPR_a == 32'h0000_0000; GPR_b == 32'h0000_0000;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADDU_OP; Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADDU_FUNC; GPR_a == 32'h0000_0000; GPR_b == 32'hFFFF_FFFF;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADDU_OP; Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADDU_FUNC; GPR_a == 32'hFFFF_FFFF; GPR_b == 32'hFFFF_FFFF;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADDU_OP; Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADDU_FUNC; GPR_a == 32'hFFFF_FFFF; GPR_b == 32'h0000_0000;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADDU_OP; Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADDU_FUNC; GPR_a == 32'h0F0F_0F0F; GPR_b == 32'hF0F0_F0F0;})
        `uvm_do_with(item, {Instruction.r_instruction.instruction_fields.OpCode == ADDU_OP; Instruction.r_instruction.instruction_fields.RegisterAddress_A < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_B < 32; Instruction.r_instruction.instruction_fields.RegisterAddress_C < 32; Instruction.r_instruction.instruction_fields.Reserved == 0; Instruction.r_instruction.instruction_fields.FuncCode == ADDU_FUNC; GPR_a == 32'hDEAD_BEEF; GPR_b == 32'hFEED_CAFE;})
        // Subtraction Signed
        `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'h0000_0000}; GPR_b == {32'h0000_0000};})
        `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'h0000_0000}; GPR_b == {32'hFFFF_FFFF};})
        `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'hFFFF_FFFF}; GPR_b == {32'hFFFF_FFFF};})
        `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'hFFFF_FFFF}; GPR_b == {32'h0000_0000};})
        `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'h0F0F_0F0F}; GPR_b == {32'hF0F0_F0F0};})
        `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'hDEAD_BEEF}; GPR_b == {32'hFEED_CAFE};})
        // // Subtraction Unsigned
        // `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'h0000_0000}; GPR_b == {32'h0000_0000};})
        // `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'h0000_0000}; GPR_b == {32'hFFFF_FFFF};})
        // `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'hFFFF_FFFF}; GPR_b == {32'hFFFF_FFFF};})
        // `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'hFFFF_FFFF}; GPR_b == {32'h0000_0000};})
        // `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'h0F0F_0F0F}; GPR_b == {32'hF0F0_F0F0};})
        // `uvm_do_with(item, {Instruction == {SUB_OP,  20'h0, SUB_FUNC};  GPR_a == {32'hDEAD_BEEF}; GPR_b == {32'hFEED_CAFE};})        
        // // Multiplication
        // `uvm_do_with(item, {Instruction == {MULT_OP, 20'h0, MULT_FUNC}; GPR_a == {32'h0000_0000}; GPR_b == {32'h0000_0000};})
        // `uvm_do_with(item, {Instruction == {MULT_OP, 20'h0, MULT_FUNC}; GPR_a == {32'hFFFF_FFFF}; GPR_b == {32'h0000_0000};})
        // `uvm_do_with(item, {Instruction == {MULT_OP, 20'h0, MULT_FUNC}; GPR_a == {32'h0000_0000}; GPR_b == {32'hFFFF_FFFF};})
        // `uvm_do_with(item, {Instruction == {MULT_OP, 20'h0, MULT_FUNC}; GPR_a == {32'hFFFF_FFFF}; GPR_b == {32'hFFFF_FFFF};})
        // `uvm_do_with(item, {Instruction == {MULT_OP, 20'h0, MULT_FUNC}; GPR_a == {32'h0000_FF0F}; GPR_b == {32'h0000_0032};})
        // `uvm_do_with(item, {Instruction == {MULT_OP, 20'h0, MULT_FUNC}; GPR_a == {32'h0000_BEEF}; GPR_b == {32'h0000_2340};})
        // // Division
        // `uvm_do_with(item, {Instruction == {DIV_OP,  20'h0, DIV_FUNC};  GPR_a == {32'h0000_BEEF}; GPR_b == {32'h0000_2340};})
        // `uvm_do_with(item, {Instruction == {DIV_OP,  20'h0, DIV_FUNC};  GPR_a == {32'h0000_0000}; GPR_b == {32'h0000_0000};})
        // `uvm_do_with(item, {Instruction == {DIV_OP,  20'h0, DIV_FUNC};  GPR_a == {32'hFFFF_FFFF}; GPR_b == {32'h0000_0000};})
        // `uvm_do_with(item, {Instruction == {DIV_OP,  20'h0, DIV_FUNC};  GPR_a == {32'h0000_0000}; GPR_b == {32'hFFFF_FFFF};})
        // `uvm_do_with(item, {Instruction == {DIV_OP,  20'h0, DIV_FUNC};  GPR_a == {32'hFFFF_FFFF}; GPR_b == {32'hFFFF_FFFF};})
        // `uvm_do_with(item, {Instruction == {DIV_OP,  20'h0, DIV_FUNC};  GPR_a == {32'h0000_0064}; GPR_b == {32'h0000_0005};})
        // `uvm_do_with(item, {Instruction == {DIV_OP,  20'h0, DIV_FUNC};  GPR_a == {32'h0000_03E8}; GPR_b == {32'h0000_000A};})
                    
        // repeat(15) begin    
        //     start_item(item);
        //     if (!item.randomize())
        //         `uvm_fatal(" ALUSequence", "Randomization failure!!!")
        //     finish_item(item);
        // end
    end
    endtask: body
 
    // Function: post_do
    // This function is a user-definable callback function that is called after the 
    // driver has indicated that it has completed the item, using either this 
    // item_done or put methods. 
    // extern virtual function void post_do(uvm_sequence_item this_item);

    // Task: post_body
    // This task is a user-definable callback task that is called after the execution 
    // of <body> ~only~ when the sequence is started with <start>.
    // If <start> is called with ~call_pre_post~ set to 0, ~post_body~ is not called.
    // extern virtual task post_body();

    // Task: post_start
    // This task is a user-definable callback that is called after the optional 
    // execution of <post_body>.
    // extern virtual task post_start();

 endclass :  ALUSequence
`endif // __ALUSEQUENCE__SVH
