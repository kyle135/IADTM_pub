//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Module Name:  APBSequenceItem
// Description:  UVM Sequence ITem for the APB UVM Agent.
// Dependencies:   
//-----------------------------------------------------------------------------
`ifndef __APBSEQUENCEITEM__SVH
   `define __APBSEQUENCEITEM__SVH
class  APBSequenceItem extends uvm_sequence_item;
    typedef APBSequenceItem this_type_t;
    
    //-------------------------------------------------------------------------
    // Class Parameters
    //-------------------------------------------------------------------------
    parameter integer N  =  32;     // Data path width in bits.
    parameter integer BW =   8;     // Byte width in bits
    parameter integer B  = N/8;     // Number of byte select lanes.
    parameter integer S  =   4;     // Number of slaves;
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    
    rand apb_select_t [S-1:0] PSEL;
    rand logic        [B-1:0] PSTRB;
    rand apb_direction_t      PWRITE;
    rand apb_protection_t     PPROT;
    rand logic        [N-1:0] PRDATA;
    rand logic        [N-1:0] PWDATA;
    rand apb_error_t          PSLVERR;
    
    `uvm_object_utils(APBSequenceItem)

    // `uvm_object_utils_begin(APBSequenceItem)
    //     `uvm_field_enum(apb_select_t,       PSEL,    UVM_ALL_ON)
    //     `uvm_field_int(                     PSTRB,   UVM_ALL_ON)
    //     `uvm_field_enum(apb_direction_t,    PWRITE,  UVM_ALL_ON)
    //     `uvm_field_int(                     PPROT,   UVM_ALL_ON)
    //     `uvm_field_int(                     PRDATA,  UVM_ALL_ON)
    //     `uvm_field_int(                     PWDATA,  UVM_ALL_ON)
    //     `uvm_field_enum(apb_error_t,        PSLVERR, UVM_ALL_ON)
    // `uvm_object_utils_end

    //-------------------------------------------------------------------------
    // Constraints
    //-------------------------------------------------------------------------
    
    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    // Constructor
    function new(string name = "APBSequenceItem");
        super.new(name);
    endfunction: new

    //-------------------------------------------------------------------------
    // UVM Utility Functions                                            
    //-------------------------------------------------------------------------
    // Always implement do_compare(), do_copy(), do_print(), do_pack(), do_unpack(), do_record() 
    // and convert2string()

    // Description: The do_copy() method is used to copy all the properties of a APBSequenceItem object.
    virtual function void do_copy(uvm_object rhs);
    //-------------------------------------------------------------------------
    // Local Function Variables
    APBSequenceItem item;
    begin
        if(!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument")
        super.do_copy(rhs);

        this.PSEL    = item.PSEL;
        this.PSTRB   = item.PSTRB;
        this.PWRITE  = item.PWRITE;
        this.PPROT   = item.PPROT;
        this.PRDATA  = item.PRDATA;
        this.PWDATA  = item.PWDATA;
        this.PSLVERR = item.PSLVERR;
    end
    endfunction : do_copy
    
    // Description: The do_compare() is used to compare each property of the APBSequenceItem 
    // object. The do_compare() returns 1 if the comparison succeeds, and returns 0 if the 
    // comparison fails.
    virtual function bit do_compare;
    input uvm_object   rhs;
    input uvm_comparer comparer;
    //-------------------------------------------------------------------------
    // Local Function Variables
    APBSequenceItem    item;
    begin
        do_compare = super.do_compare(rhs, comparer);
        if (!$cast(item,rhs)) begin
            `uvm_fatal("COMPARE", "$cast failed...")
            return FAILURE;
        end
        else begin
            do_compare &= comparer.compare_field_int("PSEL",    this.PSEL,    item.PSEL,    S);
            do_compare &= comparer.compare_field_int("PSTRB",   this.PSTRB,   item.PSTRB,   B);
            do_compare &= comparer.compare_field_int("PWRITE",  this.PWRITE,  item.PWRITE,  1);
            do_compare &= comparer.compare_field_int("PPROT",   this.PPROT,   item.PPROT,   3);            
            do_compare &= comparer.compare_field_int("PRDATA",  this.PRDATA,  item.PRDATA,  N);            
            do_compare &= comparer.compare_field_int("PWDATA",  this.PWDATA,  item.PWDATA,  N);
            do_compare &= comparer.compare_field_int("PSLVERR", this.PSLVERR, item.PSLVERR, 1);
        end
    end
    endfunction : do_compare

    virtual function string convert2string();
    //---------------------------------------------------------------------------------------------
    // Local Function Variables
    string returnString;
    begin
        returnString = super.convert2string(); // Start with base object.
        // returnString                 = {returnString, $psprintf("\n")};
        // returnString                 = {returnString, $psprintf("%s\n", get_full_name())};
        // returnString                 = {returnString, $psprintf(".--------------.-------------------.\n")};
        // returnString                 = {returnString, $psprintf("| Instruction  |  Program Counter  |\n")};
        // returnString                 = {returnString, $psprintf(".--------------+-------------------:\n")};
        // returnString                 = {returnString, $psprintf("|   %08x   |     %08x      |\n", this.Instruction, this.ProgramCounter)};
        // returnString                 = {returnString, $psprintf(":----------.---'-------.-----------:\n")};
        // returnString                 = {returnString, $psprintf("| Register |    Pre    |   Post    |\n")};
        // returnString                 = {returnString, $psprintf(":----------+-----------+-----------:\n")};

        return returnString;
    end
    endfunction : convert2string

    virtual function void do_pack(uvm_packer packer);
    begin
        super.do_pack(packer);
        packer.pack_field_int(PSEL,    S);
        packer.pack_field_int(PSTRB,   B);
        packer.pack_field_int(PWRITE,  1);
        packer.pack_field_int(PPROT,   3);
        packer.pack_field_int(PRDATA,  N);
        packer.pack_field_int(PWDATA,  N);
        packer.pack_field_int(PSLVERR, 1);        
    end
    endfunction : do_pack


    virtual function void do_unpack(uvm_packer packer);
    begin
        super.do_unpack(packer);
        PSEL    = apb_select_t'(packer.unpack_field_int(S));
        PSTRB   = packer.unpack_field_int(B);
        PWRITE  = apb_direction_t'(packer.unpack_field_int(1));
        PPROT   = apb_protection_t'(packer.unpack_field_int(3));
        PRDATA  = packer.unpack_field_int(N);
        PWDATA  = packer.unpack_field_int(N);
        PSLVERR = apb_error_t'(packer.unpack_field_int(1));
    end    
    endfunction : do_unpack

    // Description: do_record function is the user-definable hook called by the record function of
    // uvm_object which records the object properties
    virtual function void do_record(uvm_recorder recorder);
        super.do_record(recorder);
        `uvm_record_int("PSEL",    PSEL,    S, UVM_NORADIX)
        `uvm_record_int("PSTRB",   PSTRB,   B, UVM_NORADIX)
        `uvm_record_int("PWRITE",  PWRITE,  1, UVM_NORADIX)
        `uvm_record_int("PPROT",   PPROT,   3, UVM_NORADIX)
        `uvm_record_int("PRDATA",  PRDATA,  N, UVM_NORADIX)
        `uvm_record_int("PWDATA",  PWDATA,  N, UVM_NORADIX)
        `uvm_record_int("PSLVERR", PSLVERR, 1, UVM_NORADIX)
    endfunction : do_record

    // sprint() calls do_print() and returns the string.
    // print() calls do_print() and then prints with $display().
    virtual function void do_print(uvm_printer printer);
        printer.m_string = this.convert2string();
    endfunction : do_print

endclass :  APBSequenceItem
`endif // __APBSEQUENCEITEM__SVH