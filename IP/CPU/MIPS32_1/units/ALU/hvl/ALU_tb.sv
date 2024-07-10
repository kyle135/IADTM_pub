//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//-----------------------------------------------------------------------------
`timescale 1ns / 1ps
module ALU_tb
#(  //-------------------------------------------------------------------------
    // Parameter(s)
    //-------------------------------------------------------------------------
    parameter integer N     = 32,
    parameter integer O     = $clog2(N)
);
    import uvm_pkg::*;
    import MIPS32_1_hdl_pkg::*;
    import ALU_hvl_pkg::*;

    //-------------------------------------------------------------------------
    // Local Parameters
    //-------------------------------------------------------------------------
    localparam MAX_DELAY=150;

    //-------------------------------------------------------------------------
    // Local TestBench Signals
    //-------------------------------------------------------------------------
    bit clk  = 1'b1;

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    ALU
    #(  //-----------------------------------------//--------------------------
        // Parameters                              // Description(s)
        //-----------------------------------------//--------------------------
        .N              ( N                     )  // Data path bit-width
    )                                              //
    u_ALU                                          //
    (   //-----------------------------------------//--------------------------
        // Global Signals                          // Direction, Size & Description(s) 
        //-----------------------------------------//----------------------------------------------
        .clk            ( alu_intf.clk          ), // [I][1] Core Clock
        .rstn           ( alu_intf.rstn         ), // [I][1] Asynchronous Reset, Synchronous Set (Active-Low)
        //-----------------------------------------//----------------------------------------------
        // Register data                           // Direction, Size & Description(s) 
        //-----------------------------------------//----------------------------------------------
        .Instruction   ( alu_intf.Instruction   ), // [I][N] 
        .ProgramCounter( alu_intf.ProgramCounter), // [I][N] 
        .GPR_a         ( alu_intf.GPR_a         ), // [I][N] GPR a register read data.
        .GPR_b         ( alu_intf.GPR_b         ), // [I][N] GPR b register read data.
        .GPR_c         ( alu_intf.GPR_c         ), // [I][N] GPR c register read data.
        .SPR_h         ( alu_intf.SPR_h         ), // [I][N] SPR h register read data.
        .SPR_l         ( alu_intf.SPR_l         ), // [I][N] SPR l register read data.
        //-----------------------------------------//---------------------------------------
        //                                         // Direction, Size & Description(s) 
        //-----------------------------------------//---------------------------------------
        .GPR_a_dat     ( alu_intf.GPR_a_dat    ), // [O][N] GPR a register write back data.
        .GPR_a_val     ( alu_intf.GPR_a_val    ), // [O][1] GPR a register write back enable.
        .GPR_b_dat     ( alu_intf.GPR_b_dat    ), // [O][N] GPR b register write back data.
        .GPR_b_val     ( alu_intf.GPR_b_val    ), // [O][1] GPR b register write back enable.
        .GPR_c_dat     ( alu_intf.GPR_c_dat    ), // [O][N] GPR c register write back data.
        .GPR_c_val     ( alu_intf.GPR_c_val    ), // [O][1] GPR c register write back enable.
        .SPR_h_dat     ( alu_intf.SPR_h_dat    ), // [O][N] SPR h register write back data.
        .SPR_h_val     ( alu_intf.SPR_h_val    ), // [O][1] SPR h register write back enable.
        .SPR_l_dat     ( alu_intf.SPR_l_dat    ), // [O][N] SPR l register write back data
        .SPR_l_val     ( alu_intf.SPR_l_val    ), // [O][1] SPR l register write back enable
        .SPR_o_val     ( alu_intf.SPR_o_val    ), // [O][1] SPR OverFlow flag 
        .SPR_z_val     ( alu_intf.SPR_z_val    )  // [O][1] SPR Zero flag
    );

    //---------------------------------------------------------------------------------------------
    // UVM Test Bench Components
    //---------------------------------------------------------------------------------------------
    ALUConfig    alu_cfg;               // The ALU Confgiuration Object.
    ALUInterface alu_intf(clk);         // Interface to connect DUT to UVM test

    //---------------------------------------------------------------------------------------------
    // UVM Test Start
    //---------------------------------------------------------------------------------------------
    initial begin
        alu_intf.rstn = 1'b0;
        alu_cfg = new ("alu_cfg");      // Create the configuration object

        uvm_config_db#(virtual ALUInterface)::set(uvm_root::get( ), "*", "alu_intf", alu_intf );
        uvm_config_db#(ALUConfig)::set(uvm_root::get( ), "*", "alu_cfg", alu_cfg );

        fork
            forever  #5ns clk <= ~clk;
                    #21ns alu_intf.rstn = 1'b1;
            run_test("ALUTest");
        join
    end

endmodule : ALU_tb

