`ifndef LOGICALSEQUENCEITEM__SVH
    `define LOGICALSEQUENCEITEM__SVH
//---------------------------------------------------------------------------------------
// Sequence Items
//---------------------------------------------------------------------------------------
class LogicalSequenceItem extends uvm_sequence_item;
    parameter N = 32;
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    rand bit [N-1:0] a;
    rand bit [N-1:0] b;
    rand bit         c;
    
    typedef LogicalSequenceItem this_type_t;
    `uvm_object_utils_begin (LogicalSequenceItem)
        `uvm_field_int(a, UVM_ALL_ON);
        `uvm_field_int(b, UVM_ALL_ON);
        `uvm_field_int(c, UVM_ALL_ON);
    `uvm_object_utils_end

    //-------------------------------------------------------------------------    
    // Constraints
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "LogicalSequenceItem");
        super.new(name);
    endfunction: new

    //  Function: do_copy
    // extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    //  Function: convert2string
    // extern function string convert2string();
    //  Function: do_print
    // extern function void do_print(uvm_printer printer);
    //  Function: do_record
    // extern function void do_record(uvm_recorder recorder);
    //  Function: do_pack
    // extern function void do_pack();
    //  Function: do_unpack
    // extern function void do_unpack();
    
endclass: LogicalSequenceItem
`endif // LOGICALSEQUENCEITEM_S_VH