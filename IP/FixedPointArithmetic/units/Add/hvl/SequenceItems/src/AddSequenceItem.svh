`ifndef __ADDSEQUENCEITEM__SVH
    `define __ADDSEQUENCEITEM__SVH
//---------------------------------------------------------------------------------------
// Sequence Items
//---------------------------------------------------------------------------------------
class AddSequenceItem extends uvm_sequence_item;
    typedef AddSequenceItem this_type_t;

    parameter N = 32;
    //-------------------------------------------------------------------------
    // Variables
    //-------------------------------------------------------------------------
    rand bit [N-1:0] a;
    rand bit [N-1:0] b;
    rand bit         ci;
    rand bit [N-1:0] c;
    rand bit         co;

    `uvm_object_utils_begin (AddSequenceItem)
        `uvm_field_int(a, UVM_ALL_ON);
        `uvm_field_int(b, UVM_ALL_ON);
        `uvm_field_int(ci, UVM_ALL_ON);
        `uvm_field_int(c, UVM_ALL_ON);
        `uvm_field_int(co, UVM_ALL_ON);
    `uvm_object_utils_end

    //-------------------------------------------------------------------------    
    //  Group: Constraints
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Functions
    //-------------------------------------------------------------------------    
    //  Constructor: new
    function new(string name = "AddSequenceItem");
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
    
endclass: AddSequenceItem
`endif // __ADDSEQUENCEITEM__SVH