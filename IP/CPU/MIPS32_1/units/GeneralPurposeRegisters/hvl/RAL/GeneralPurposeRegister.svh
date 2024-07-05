//---------------------------------------------------------------------------------------
// Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
//                  Creative Commons Attribution 4.0 International 
//
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     GeneralPurposeRegister
// Description:
//---------------------------------------------------------------------------------------
class GeneralPurposeRegister extends uvm_reg;
    `uvm_object_utils(GeneralPurposeRegister)

    rand uvm_reg_field GPR;

    function new(string name = "GeneralPurposeRegister");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction : new

    virtual function void build();
        GPR = uvm_reg_field::type_id::create("GPR");
        GPR.configure(
            .parent                  ( this ),
            .size                    ( 32   ),
            .lsb_pos                 ( 0    ),
            .access                  ( "RW" ),
            .volatile                (      ),
            .reset                   ( 0    ),
            .has_reset               ( 0    ),
            .is_rand                 ( 0    ),
            .individually_accessible ( 0    ));
    endfunction : build

endclass : GeneralPurposeRegister
