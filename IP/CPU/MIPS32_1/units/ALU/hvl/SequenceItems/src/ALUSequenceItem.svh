//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     ALUSequenceItem
// Description:
// Dependencies:   
//------------------------------------------------------------------------------------------------- 
`ifndef __ALUSEQUENCEITEM__SVH
   `define __ALUSEQUENCEITEM__SVH
import MIPS32_1_hdl_pkg::*;
class  ALUSequenceItem extends uvm_sequence_item;
    typedef ALUSequenceItem this_type_t;
    
    //---------------------------------------------------------------------------------------------
    // Class Parameters
    //---------------------------------------------------------------------------------------------
    parameter integer N = 32;
    //---------------------------------------------------------------------------------------------
    // Class Attributes
    //---------------------------------------------------------------------------------------------
    

    typedef union packed {
        logic [N-1:0] Instruction;
        struct packed {
            logic [5:0] OpCode;
            logic [4:0] RegisterAddress_A;
            logic [4:0] RegisterAddress_B;
            logic [4:0] RegisterAddress_C;
            logic [4:0] Reserved;
            logic [5:0] FuncCode;
        } instruction_fields;
    } instruction_r_t;

    typedef union packed {
        logic [N-1:0] Instruction;
        struct packed {
            logic [ 5:0] OpCode;
            logic [ 4:0] RegisterAddress_A;
            logic [ 4:0] RegisterAddress_B;
            logic [15:0] Immediate;
        } instruction_fields;
    } instruction_i_t;

    typedef union packed {
        instruction_r_t r_instruction;
        instruction_i_t i_instruction;
    } instruction_t;

    rand instruction_t Instruction;          // Encoded ALU Operation Commands from ALU Decoder

    rand logic [N-1:0] ProgramCounter;       //
    rand logic [N-1:0] GPR_a;                //
    rand logic [N-1:0] GPR_b;                //
    rand logic [N-1:0] GPR_c;                //
    rand logic [N-1:0] SPR_h;                //
    rand logic [N-1:0] SPR_l;                //
    rand logic [N-1:0] GPR_a_dat;            // Register write back data for GPR a
    rand logic         GPR_a_val;            // Register write back data of GPR a is valid.
    rand logic [N-1:0] GPR_b_dat;            // Register write back data for GPR b
    rand logic         GPR_b_val;            // Register write back data of GPR b is valid.
    rand logic [N-1:0] GPR_c_dat;            // Register write back data for GPR c
    rand logic         GPR_c_val;            // Register write back data of GPR c is valid.
    rand logic [N-1:0] SPR_h_dat;            //
    rand logic         SPR_h_val;            // Special Purpose Register H
    rand logic [N-1:0] SPR_l_dat;            //
    rand logic         SPR_l_val;            //
    rand logic         SPR_o_val;            // OverFlow
    rand logic         SPR_z_val;            // Zero
    
    `uvm_object_utils_begin(ALUSequenceItem)
        `uvm_field_int(Instruction, UVM_ALL_ON)
        `uvm_field_int(ProgramCounter, UVM_ALL_ON)
        `uvm_field_int(GPR_a, UVM_ALL_ON)
        `uvm_field_int(GPR_b, UVM_ALL_ON)
        `uvm_field_int(GPR_c, UVM_ALL_ON)
        `uvm_field_int(SPR_h, UVM_ALL_ON)
        `uvm_field_int(SPR_l, UVM_ALL_ON)
        `uvm_field_int(GPR_a_dat, UVM_ALL_ON)
        `uvm_field_int(GPR_a_val, UVM_ALL_ON)
        `uvm_field_int(GPR_b_dat, UVM_ALL_ON)
        `uvm_field_int(GPR_b_val, UVM_ALL_ON)
        `uvm_field_int(GPR_c_dat, UVM_ALL_ON)
        `uvm_field_int(GPR_c_val, UVM_ALL_ON)
        `uvm_field_int(SPR_h_dat, UVM_ALL_ON)
        `uvm_field_int(SPR_h_val, UVM_ALL_ON)
        `uvm_field_int(SPR_l_dat, UVM_ALL_ON)
        `uvm_field_int(SPR_l_val, UVM_ALL_ON)
        `uvm_field_int(SPR_o_val, UVM_ALL_ON)
        `uvm_field_int(SPR_z_val, UVM_ALL_ON)
    `uvm_object_utils_end

    //---------------------------------------------------------------------------------------------
    // Constraints
    //---------------------------------------------------------------------------------------------
    
    // constraint b_c {b < 32;} // For Shift Operations
    //---------------------------------------------------------------------------------------------
    // Class Methods
    //---------------------------------------------------------------------------------------------
    // Constructor
    function new(string name = "ALUSequenceItem");
        super.new(name);
    endfunction: new

    //---------------------------------------------------------------------------------------------
    // UVM Utility Functions                                            
    //---------------------------------------------------------------------------------------------
    // Always implement do_compare(), do_copy(), do_print(), do_pack(), do_unpack(), do_record() 
    // and convert2string()

    // Description: The do_copy() method is used to copy all the properties of a ALUSequenceItem object.
    virtual function void do_copy(uvm_object rhs);
    //---------------------------------------------------------------------------------------------
    // Local Function Variables
    ALUSequenceItem item;
    begin
        if(!$cast(item, rhs))
            `uvm_fatal(get_type_name(), "Illegal rhs argument")
        super.do_copy(rhs);
        this.Instruction    = item.Instruction;
        this.ProgramCounter = item.ProgramCounter;
        this.GPR_a          = item.GPR_a;
        this.GPR_b          = item.GPR_b;
        this.GPR_c          = item.GPR_c;
        this.SPR_h          = item.SPR_h;
        this.SPR_l          = item.SPR_l;
        this.GPR_a_dat      = item.GPR_a_dat;
        this.GPR_a_val      = item.GPR_a_val;
        this.GPR_b_dat      = item.GPR_b_dat;
        this.GPR_b_val      = item.GPR_b_val;
        this.GPR_c_dat      = item.GPR_c_dat;
        this.GPR_c_val      = item.GPR_c_val;
        this.SPR_h_dat      = item.SPR_h_dat;
        this.SPR_h_val      = item.SPR_h_val;
        this.SPR_l_dat      = item.SPR_l_dat;
        this.SPR_l_val      = item.SPR_l_val;
        this.SPR_o_val      = item.SPR_o_val;
        this.SPR_z_val      = item.SPR_z_val;
    end
    endfunction : do_copy
    
    // Description: The do_compare() is used to compare each property of the ALUSequenceItem 
    // object. The do_compare() returns 1 if the comparison succeeds, and returns 0 if the 
    // comparison fails.
    virtual function bit do_compare;
    input uvm_object   rhs;
    input uvm_comparer comparer;
    //---------------------------------------------------------------------------------------------
    // Local Function Variables
    ALUSequenceItem    item;
    begin
        do_compare = super.do_compare(rhs, comparer);
        if (!$cast(item,rhs)) begin
            `uvm_fatal("COMPARE", "$cast failed...")
            return FAILURE;
        end
        else begin
            do_compare &= comparer.compare_field_int("GPR_a_dat", this.GPR_a_dat, item.GPR_a_dat, 33);
            do_compare &= comparer.compare_field_int("GPR_b_dat", this.GPR_b_dat, item.GPR_b_dat, 32);
            do_compare &= comparer.compare_field_int("GPR_c_dat", this.GPR_c_dat, item.GPR_c_dat, 32);            
            do_compare &= comparer.compare_field_int("SPR_h_dat", this.SPR_h_dat, item.SPR_h_dat, 32);            
            do_compare &= comparer.compare_field_int("SPR_l_dat", this.SPR_l_dat, item.SPR_l_dat, 32);
            do_compare &= comparer.compare_field_int("SPR_o_val", this.SPR_o_val, item.SPR_o_val,  1);
            do_compare &= comparer.compare_field_int("SPR_z_val", this.SPR_z_val, item.SPR_z_val,  1);                                    
        end
    end
    endfunction : do_compare

    virtual function string convert2string();
    //---------------------------------------------------------------------------------------------
    // Local Function Variables
    string returnString;
    begin
        returnString = super.convert2string(); // Start with base object.
        returnString                 = {returnString, $psprintf("\n")};
        returnString                 = {returnString, $psprintf("%s\n", get_full_name())};
        // returnString                 = {returnString, $psprintf("%s\n")}
        returnString                 = {returnString, $psprintf(".--------------.-------------------.\n")};
        returnString                 = {returnString, $psprintf("| Instruction  |  Program Counter  |\n")};
        returnString                 = {returnString, $psprintf(".--------------+-------------------:\n")};
        returnString                 = {returnString, $psprintf("|   %08x   |     %08x      |\n", this.Instruction, this.ProgramCounter)};
        returnString                 = {returnString, $psprintf(":----------.---'-------.-----------:\n")};
        returnString                 = {returnString, $psprintf("| Register |    Pre    |   Post    |\n")};
        returnString                 = {returnString, $psprintf(":----------+-----------+-----------:\n")};
        returnString                 = {returnString, $psprintf("| GPR_a    | %08xh ", this.GPR_a)};
        returnString                 = {returnString, $psprintf("| %08xh | %01b\n", this.GPR_a_dat, this.GPR_a_val)};
        returnString                 = {returnString, $psprintf("| GPR_b    | %08xh ", this.GPR_b)};
        returnString                 = {returnString, $psprintf("| %08xh | %01b\n", this.GPR_b_dat, this.GPR_b_val)};
        returnString                 = {returnString, $psprintf("| GPR_c    | %08xh ", this.GPR_c)};
        returnString                 = {returnString, $psprintf("| %08xh | %01b\n", this.GPR_c_dat, this.GPR_c_val)};
        returnString                 = {returnString, $psprintf("| SPR_h    | %08xh ", this.SPR_h)};
        returnString                 = {returnString, $psprintf("| %08xh | %01b\n", this.SPR_h_dat, this.SPR_h_val)};
        returnString                 = {returnString, $psprintf("| SPR_l    | %08xh ", this.SPR_l)};
        returnString                 = {returnString, $psprintf("| %08xh | %01b\n", this.SPR_l_dat, this.SPR_h_val)};
        returnString                 = {returnString, $psprintf(":----------'-------.---'-----------:\n")};
        returnString                 = {returnString, $psprintf("|     OverFlow     |      Zero     |\n")};
        returnString                 = {returnString, $psprintf(":------------------+---------------:\n")};
        returnString                 = {returnString, $psprintf("|         %01b        |      %01b        |\n", this.SPR_o_val, this.SPR_z_val)};
        returnString                 = {returnString, $psprintf("'------------------'---------------'\n")};
        return returnString;
    end
    endfunction : convert2string

    virtual function void do_pack(uvm_packer packer);
    begin
        super.do_pack(packer);
        packer.pack_field_int(Instruction,    32);
        packer.pack_field_int(ProgramCounter, 32);
        packer.pack_field_int(GPR_a,          32);
        packer.pack_field_int(GPR_b,          32);
        packer.pack_field_int(GPR_c,          32);
        packer.pack_field_int(SPR_h,          32);
        packer.pack_field_int(SPR_l,          32);
        packer.pack_field_int(GPR_a_dat,      32);
        packer.pack_field_int(GPR_a_val,      1);
        packer.pack_field_int(GPR_b_dat,      32);
        packer.pack_field_int(GPR_b_val,      1);
        packer.pack_field_int(GPR_c_dat,      32);
        packer.pack_field_int(GPR_c_val,      1);
        packer.pack_field_int(SPR_h_dat,      32);
        packer.pack_field_int(SPR_h_val,      1);
        packer.pack_field_int(SPR_l_dat,      32);
        packer.pack_field_int(SPR_l_val,      1);
        packer.pack_field_int(SPR_o_val,      1);
        packer.pack_field_int(SPR_z_val,      1);
    end
    endfunction : do_pack
    
    virtual function void do_unpack(uvm_packer packer);
    begin
        Instruction    = packer.unpack_field_int(32);
        ProgramCounter = packer.unpack_field_int(32);
        GPR_a          = packer.unpack_field_int(32);
        GPR_b          = packer.unpack_field_int(32);
        GPR_c          = packer.unpack_field_int(32);
        SPR_h          = packer.unpack_field_int(32);
        SPR_l          = packer.unpack_field_int(32);
        GPR_a_dat      = packer.unpack_field_int(32);
        GPR_a_val      = packer.unpack_field_int(1);
        GPR_b_dat      = packer.unpack_field_int(32);
        GPR_b_val      = packer.unpack_field_int(1);
        GPR_c_dat      = packer.unpack_field_int(32);
        GPR_c_val      = packer.unpack_field_int(1);
        SPR_h_dat      = packer.unpack_field_int(32);
        SPR_h_val      = packer.unpack_field_int(1);
        SPR_l_dat      = packer.unpack_field_int(32);
        SPR_l_val      = packer.unpack_field_int(1);
        SPR_o_val      = packer.unpack_field_int(1);
        SPR_z_val      = packer.unpack_field_int(1);
    end    
    endfunction : do_unpack

    // Description: do_record function is the user-definable hook called by the record function of
    // uvm_object which records the object properties
    virtual function void do_record(uvm_recorder recorder);
        super.do_record(recorder);
        `uvm_record_int("Instruction",    Instruction, 32, UVM_NORADIX)
        `uvm_record_int("ProgramCounter", Instruction, 32, UVM_NORADIX)
        `uvm_record_int("GPR_a",          GPR_a,     32, UVM_NORADIX)
        `uvm_record_int("GPR_b",          GPR_b,     32, UVM_NORADIX)
        `uvm_record_int("GPR_c",          GPR_c,     32, UVM_NORADIX)
        `uvm_record_int("SPR_h",          SPR_h,     32, UVM_NORADIX)
        `uvm_record_int("SPR_l",          SPR_l,     32, UVM_NORADIX)
        `uvm_record_int("GPR_a_dat",      GPR_a_dat, 32, UVM_NORADIX)
        `uvm_record_int("GPR_a_val",      GPR_a_val, 1,  UVM_NORADIX)
        `uvm_record_int("GPR_b_dat", GPR_b_dat, 32, UVM_NORADIX)
        `uvm_record_int("GPR_b_val", GPR_b_val, 1,  UVM_NORADIX)
        `uvm_record_int("GPR_c_dat", GPR_c_dat, 32, UVM_NORADIX)
        `uvm_record_int("GPR_c_val", GPR_c_val, 1,  UVM_NORADIX)
        `uvm_record_int("SPR_h_dat", SPR_h_dat, 1,  UVM_NORADIX)
        `uvm_record_int("SPR_h_val", SPR_h_val, 1,  UVM_NORADIX)
        `uvm_record_int("SPR_l_dat", SPR_l_dat, 32, UVM_NORADIX)
        `uvm_record_int("SPR_l_val", SPR_l_val, 1,  UVM_NORADIX)
        `uvm_record_int("SPR_o_val", SPR_o_val, 1,  UVM_NORADIX)
        `uvm_record_int("SPR_z_val", SPR_o_val, 1,  UVM_NORADIX)
    endfunction : do_record



    // sprint() calls do_print() and returns the string.
    // print() calls do_print() and then prints with $display().
    virtual function void do_print(uvm_printer printer);
        printer.m_string = this.convert2string();
    endfunction : do_print

endclass :  ALUSequenceItem
`endif // __ALUSEQUENCEITEM__SVH