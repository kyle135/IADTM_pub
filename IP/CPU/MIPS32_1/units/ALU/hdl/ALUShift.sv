//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  MIPS I 32-bit ALU
// Module Name:  ALUShift
// Description:  All of the shift operations
// Dependencies: 
// · BitWiseShiftLeft.sv
// · BitWiseShiftRight.sv
//-------------------------------------------------------------------------------------------------
`default_nettype none
module ALUShift
#(  //----------------------------------//---------------------------------------------------------
    // Parameters                       // Description(s)
    //----------------------------------//---------------------------------------------------------
    parameter integer   N = 32,         // Data Path width in bits.
    parameter integer   R = 32,         // Register Count
    parameter integer   O = $clog2(R)   // Address width for GPR registers.
)  (//----------------------------------//---------------------------------------------------------
    // Inputs                           // Description(s)
    //----------------------------------//---------------------------------------------------------
    input  wire [N-1:0] Instruction,    // 
    input  wire [N-1:0] ProgramCounter, //
    input  wire [N-1:0] GPR_a,          // GPR a register read data.
    input  wire [N-1:0] GPR_b,          // GPR b register read data.
    input  wire [N-1:0] GPR_c,          // GPR c register read data.
    input  wire [N-1:0] SPR_h,          // SPR h register read data.
    input  wire [N-1:0] SPR_l,          // SPR l register read data.
    //----------------------------------//---------------------------------------------------------
    // Outputs                          // Description(s)
    //----------------------------------//---------------------------------------------------------
    output  reg [N-1:0] GPR_a_dat,      // GPR a register write back data.
    output  reg         GPR_a_val,      // GPR a register write back enable.
    output  reg [N-1:0] GPR_b_dat,      // GPR b register write back data.
    output  reg         GPR_b_val,      // GPR b register write back enable.
    output  reg [N-1:0] GPR_c_dat,      // GPR c register write back data.
    output  reg         GPR_c_val,      // GPR c register write back enable.
    output  reg [N-1:0] SPR_h_dat,      // SPR h register write back data.
    output  reg         SPR_h_val,      // SPR h register write back enable.
    output  reg [N-1:0] SPR_l_dat,      // SPR l register write back data
    output  reg         SPR_l_val,      // SPR l register write back enable
    output  reg         SPR_o_val,      // SPR OverFlow flag 
    output  reg         SPR_z_val       // SPR Zero flag
);
    
    import MIPS32_1_hdl_pkg::*;

    //---------------------------------------------------------------------------------------------
    // Local Net Declarations.
    //---------------------------------------------------------------------------------------------
    wire [ 15:0] Imm16;
    reg  [ 31:0] SR_a, SR_b; 
    wire [ 31:0] SR_c;
    reg  [ 31:0] SL_a, SL_b;
    wire [ 31:0] SL_c;

    //---------------------------------------------------------------------------------------------
    // Combinational Logic
    //---------------------------------------------------------------------------------------------
    // Case Z definition
    // In the casez the don't-care value can represented by the question mark (?)
    // while the High-Impedence value is represented by the letter z (z).
    always_comb begin
        SL_a = {N{1'b0}};
        SL_b = {N{1'b0}};
        SR_a = {N{1'b0}};
        SR_b = {N{1'b0}};
        {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
        {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
        {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
        {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
        {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
        {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
        casez(Instruction)
            {SLL_OP,   5'b?????, 5'b?????, 5'b?????, 5'b?????, SLL_FUNC}: begin : SHIFT_LEFT_LOGICAL_INSTRUCTION
                //--------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | 0 0 0 0 0 | b b b b b | c c c c c | s s s s s | 1 0 1 0 1 0 |
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]        Shift Left Logical
                // [Assembly]    
                // [Operation]
                // [Description] The contents of the low-order 32-bit word of GPR[b] are shifted
                // left, inserting zeros into the emptied bits; the word ALUOut is placed in 
                // GPR[c]. The bit shift count is specified by s.
                // The sign-bit (bit 31) in the emptied bits; the word ALUOut is placed in GPR[c]. The 
                // bit shift count is specified by shift amount (s).                                                
                SL_a = {N{1'b0}};
                SL_b = {N{1'b0}};
                SR_a = {N{1'b0}};
                SR_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : SHIFT_LEFT_LOGICAL_INSTRUCTION
            {SLLV_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, SLLV_FUNC}: begin : SHIFT_LEFT_LOGICAL_VARIABLE_INSTRUCTION
                SL_a = {N{1'b0}};
                SL_b = {N{1'b0}};
                SR_a = {N{1'b0}};
                SR_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : SHIFT_LEFT_LOGICAL_VARIABLE_INSTRUCTION
            {SRA_OP,   5'b00000, 5'b?????, 5'b?????, 5'b?????, SRA_FUNC}: begin : SHIFT_RIGHT_ARITHMETIC_INSTRUCTION
                //--------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | 0 0 0 0 0 | b b b b b | c c c c c | s s s s s | 0 0 0 0 1 1 |
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]        Shift Word Right Arithmetic
                // [Assembly]    SRA c, a, s
                // [Operation]   GPR[c] = GPR[b] >> s
                // [Description] The contents of general register GPR[b] are shifted 
                // right by s bits, sign-extending the high order bit. The 32-bit result 
                // is placed in GPR[c].
                SL_a = {N{1'b0}};
                SL_b = {N{1'b0}};
                SR_a = GPR_b;
                SR_b = {27'd0, Instruction[10:6]};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b1, SR_c };
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : SHIFT_RIGHT_ARITHMETIC_INSTRUCTION
            {SRAV_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, SRAV_FUNC}: begin : SHIFT_RIGHT_ARITHMETIC_VARIABLE_INSTRUCTION
                //-------------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 0 0 0 1 1 1 |
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]        Shift Word Right Arithmetic Variable
                // [Assembly]    SRAV c, a, b
                // [Operation]   GPR[c] = GPR[b] >> GPR[a]
                // [Description] The contents of the low-order 32-bit word of GPR[b] are shifted right,
                // duplicating the sign-bit (bit 31) in the emptied bits; the word result is placed in
                // GPR[c]. The bit-shift amount is specified by the low-order 5 bits of GPR[a].
                SL_a = {N{1'b0}};
                SL_b = {N{1'b0}};
                SR_a = GPR_b;
                SR_b = {27'd0, GPR_a[4:0]};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b1, SR_c };
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : SHIFT_RIGHT_ARITHMETIC_VARIABLE_INSTRUCTION
            {SRL_OP,   5'b?????, 5'b?????, 5'b?????, 5'b?????, SRL_FUNC}: begin : SHIFT_RIGHT_LOGICAL_INSTRUCTION
                //--------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | 0 0 0 0 0 | b b b b b | c c c c c | s s s s s | 0 0 0 0 1 0 |
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]           Shift Word Right Logical
                // [Assembly]       SRL c, b, s
                // [Description]    rd <- rt >> sa (arithmetic)
                // The contents of the low-order 32-bit word of GPR rt are shifted right,
                // inserting zeros into the emptied bits; the word ALUOut is placed in GPR
                // rd. The bit shift count is specified by sa.
                SL_a = {N{1'b0}};
                SL_b = {N{1'b0}};
                SR_a = GPR_b;
                SR_b = {27'd0, GPR_a[4:0]};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b1, SR_c };
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : SHIFT_RIGHT_LOGICAL_INSTRUCTION
            {SRLV_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, SRLV_FUNC}: begin : SHIFT_RIGHT_LOGICAL_VARIABLE_INSTRUCTION
                //--------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 0 0 0 1 1 0 | SRLV
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]        Shift Word Right Logical
                // [Assembly]    SRLV c, b, a
                // [Operations]  GPR[c] = 
                // [Description] The contents of general register GPR[b] are shifted 
                // right by GPR[a] bits, sign-extending the high order bit. The 32-bit result is placed in general
                SL_a = {N{1'b0}};
                SL_b = {N{1'b0}};
                SR_a = GPR_b;
                SR_b = {27'd0, GPR_a[4:0]};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b1, SR_c };
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : SHIFT_RIGHT_LOGICAL_VARIABLE_INSTRUCTION        
            default: begin
                SL_a = {N{1'b0}};
                SL_b = {N{1'b0}};
                SR_a = {N{1'b0}};
                SR_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c };
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end
        endcase
    end

    //---------------------------------------------------------------------------------------------
    // Module Instances
    //---------------------------------------------------------------------------------------------
    BitWiseShiftLeft
    #(  //-------------------------------------//--------------------------------------------------
        // Parameter(s)                        // Descriptions
        //-------------------------------------//--------------------------------------------------
        .N          ( N                     )  //
    )
    u_BitWiseShiftLeft
    (   //-------------------------------------//--------------------------------------------------
        // Inputs                              // Descriptions
        //-------------------------------------//--------------------------------------------------
        .a          ( SL_a                  ), // [I][N] Value to be shifted.
        .b          ( SL_b[O-1:0]           ), // [I][O] Amount to shift value by.
        //-------------------------------------//--------------------------------------------------
        // Outputs                             // Descriptions
        //-------------------------------------//--------------------------------------------------
        .c          ( SL_c                  )  // [O][N]
    );

    BitWiseShiftRight
    #(  //-------------------------------------//--------------------------------------------------
        // Parameter(s)                        // Descriptions
        //-------------------------------------//--------------------------------------------------
        .N          ( N                     )  //
    )
    u_BitWiseShifRight
    (   //-------------------------------------//--------------------------------------------------
        // Inputs                              // Descriptions
        //-------------------------------------//--------------------------------------------------
        .a          ( SR_a                  ), // [I][N] Value to be shifted.
        .b          ( SR_b[O-1:0]           ), // [I][O] Amount to shift value by.
        //-------------------------------------//--------------------------------------------------
        // Outputs                             // Descriptions
        //-------------------------------------//--------------------------------------------------
        .c          ( SR_c                  )  // [O][N]
    );

endmodule : ALUShift
`default_nettype wire
