//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  BitWiseSequenceItem
// Module Name:  UVM Sequence item for testing bitwise designs.
// Dependencies:
//-----------------------------------------------------------------------------
`ifndef __BITWISESEQUENCEITEM__SVH
   `define __BITWISESEQUENCEITEM__SVH
class BitWiseSequenceItem extends uvm_sequence_item;
    parameter N = 32;
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    rand bit [N-1:0] a;
    rand bit [N-1:0] b;
    rand bit [N-1:0] c;
    typedef BitWiseSequenceItem this_type_t;
    `uvm_object_utils_begin (BitWiseSequenceItem)
        `uvm_field_int(a, UVM_ALL_ON);
        `uvm_field_int(b, UVM_ALL_ON);
        `uvm_field_int(c, UVM_ALL_ON);
    `uvm_object_utils_end

    //-------------------------------------------------------------------------    
    // Constraints
    //-------------------------------------------------------------------------
    
    // constraint b_c {b < 32;} // For Shift Operations
    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "BitWiseSequenceItem");
        super.new(name);
    endfunction: new

    //  Function: do_copy
    // extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    //  Function: convert2string
    // function string convert2string();
    //  Function: do_print
    // extern function void do_print(uvm_printer printer);
    //  Function: do_record
    // extern function void do_record(uvm_recorder recorder);
    //  Function: do_pack
    // extern function void do_pack();
    //  Function: do_unpack
    // extern function void do_unpack();

endclass : BitWiseSequenceItem
`endif // __BITWISESEQUENCEITEM__SVH