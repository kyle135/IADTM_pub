//---------------------------------------------------------------------------------------
// Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
//                  Creative Commons Attribution 4.0 International 
//
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     GeneralPurposeRegisterBlock
// Description:
//---------------------------------------------------------------------------------------
class GeneralPurposeRegisterBlock extends uvm_reg_block;
    `uvm_object_utils(GeneralPurposeRegisterBlock)
    //  .---------------------.------------.-----------------------------------------------------.
    //  |                     | Name       | Description                                         |
    //  :---------------------+------------+-----------------------------------------------------:
    rand GeneralPurposeRegister GPRZero; //| constant 0                                          |
    rand GeneralPurposeRegister GPRAT;   //| reserved for assembler                              |
    rand GeneralPurposeRegister GPRV0;   //| expression evaluation and results of a function     |
    rand GeneralPurposeRegister GPRV1;   //| expression evaluation and results of a function     |
    rand GeneralPurposeRegister GPRA0;   //| argument 1                                          |
    rand GeneralPurposeRegister GPRA1;   //| argument 2                                          |
    rand GeneralPurposeRegister GPRA2;   //| argument 3                                          |
    rand GeneralPurposeRegister GPRA3;   //| argument 4                                          |
    rand GeneralPurposeRegister GPRT0;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRT1;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRT2;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRT3;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRT4;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRT5;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRT6;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRT7;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRS0;   //| saved temporary (preserved across call)             |
    rand GeneralPurposeRegister GPRS1;   //| saved temporary (preserved across call)             |
    rand GeneralPurposeRegister GPRS2;   //| saved temporary (preserved across call)             |
    rand GeneralPurposeRegister GPRS3;   //| saved temporary (preserved across call)             |
    rand GeneralPurposeRegister GPRS4;   //| saved temporary (preserved across call)             |
    rand GeneralPurposeRegister GPRS5;   //| saved temporary (preserved across call)             |
    rand GeneralPurposeRegister GPRS6;   //| saved temporary (preserved across call)             |
    rand GeneralPurposeRegister GPRS7;   //| saved temporary (preserved across call)             |
    rand GeneralPurposeRegister GPRT8;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRT9;   //| temporary (not preserved across call)               |
    rand GeneralPurposeRegister GPRK0;   //| reserved for OS kernel                              |
    rand GeneralPurposeRegister GPRK1;   //| reserved for OS kernel                              |
    rand GeneralPurposeRegister GPRGP;   //| pointer to global area                              |
    rand GeneralPurposeRegister GPRSP;   //| stack pointer                                       |
    rand GeneralPurposeRegister GPRFP;   //| frame pointer                                       |
    rand GeneralPurposeRegister GPRRA;   //| return address (used by function call)              |
    //  '----------------------------------'-----------------------------------------------------'
    uvm_reg_map                  reg_map;

    function new(string name "GeneralPurposeRegisterBlock");
        super.new(GeneralPurposeRegisterBlock, UVM_CVR_ALL);
    endfunction : new

    virtual function void build();
        GPRZero= GeneralPurposeRegister::type_id::create("GPRZero");
        GPRAT  = GeneralPurposeRegister::type_id::create("GPRAT");
        GPRV0  = GeneralPurposeRegister::type_id::create("GPRV0");
        GPRV1  = GeneralPurposeRegister::type_id::create("GPRV1");
        GPRA0  = GeneralPurposeRegister::type_id::create("GPRA0");
        GPRA1  = GeneralPurposeRegister::type_id::create("GPRA1");
        GPRA2  = GeneralPurposeRegister::type_id::create("GPRA2");
        GPRA3  = GeneralPurposeRegister::type_id::create("GPRA3");
        GPRT0  = GeneralPurposeRegister::type_id::create("GPRT0");
        GPRT1  = GeneralPurposeRegister::type_id::create("GPRT1");
        GPRT2  = GeneralPurposeRegister::type_id::create("GPRT2");
        GPRT3  = GeneralPurposeRegister::type_id::create("GPRT3");
        GPRT4  = GeneralPurposeRegister::type_id::create("GPRT4");
        GPRT5  = GeneralPurposeRegister::type_id::create("GPRT5");
        GPRT6  = GeneralPurposeRegister::type_id::create("GPRT6");
        GPRT7  = GeneralPurposeRegister::type_id::create("GPRT7");
        GPRS0  = GeneralPurposeRegister::type_id::create("GPRS0");
        GPRS1  = GeneralPurposeRegister::type_id::create("GPRS1");
        GPRS2  = GeneralPurposeRegister::type_id::create("GPRS2");
        GPRS3  = GeneralPurposeRegister::type_id::create("GPRS3");
        GPRS4  = GeneralPurposeRegister::type_id::create("GPRS4");
        GPRS5  = GeneralPurposeRegister::type_id::create("GPRS5");
        GPRS6  = GeneralPurposeRegister::type_id::create("GPRS6");
        GPRS7  = GeneralPurposeRegister::type_id::create("GPRS7");
        GPRT8  = GeneralPurposeRegister::type_id::create("GPRT8");
        GPRT9  = GeneralPurposeRegister::type_id::create("GPRT9");
        GPRK0  = GeneralPurposeRegister::type_id::create("GPRK0");
        GPRK1  = GeneralPurposeRegister::type_id::create("GPRK1");
        GPRGP  = GeneralPurposeRegister::type_id::create("GPRGP");
        GPRSP  = GeneralPurposeRegister::type_id::create("GPRSP");
        GPRFP  = GeneralPurposeRegister::type_id::create("GPRFP");
        GPRRA  = GeneralPurposeRegister::type_id::create("GPRRA");

        GPRZero.configuration(this);
        GPRAT.configuration(this);
        GPRV0.configuration(this);
        GPRV1.configuration(this);
        GPRA0.configuration(this);
        GPRA1.configuration(this);
        GPRA2.configuration(this);
        GPRA3.configuration(this);
        GPRT0.configuration(this);
        GPRT1.configuration(this);
        GPRT2.configuration(this);
        GPRT3.configuration(this);
        GPRT4.configuration(this);
        GPRT5.configuration(this);
        GPRT6.configuration(this);
        GPRT7.configuration(this);
        GPRS0.configuration(this);
        GPRS1.configuration(this);
        GPRS2.configuration(this);
        GPRS3.configuration(this);
        GPRS4.configuration(this);
        GPRS5.configuration(this);
        GPRS6.configuration(this);
        GPRS7.configuration(this);
        GPRT8.configuration(this);
        GPRT9.configuration(this);
        GPRK0.configuration(this);
        GPRK1.configuration(this);
        GPRGP.configuration(this);
        GPRSP.configuration(this);
        GPRFP.configuration(this);
        GPRRA.configuration(this);

        GPRZero.build();
        GPRAT.build();
        GPRV0.build();
        GPRV1.build();
        GPRA0.build();
        GPRA1.build();
        GPRA2.build();
        GPRA3.build();
        GPRT0.build();
        GPRT1.build();
        GPRT2.build();
        GPRT3.build();
        GPRT4.build();
        GPRT5.build();
        GPRT6.build();
        GPRT7.build();
        GPRS0.build();
        GPRS1.build();
        GPRS2.build();
        GPRS3.build();
        GPRS4.build();
        GPRS5.build();
        GPRS6.build();
        GPRS7.build();
        GPRT8.build();
        GPRT9.build();
        GPRK0.build();
        GPRK1.build();
        GPRGP.build();
        GPRSP.build();
        GPRFP.build();
        GPRRA.build();

        reg_map = create_map("reg_map", 5'h00, 4, UVM_LITTLE_ENDIAN);
        reg_map.add_reg(GPRZero, 5'h00, "RO");
        reg_map.add_reg(GPRAT,   5'h01, "RW");
        reg_map.add_reg(GPRV0,   5'h02, "RW");
        reg_map.add_reg(GPRV1,   5'h03, "RW");
        reg_map.add_reg(GPRA0,   5'h04, "RW");
        reg_map.add_reg(GPRA1,   5'h05, "RW");
        reg_map.add_reg(GPRA2,   5'h06, "RW");
        reg_map.add_reg(GPRA3,   5'h07, "RW");
        reg_map.add_reg(GPRT0,   5'h08, "RW");
        reg_map.add_reg(GPRT1,   5'h09, "RW");
        reg_map.add_reg(GPRT2,   5'h0A, "RW");
        reg_map.add_reg(GPRT3,   5'h0B, "RW");
        reg_map.add_reg(GPRT4,   5'h0C, "RW");
        reg_map.add_reg(GPRT5,   5'h0D, "RW");
        reg_map.add_reg(GPRT6,   5'h0E, "RW");
        reg_map.add_reg(GPRT7,   5'h0F, "RW");
        reg_map.add_reg(GPRS0,   5'h10, "RW");
        reg_map.add_reg(GPRS1,   5'h11, "RW");
        reg_map.add_reg(GPRS2,   5'h12, "RW");
        reg_map.add_reg(GPRS3,   5'h13, "RW");
        reg_map.add_reg(GPRS4,   5'h14, "RW");
        reg_map.add_reg(GPRS5,   5'h15, "RW");
        reg_map.add_reg(GPRS6,   5'h16, "RW");
        reg_map.add_reg(GPRS7,   5'h17, "RW");
        reg_map.add_reg(GPRT8,   5'h18, "RW");
        reg_map.add_reg(GPRT9,   5'h19, "RW");
        reg_map.add_reg(GPRK0,   5'h1A, "RW");
        reg_map.add_reg(GPRK1,   5'h1B, "RW");
        reg_map.add_reg(GPRGP,   5'h1C, "RW");
        reg_map.add_reg(GPRSP,   5'h1D, "RW");
        reg_map.add_reg(GPRFP,   5'h1E, "RW");
        reg_map.add_reg(GPRRA,   5'h1F, "RW");

        lock_model();
    endfunction : build

endclass : GeneralPurposeRegisterBlock
