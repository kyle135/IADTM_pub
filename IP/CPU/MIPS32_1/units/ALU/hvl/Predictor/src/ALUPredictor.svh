//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Module Name:     ALUPredictor
// Description:     UVM Predictor for ALU
// This is a verification component that represents a "golden" model of all or part of the DUT
// functionality.
//-------------------------------------------------------------------------------------------------
`ifndef __ALUPREDICTOR__SVH
    `define __ALUPREDICTOR__SVH
class ALUPredictor extends uvm_subscriber #(ALUSequenceItem);
    typedef ALUPredictor this_type_t;
    `uvm_component_utils(ALUPredictor);

    uvm_analysis_port #(ALUSequenceItem) expected_port;
    
    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    // Class constructor
    function new(string name = "ALUPredictor", uvm_component parent);
    begin
        super.new(name, parent);
    end
    endfunction : new    

    //
    virtual function void build_phase(uvm_phase phase);
    begin
        expected_port = new("expected_port", this);
    end
    endfunction : build_phase

    // A uvm_subscriber has a built in analysis_export which provides access to
    // the write method, which derived subscribers must implement. Here we 
    // implement the write.
    virtual function void write(ALUSequenceItem t);
    ALUSequenceItem item;
    begin
        if (!$cast(item, t.clone())) begin
            `uvm_fatal(get_type_name(), "Illegal rhs argument (cast failed)")
        end
        item.GPR_a_dat = int'(c_alu_gpr_a_dat(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.GPR_a_val = int'(c_alu_gpr_a_val(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.GPR_b_dat = int'(c_alu_gpr_b_dat(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.GPR_b_val = int'(c_alu_gpr_b_val(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.GPR_c_dat = int'(c_alu_gpr_c_dat(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.GPR_c_val = int'(c_alu_gpr_c_val(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.SPR_h_dat = int'(c_alu_spr_h_dat(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.SPR_h_val = int'(c_alu_spr_h_val(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.SPR_l_dat = int'(c_alu_spr_l_dat(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.SPR_l_val = int'(c_alu_spr_h_val(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.SPR_o_val = int'(c_alu_spr_o_val(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        item.SPR_z_val = int'(c_alu_spr_z_val(item.Instruction, item.ProgramCounter, item.GPR_a, item.GPR_b, item.GPR_c, item.SPR_h, item.SPR_l));
        expected_port.write(item);
    end
    endfunction : write

endclass : ALUPredictor
`endif // __ALUPREDICTOR__SVH
