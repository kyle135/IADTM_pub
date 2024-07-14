//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Sequence Items
//-----------------------------------------------------------------------------
`ifndef LOGICALSEQUENCEITEM__SVH
    `define LOGICALSEQUENCEITEM__SVH
class LogicalSequenceItem extends uvm_sequence_item;
    typedef LogicalSequenceItem this_type_t;
    
    //-------------------------------------------------------------------------
    // Parameter(s)
    //-------------------------------------------------------------------------
    parameter N = 32;

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    rand logic [N-1:0] a;
    rand logic [N-1:0] b;
    rand logic         c;
        
    `uvm_object_utils(LogicalSequenceItem)


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