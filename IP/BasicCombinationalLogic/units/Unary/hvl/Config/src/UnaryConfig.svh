`ifndef __UNARYCONFIG__SVH
    `define __UNARYCONFIG__SVH
class UnaryConfig extends uvm_object;
    typedef UnaryConfig this_type_t;
    `uvm_object_utils(UnaryConfig);

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    // We use the module_name to tell us what function we should use to compare
    // against the DUT.
    string    DUT = "unknown_module_name";
    // This is a fixed value. Probably need to make this better.
    integer   N = 32;
    // We need an event so that we cna test combinational logic (no clock).
    uvm_event capture;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    //  Constructor: new
    function new (string name = "UnaryConfig");
        super.new(name);
        capture = new("capture");
    endfunction : new

endclass : UnaryConfig
`endif // __UNARYCONFIG__SVH