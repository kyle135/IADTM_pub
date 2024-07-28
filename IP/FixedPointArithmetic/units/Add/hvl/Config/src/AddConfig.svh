`ifndef __ADDCONFIG__SVH
    `define __ADDCONFIG__SVH
class AddConfig extends uvm_object;
    typedef AddConfig this_type_t;
    `uvm_object_utils(AddConfig);

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
    function new (string name = "AddConfig");
        super.new(name);
        capture = new("capture");
    endfunction : new

endclass : AddConfig
`endif // __ADDCONFIG__SVH