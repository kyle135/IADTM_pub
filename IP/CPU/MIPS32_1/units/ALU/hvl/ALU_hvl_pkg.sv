//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-------------------------------------------------------------------------------------------------
package ALU_hvl_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    // - A pure function result depends solely on the function inputs
    // - A context function is aware of the Verilog scope in which it is imported
    // In our case we don't need to maintain state so pure will be the best approach.
    import "DPI-C" pure function int c_alu_gpr_a_dat(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_gpr_a_val(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_gpr_b_dat(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_gpr_b_val(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_gpr_c_dat(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_gpr_c_val(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_spr_h_dat(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_spr_h_val(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_spr_l_dat(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_spr_l_val(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_spr_o_val(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);
    import "DPI-C" pure function int c_alu_spr_z_val(input int instruction, input int program_counter, input int a, input int b, input int c, input int h, input int l);

    parameter string  DUT = "ALU";                                    // Name of DUT
    parameter integer N   = 32;                                       // Data path bit width   

    import ALU_hdl_pkg::*;

    const logic FAILURE = 1'b0;
    const logic SUCCESS = 1'b1;

    `include "hvl/SequenceItems/src/ALUSequenceItem.svh"
    `include "hvl/Config/src/ALUConfig.svh"
    `include "hvl/Sequence/src/ALUSequence.svh"
    `include "hvl/Sequencer/src/ALUSequencer.svh"
    `include "hvl/Monitor/src/ALUMonitor.svh"
    `include "hvl/Driver/src/ALUDriver.svh"
    `include "hvl/Predictor/src/ALUPredictor.svh"
    `include "hvl/Agent/src/ALUAgent.svh"
    `include "hvl/ScoreBoard/src/ALUScoreBoard.svh"
    `include "hvl/Environment/src/ALUEnvironment.svh"
    `include "hvl/Test/src/ALUTest.svh"
    

endpackage : ALU_hvl_pkg
