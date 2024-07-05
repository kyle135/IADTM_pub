`ifndef __UNARYSEQUENCEITEM__SVH
    `define __UNARYSEQUENCEITEM__SVH
//---------------------------------------------------------------------------------------
// Sequence Items
//---------------------------------------------------------------------------------------
class UnarySequenceItem extends uvm_sequence_item;
    typedef UnarySequenceItem this_type_t;

    parameter N = 32;
    //-------------------------------------------------------------------------
    // Variables
    //-------------------------------------------------------------------------
    rand bit [N-1:0] a;
    rand bit         c;

    `uvm_object_utils_begin (UnarySequenceItem)
        `uvm_field_int(a, UVM_ALL_ON);
        `uvm_field_int(c, UVM_ALL_ON);
    `uvm_object_utils_end

    //-------------------------------------------------------------------------    
    //  Group: Constraints
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Functions
    //-------------------------------------------------------------------------    
    //  Constructor: new
    function new(string name = "UnarySequenceItem");
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
    
endclass: UnarySequenceItem
`endif // __UNARYSEQUENCEITEM__SVH