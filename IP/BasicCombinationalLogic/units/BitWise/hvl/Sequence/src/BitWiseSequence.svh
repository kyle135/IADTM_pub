//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  BitWiseSequence
// Module Name:  UVM Sequence for testing bitwise designs.
// Dependencies:
//-----------------------------------------------------------------------------
`ifndef __BITWISESEQUENCE__SVH
    `define __BITWISESEQUENCE__SVH
//----------------------------------------------------------------------------
// Sequence
//----------------------------------------------------------------------------
class BitWiseSequence extends uvm_sequence#(BitWiseSequenceItem);
    typedef BitWiseSequence this_type_t;
    `uvm_object_utils(BitWiseSequence)

    //-------------------------------------------------------------------------
    //  Class Attributes
    //-------------------------------------------------------------------------
    parameter N = 32;
    //-------------------------------------------------------------------------
    //  Class Methods
    //-------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "BitWiseSequence");
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
        BitWiseSequenceItem item;
        super.body();

        repeat(15) begin
            item = BitWiseSequenceItem::type_id::create("item");
            // if      (cfg.DUT == "BitWiseShiftRight") `uvm_do_with(item, {item.b<32;})
            // else if (cfg.DUT == "BitWiseShiftLeft")  `uvm_do_with(item, {item.b<32;})
            // else
            start_item(item);
            if (!item.randomize())
                `uvm_fatal("BitWiseSequence", "Randomization failure!!!")
            finish_item(item);
        end
        #100;
    endtask: body
 
    // //`uvm_do_with(req,{req.aaddr == {1'b1, 2'd0, 3'b001, 3'd0, 4'd0, addres, 3'd0}
    //     prev_aaddr = req.aaddr;
    //     `uvm_do_with(req,{req.aaddr == prev_aaddr;})
    // end


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

 endclass : BitWiseSequence
`endif // __BITWISESEQUENCE__SVH
