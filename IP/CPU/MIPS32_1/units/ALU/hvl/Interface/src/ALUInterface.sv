//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Module Name:  ALUInterface
//-------------------------------------------------------------------------------------------------
`timescale 1ns/1ns
interface  ALUInterface
#(  //----------------------------------//---------------------------------------------------------
    // Parameters
    //----------------------------------//---------------------------------------------------------
    parameter integer N = 32,           //
    parameter integer R = 32            // Register Count
)  (//----------------------------------//---------------------------------------------------------
    //
    //----------------------------------//---------------------------------------------------------
    input  wire       clk               // Core Clock
);

    parameter integer O = $clog2(R);    //
    
    logic         rstn;


    bit capture_inputs_started = 0;
    //----------------------------------//---------------------------------------------------------
    //                                  // Description(s)
    //----------------------------------//---------------------------------------------------------
    logic [N-1:0] Instruction;          // Encoded ALU Operation Commands from ALU Decoder
    logic [N-1:0] ProgramCounter;       //
    logic [N-1:0] GPR_a;                //
    logic [N-1:0] GPR_b;                //
    logic [N-1:0] GPR_c;                //
    logic [N-1:0] SPR_h;                //
    logic [N-1:0] SPR_l;                //
    //----------------------------------//---------------------------------------------------------
    //                                  // Description(s)
    //----------------------------------//---------------------------------------------------------
    logic [N-1:0] GPR_a_dat;            // Register write back data for GPR a
    logic         GPR_a_val;            // Register write back data for GPR a is valid.
    logic [N-1:0] GPR_b_dat;            // Register write back data for GPR b
    logic         GPR_b_val;            // Register write back data of GPR b is valid.
    logic [N-1:0] GPR_c_dat;            // Register write back data for GPR c
    logic         GPR_c_val;            // Register write back data of GPR c is valid.
    logic [N-1:0] SPR_h_dat;            //
    logic         SPR_h_val;            // Special Purpose Register H
    logic [N-1:0] SPR_l_dat;            //
    logic         SPR_l_val;            //
    logic         SPR_o_val;            // OverFlow
    logic         SPR_z_val;            // Zero

    //-------------------------------------------------------------------------
    // Interface Tasks
    //-------------------------------------------------------------------------    
    task drive_inputs;
    input logic [N-1:0] i_Instruction;
    input logic [N-1:0] i_ProgramCounter;
   	input logic [N-1:0] i_GPR_a;
    input logic [N-1:0] i_GPR_b;
    input logic [N-1:0] i_GPR_c;
    input logic [N-1:0] i_SPR_h;
    input logic [N-1:0] i_SPR_l;
	begin
        Instruction    = i_Instruction;
        ProgramCounter = i_ProgramCounter;
		GPR_a          = i_GPR_a;
		GPR_b          = i_GPR_b;
        GPR_c          = i_GPR_c;
        SPR_h          = i_SPR_h;
        SPR_l          = i_SPR_l;
	end
    endtask : drive_inputs

    task capture_inputs;
    output logic [N-1:0] i_Instruction;
    output logic [N-1:0] i_ProgramCounter;
    output logic [N-1:0] i_GPR_a;
    output logic [N-1:0] i_GPR_b;
    output logic [N-1:0] i_GPR_c;
    output logic [N-1:0] i_SPR_h;
    output logic [N-1:0] i_SPR_l;
    output logic         o_valid;
    begin
        #1ns;
        i_Instruction    = Instruction;
        i_ProgramCounter = ProgramCounter;
        i_GPR_a          = GPR_a;
        i_GPR_b          = GPR_b;
        i_GPR_c          = GPR_c;
        i_SPR_h          = SPR_h;
        i_SPR_l          = SPR_l;
        if (Instruction !== {N{1'b0}} &&
            Instruction !== {N{1'bx}}) begin
            o_valid = 1'b1;
        end else begin
            o_valid = 1'b1;
        end
    end
    endtask : capture_inputs

    task capture_outputs;   
    output logic [N-1:0] o_GPR_a_dat;
    output logic         o_GPR_a_val;
    output logic [N-1:0] o_GPR_b_dat;
    output logic         o_GPR_b_val;
    output logic [N-1:0] o_GPR_c_dat;
    output logic         o_GPR_c_val;
    output logic [N-1:0] o_SPR_h_dat;
    output logic         o_SPR_h_val;
    output logic [N-1:0] o_SPR_l_dat;
    output logic         o_SPR_l_val;
    output logic         o_SPR_o_val;
    output logic         o_SPR_z_val;
    output logic         o_valid;
    begin
        #1ns;
        o_GPR_a_dat = GPR_a_dat;
        o_GPR_a_val = GPR_a_val;
        o_GPR_b_dat = GPR_b_dat;
        o_GPR_b_val = GPR_b_val;
        o_GPR_c_dat = GPR_c_dat;
        o_GPR_c_val = GPR_c_val;
        o_SPR_h_dat = SPR_h_dat;
        o_SPR_h_val = SPR_h_val;
        o_SPR_l_dat = SPR_l_dat;
        o_SPR_l_val = SPR_l_val;
        o_SPR_o_val = SPR_o_val;
        o_SPR_z_val = SPR_z_val;
        // If no operation occurred we don't care.
        if (GPR_a_val === 1'b1 | GPR_b_val === 1'b1 | GPR_c_val === 1'b1 |
            SPR_h_val === 1'b1 | SPR_l_val === 1'b1 | SPR_o_val === 1'b1 |
            SPR_z_val === 1'b1) begin
            o_valid = 1'b1;
        end else begin
            o_valid = 1'b0;
        end
    end
    endtask : capture_outputs

endinterface :  ALUInterface

