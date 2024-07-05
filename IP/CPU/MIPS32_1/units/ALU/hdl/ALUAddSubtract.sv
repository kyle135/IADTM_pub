//-------------------------------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Design Name:  MIPS I 32-bit ALU
// Module Name:  ALU
// Description:  All of the Addition and Subtraction Operations
// Dependencies:
// · FixedPointSubtract.sv
// · FixedPointAdd.sv
// · FixedPointCountLeadingZeros.sv
// · FixedPointCountLeadingOnes.sv
//-------------------------------------------------------------------------------------------------
`default_nettype none
module ALUAddSubtract
#(  //--------------------------------------//-----------------------------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//-----------------------------------------------------
    parameter integer   N = 32,             // Data Path width in bits.
    parameter integer   R = 32,             // Register Count
    parameter integer   O = $clog2(R)       //
)  (//--------------------------------------//-----------------------------------------------------
    // Inputs from Registered Data Sources  // Description(s)
    //--------------------------------------//-----------------------------------------------------
    input  wire [N-1:0] Instruction,        //
    input  wire [N-1:0] ProgramCounter,     //
    input  wire [N-1:0] GPR_a,              // GPR a register read data.
    input  wire [N-1:0] GPR_b,              // GPR b register read data.
    input  wire [N-1:0] GPR_c,              // GPR c register read data.
    input  wire [N-1:0] SPR_h,              // Special Purpose Register Hi data.
    input  wire [N-1:0] SPR_l,              // Special Purpose Register Lo data.
    //--------------------------------------//-----------------------------------------------------
    // Outputs from Registered Data Sources // Description(s)
    //--------------------------------------//-----------------------------------------------------    
    output reg  [N-1:0] GPR_a_dat,          //
    output reg          GPR_a_val,          //
    output reg  [N-1:0] GPR_b_dat,          //
    output reg          GPR_b_val,          //
    output reg  [N-1:0] GPR_c_dat,          //
    output reg          GPR_c_val,          //
    output reg  [N-1:0] SPR_h_dat,          //
    output reg          SPR_h_val,          //
    output reg  [N-1:0] SPR_l_dat,          //
    output reg          SPR_l_val,          // 
    output reg          SPR_o_val,          // OverFlow Flag
    output reg          SPR_z_val           // Zero Flag
);

    import MIPS32_1_hdl_pkg::*;

    //-----------------------------------------------------------------------------------
    // Local Net Declarations.
    //-----------------------------------------------------------------------------------
    wire [ 15:0] Imm16;
    reg  [N-1:0] ADD_a, ADD_b; 
    wire [N-1:0] ADD_c;
    reg  [N-1:0] CLO_a;
    wire [O-1:0] CLO_c;
    reg  [N-1:0] CLZ_a;
    wire [O-1:0] CLZ_c;
    reg  [N-1:0] SUB_a, SUB_b;
    wire [N-1:0] SUB_c;
    wire         ADD_carry_out; 
    wire         SUB_carry_out;

    //------------------------------------------------------------------------------------
    // Combinational Logic
    //------------------------------------------------------------------------------------
    assign Imm16 = Instruction[15:0];

    // Case Z definition
    // In the casez the don't-care value can represented by the question mark (?)
    // while the High-Impedence value is represented by the letter z (z).    
    always_comb begin
        if (Instruction == {N{1'b0}}) begin
            ADD_a = {N{1'b0}};
            ADD_b = {N{1'b0}};
            CLO_a = {N{1'b0}};
            CLZ_a = {N{1'b0}};
            SUB_a = {N{1'b0}};
            SUB_b = {N{1'b0}};
            {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
            {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
            {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
            {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
            {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
            {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
        end
        else begin
            casez(Instruction)
                //---------------------------------------------------------------------------
                // Arithmetic
                //---------------------------------------------------------------------------
                {ADD_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, ADD_FUNC}: begin : ADD_INSTRUCTION
                    //--------------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 0 0 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|           
                    // [Name]         Add Word (overflow)
                    // [Assembly]     ADD c, a, b
                    // [Operation]    {OF, GPR[c]} <- GPR[a] + GPR[b]
                    // [Description]  The 32-bit word value in GPR[a] is added to the 32-bit
                    // value in GPR[b] to produce a 32-bit result.
                    // • If the addition results in 32-bit 2’s complement arithmetic
                    //   overflow, the destination register is not modified and an Integer
                    //   Overflow exception occurs.
                    // • If the addition does not overflow, the 32-bit result is placed into 
                    //   GPR[c].
                    ADD_a = GPR_a;             
                    ADD_b = GPR_b;
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    SUB_a = {N{1'b0}};
                    SUB_b = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = ADD_carry_out ? {1'b0, GPR_c} : {1'b1, ADD_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {ADD_carry_out, ADD_c == 32'd0};
                end : ADD_INSTRUCTION
                {ADDI_OP,  5'b?????, 5'b?????, 16'b????????????????}: begin : ADD_IMMEDIATE_SIGNED_INSTRUCTION
                    //--------------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15                            0
                    //   .-------------.-----------.-----------.---------------------------------.
                    // I | 0 0 1 0 0 0 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
                    //   '-------------'-----------'-----------'---------------------------------'
                    //         |6|          |5|         |5|                     |16|
                    // [Name]        Add Immediate Signed Word
                    // [Assembly]    ADDI b, a, Imm16
                    // [Operation]   GPR[b] <- GPR[a] + {16{Imm16[15]}, Imm16[15:0]}
                    // [Description] The 16-bit immediate is sign-extended and added to the contents of
                    // general register GPR[a] to form a 32-bit result. The result is placed in general
                    // register GPR[b]. An overflow exception occurs if the two highest order carry-out
                    // bits differ (2’s-complement overflow). The destination register GPR[b] is not 
                    // modified when an integer overflow exception occurs.
                    ADD_a = GPR_a;             
                    ADD_b = {{16{Imm16[15]}}, Imm16};
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    SUB_a = {N{1'b0}};
                    SUB_b = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = ADD_carry_out ? {1'b0, GPR_b} : {1'b1, ADD_c};
                    {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {ADD_carry_out, ADD_c == 32'd0};
                end : ADD_IMMEDIATE_SIGNED_INSTRUCTION
                {ADDIU_OP, 5'b?????, 5'b?????, 16'b????????????????}: begin : ADD_IMMEDIATE_UNSIGNED_INSTRUCTION
                    //--------------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15                            0
                    //   .-------------.-----------.-----------.---------------------------------.
                    // I | 0 0 1 0 0 1 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
                    //   '-------------'-----------'-----------'---------------------------------'
                    //         |6|          |5|         |5|                     |16|
                    // [Name]        Add Immediate Unsigned Word
                    // [Assembly]    ADDIU 
                    // [Operation]   GPR[b] <- GPR[a] + {16{Imm16[15]}, Imm16[15:0]}
                    // [Description] The 16-bit signed immediate is added to the 32-bit value 
                    // in GPR[a] and the 32-bit arithmetic result is placed into GPR[b].
                    // No Integer Overflow exception occurs under any circumstances.
                    ADD_a = GPR_a;             
                    ADD_b = {{16{Imm16[15]}}, Imm16};
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    SUB_a = {N{1'b0}};
                    SUB_b = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b1, ADD_c};
                    {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {1'b0, ADD_c == 32'd0};
                end : ADD_IMMEDIATE_UNSIGNED_INSTRUCTION
                {ADDU_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, ADDU_FUNC}: begin : ADD_UNSIGNED_INSTRUCTION
                    //-----------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 0 1 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|
                    // [Name]        Add Unsigned Word
                    // [Assembly]    ADDU   c, a, b
                    // [Operation]   GPR[c] = GPR[a] + GPR[b]
                    // [Description] The 32-bit word value in GPR[b] is added to the 32-bit
                    // value in GPR[a] and the 32-bit arithmetic result is placed into GPR[c].
                    // No Integer Overflow exception occurs under any circumstances.
                    ADD_a = GPR_a;             
                    ADD_b = GPR_b;
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    SUB_a = {N{1'b0}};
                    SUB_b = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = {1'b1, ADD_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {1'b0, ADD_c == 32'd0};
                end : ADD_UNSIGNED_INSTRUCTION
                {CLO_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, CLO_FUNC}: begin : COUNT_LEADING_ONES_INSTRUCTION
                    //-----------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 0 1 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|
                    //    31 26 25 21 20 16 15 11 10  6 5    0
                    //   .-----.-----.-----.-----.-----.------.
                    // R | x00 |  a  |  b  |  c  | 0x0 | 0x22 | CLO (Count Leading Ones)
                    //   '-----'-----'-----'-----'-----'------'
                    //     |6|   |5|   |5|   |5|   |5|    |6|
                    // [Assembly]    CLO  c, a
                    // [Operation]   GPR[c] = count_leading_ones(GPR[a])
                    // [Description] Bits 31..0 of GPR[a] are scanned from most significant 
                    // to least significant bit. The number of leading ones is counted and 
                    // the result is written to GPR[c]. If all of bits 31..0 were set in 
                    // GPR[a], the result written to GPR[b] is 32.
                    ADD_a = {N{1'b0}};
                    ADD_b = {N{1'b0}};
                    CLO_a = GPR_a;             
                    CLZ_a = {N{1'b0}};
                    SUB_a = {N{1'b0}};
                    SUB_b = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = &GPR_a ? {1'b0, CLO_c} : {1'b1, CLO_c};;
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
                end : COUNT_LEADING_ONES_INSTRUCTION
                {CLZ_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, CLZ_FUNC}: begin : COUNT_LEADING_ZEROS_INSTRUCTION
                    //-----------------------------------------------------------------------
                    //    31 26 25 21 20 16 15 11 10  6 5    0
                    //   .-----.-----.-----.-----.-----.------.
                    // R | x00 |  a  |  b  |  c  | 0x0 | 0x22 | CLZ (Count Leading Zeros)
                    //   '-----'-----'-----'-----'-----'------'
                    //     |6|   |5|   |5|   |5|   |5|   |6|
                    // [Assembly]    CLZ  c, a
                    // [Operation]   GPR[c] = count_leading_zeros(GPR[a])
                    // [Description] Bits 31..0 of GPR[a] are scanned from most significant
                    // to least significant bit. The number of leading zeros is counted and 
                    // the result is written to GPR[c]. If no bits were set in GPR[a], the 
                    // result written to GPR[b] is 32.
                    ADD_a = {N{1'b0}};
                    ADD_b = {N{1'b0}};
                    CLO_a = {N{1'b0}};
                    CLZ_a = GPR_a;             
                    SUB_a = {N{1'b0}};
                    SUB_b = {N{1'b0}};            
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = &GPR_a ? {1'b1, 32'd32} : {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = &GPR_a ? {1'b0,  CLZ_c} : {1'b1, CLO_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
                end : COUNT_LEADING_ZEROS_INSTRUCTION            
                {SUB_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, SUB_FUNC}: begin : SUB_INSTRUCTION
                    //--------------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 1 0 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|
                    // [Name]        Subtraction with overflow
                    // [Assembly]    SUB  c, a, b
                    // [Operation]   GPR[c] = GPR[a] - GPR[b]
                    // [Description] The 32-bit word value in GPR[b] is subtracted from the 
                    // 32-bit in GPR[a] to produce a 32-bit reuslt. If the subtraction 
                    // results in 32-bit 2's complement arithmetic overflow, then the 
                    // destination register is not modified and an Integer Overflow exception
                    // occurs. If it does not overflow, the 32-bit result is placed into
                    // GPR[c]
                    ADD_a = {N{1'b0}};
                    ADD_b = {N{1'b0}};
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    SUB_a = GPR_a;             
                    SUB_b = GPR_b;
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = SUB_carry_out ? {1'b0, GPR_c} : {1'b1, SUB_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {SUB_carry_out, SUB_c == 32'd0};
                end : SUB_INSTRUCTION            
                {SUBU_OP,  5'b?????, 5'b?????, 5'b?????, 5'b?????, SUBU_FUNC}: begin : SUB_UNSIGNED_INSTRUCTION
                    //-----------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 1 1 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|
                    // [Name]        Subtraction Unsigned Word
                    // [Assembly]    SUBU c, a, b
                    // [Operation]   GPR[c] = GPR[a] - GPR[b]
                    // [Description] The 32-bit word value in GPR[b] is subtracted from the 32-bit 
                    // value in GPR[a] and the 32-bit arithmetic result and placed into GPR[c].
                    ADD_a = {N{1'b0}};
                    ADD_b = {N{1'b0}};
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    SUB_a = GPR_a;             
                    SUB_b = GPR_b;
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = {1'b1, SUB_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    // No integer overflow exception occurs under any circumstance.
                    {SPR_o_val, SPR_z_val} = {1'b0, SUB_c == 32'd0};
                end : SUB_UNSIGNED_INSTRUCTION
                default: begin
                    ADD_a = {N{1'b0}};
                    ADD_b = {N{1'b0}};
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    SUB_a = {N{1'b0}};
                    SUB_b = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
                end
            endcase
        end
    end

    //---------------------------------------------------------------------------------------------
    // Module Instances
    //---------------------------------------------------------------------------------------------
    FixedPointAdd
    #(  //-------------------------------------//--------------------------------------------------
        // Parameter(s)                        // Description(s)
        //-------------------------------------//--------------------------------------------------
        .N          ( N                     )  // Width of operands A, B, C in bits.
    )                                          //
    u_FixedPointAdd                            //
    (   //-------------------------------------//--------------------------------------------------
        //                                     // Direction, Size & Description(s)
        //-------------------------------------//----------------------------------------------
        .a          ( ADD_a                 ), // [I][N] Operand A for A + B + Carry In
        .b          ( ADD_b                 ), // [I][N] Operand B for A + B + Carry In
        .carry_in   ( 1'b0                  ), // [I][1] Operand Carry In for A + B + Carry In
        //-------------------------------------//----------------------------------------------
        //                                     // Direction, Size & Description(s)
        //-------------------------------------//----------------------------------------------
        .c          ( ADD_c                 ), // [O][N] Add Result c.
        .carry_out  ( ADD_carry_out         )  // [O][1] Add Overflow
    );

    FixedPointSubtract
    #(  //-------------------------------------//--------------------------------------------------
        // Parameter(s)                        // Description(s)
        //-------------------------------------//--------------------------------------------------
        .N          ( N                     )  // Width of operands A, B, C in bits.
    )                                          //
    u_FixedPointSubtract                       //
    (   //-------------------------------------//--------------------------------------------------
        //                                     // Direction, Size & Description(s)
        //-------------------------------------//--------------------------------------------------
        .a          ( SUB_a                 ), // [I][N] Operand A for A - B - Carry In
        .b          ( SUB_b                 ), // [I][N] Operand B for A - B - Carry In
        .carry_in   ( 1'b0                  ), // [I][1] Operand Carry In for A - B - Carry In
        //-------------------------------------//--------------------------------------------------
        //                                     // Direction, Size & Description(s)
        //-------------------------------------//--------------------------------------------------
        .c          ( SUB_c                 ), // [O][N] Subtract Result c.
        .carry_out  ( SUB_carry_out         )  // [O][1] Subtract Overflow
    );

    FixedPointCountLeadingZeros
    #(  //-------------------------------------//--------------------------------------------------
        // Parameter(s)                        // Descriptions
        //-------------------------------------//--------------------------------------------------
        .N          ( N                     )  //
    )                                          //
    u_FixedPointCountLeadingZeros              //
    (   //-------------------------------------//--------------------------------------------------
        // Inputs                              // Descriptions
        //-------------------------------------//--------------------------------------------------
        .a          ( CLZ_a                 ), //
        //-------------------------------------//--------------------------------------------------
        // Outputs                             // Descriptions
        //-------------------------------------//--------------------------------------------------
        .c          ( CLZ_c                 )  //
    );

    FixedPointCountLeadingOnes
    #(  //-------------------------------------//--------------------------------------------------
        // Parameter(s)                        // Descriptions
        //-------------------------------------//--------------------------------------------------
        .N          ( N                     )  //
    )
    u_FixedPointCountLeadingOnes
    (   //-------------------------------------//-------------------------------------
        // Inputs                              // Descriptions
        //-------------------------------------//-------------------------------------
        .a          ( CLO_a                 ), //
        //-------------------------------------//-------------------------------------
        // Outputs                             // Descriptions
        //-------------------------------------//-------------------------------------
        .c          ( CLO_c                 )  //
    );
endmodule : ALUAddSubtract
`default_nettype wire
