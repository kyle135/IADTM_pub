//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  MIPS I 32-bit ALU
// Module Name:  ALU
// Description:  All of the Addition and Subtraction Operations
// Dependencies:
// · FixedPointAddSubtract.sv
// · FixedPointCountLeadingZeros.sv
// · FixedPointCountLeadingOnes.sv
//-----------------------------------------------------------------------------
`default_nettype none
module ALUAddSubtract
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Descriptions
    //--------------------------------------//---------------------------------
    parameter integer   N = 32,             // Data Path width in bits.
    parameter integer   R = 32,             // Register Count
    parameter integer   O = $clog2(R)       //
)  (//--------------------------------------//---------------------------------
    // Inputs from Registered Data Sources  // Descriptions
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] Instruction,        //
    input  wire [N-1:0] ProgramCounter,     //
    input  wire [N-1:0] GPR_a,              // GPR a register read data.
    input  wire [N-1:0] GPR_b,              // GPR b register read data.
    input  wire [N-1:0] GPR_c,              // GPR c register read data.
    input  wire [N-1:0] SPR_h,              // Special Purpose Register Hi data.
    input  wire [N-1:0] SPR_l,              // Special Purpose Register Lo data.
    //--------------------------------------//-----------------------------------------------------
    // Outputs from Registered Data Sources // Descriptions
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


    //-----------------------------------------------------------------------------------
    // Local Net Declarations.
    //-----------------------------------------------------------------------------------
    logic [5:0] ADD_OP    = 6'h00; /* Add Word (overflow)         */ logic [5:0] ADD_FUNC     = 6'h20; // | R | add   c, a, b         |
    logic [5:0] ADDI_OP   = 6'h08; /* Add Immediate Word          */                                   // | I | addi  c, a, immediate |
    logic [5:0] ADDIU_OP  = 6'h09; /* Add Immediate Unsigned Word */                                   // | I | addiu b, a, immediate |
    logic [5:0] ADDU_OP   = 6'h00; /* Add Unsigned Word           */ logic [5:0] ADDU_FUNC    = 6'h21; // | R | addu  c, a, b         |
    logic [5:0] CLO_OP    = 6'h1C; /* Count Leading Ones in Word  */ logic [5:0] CLO_FUNC     = 6'h21; // | R | clo   c, a            |
    logic [5:0] CLZ_OP    = 6'h1C; /* Count Leading Zeros in Word */ logic [5:0] CLZ_FUNC     = 6'h20; // | R | clz   c, a            |
    logic [5:0] SUB_OP    = 6'h00; /* Subtract (with overflow)    */ logic [5:0] SUB_FUNC     = 6'h22; // | R | sub                   | 
    logic [5:0] SUBU_OP   = 6'h00; /* Subtract Unsigned Word      */ logic [5:0] SUBU_FUNC    = 6'h23; // | R | subu                  | 


    wire [ 15:0] Imm16;
    reg          subtract;
    reg  [N-1:0] ADDSUBTRACT_a, ADDSUBTRACT_b; 
    wire [N-1:0] ADDSUBTRACT_c;
    reg  [N-1:0] CLO_a;
    wire [O-1:0] CLO_c;
    reg  [N-1:0] CLZ_a;
    wire [O-1:0] CLZ_c;
    wire         ADDSUBTRACT_co;
    

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    assign Imm16 = Instruction[15:0];

    // Case Z definition
    // In the casez the don't-care value can represented by the question mark (?)
    // while the High-Impedence value is represented by the letter z (z).    
    always_comb begin
        if (Instruction == {N{1'b0}}) begin
            ADDSUBTRACT_a = {N{1'b0}};
            ADDSUBTRACT_b = {N{1'b0}};
            CLO_a = {N{1'b0}};
            CLZ_a = {N{1'b0}};
            ADDSUBTRACT_a = {N{1'b0}};
            ADDSUBTRACT_b = {N{1'b0}};
            subtract = 1'b0;
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
                    ADDSUBTRACT_a = GPR_a;             
                    ADDSUBTRACT_b = GPR_b;
                    subtract = 1'b0;
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = ADDSUBTRACT_co ? {1'b0, GPR_c} : {1'b1, ADDSUBTRACT_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {ADDSUBTRACT_co, ADDSUBTRACT_c == 32'd0};
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
                    ADDSUBTRACT_a = GPR_a;             
                    ADDSUBTRACT_b = {{16{Imm16[15]}}, Imm16};
                    subtract = 1'b0;
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = ADDSUBTRACT_co ? {1'b0, GPR_b} : {1'b1, ADDSUBTRACT_c};
                    {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {ADDSUBTRACT_co, ADDSUBTRACT_c == 32'd0};
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
                    ADDSUBTRACT_a = GPR_a;             
                    ADDSUBTRACT_b = {{16{Imm16[15]}}, Imm16};
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b1, ADDSUBTRACT_c};
                    {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {1'b0, ADDSUBTRACT_c == 32'd0};
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
                    ADDSUBTRACT_a = GPR_a;             
                    ADDSUBTRACT_b = GPR_b;
                    subtract = 1'b0;
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = {1'b1, ADDSUBTRACT_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {1'b0, ADDSUBTRACT_c == 32'd0};
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
                    ADDSUBTRACT_a = {N{1'b0}};
                    ADDSUBTRACT_b = {N{1'b0}};
                    subtract = 1'b0;
                    CLO_a = GPR_a;             
                    CLZ_a = {N{1'b0}};                    
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
                    ADDSUBTRACT_a = {N{1'b0}};
                    ADDSUBTRACT_b = {N{1'b0}};
                    subtract = 1'b0;
                    CLO_a = {N{1'b0}};
                    CLZ_a = GPR_a;                  
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
                    ADDSUBTRACT_a = GPR_a;             
                    ADDSUBTRACT_b = GPR_b;
                    subtract = 1'b1;
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = ADDSUBTRACT_co ? {1'b0, GPR_c} : {1'b1, ADDSUBTRACT_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    {SPR_o_val, SPR_z_val} = {ADDSUBTRACT_co, ADDSUBTRACT_c == 32'd0};
                end : SUB_INSTRUCTION            
                {SUBU_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, SUBU_FUNC}: begin : SUB_UNSIGNED_INSTRUCTION
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
                    // Control Signals
                    ADDSUBTRACT_a = GPR_a;             
                    ADDSUBTRACT_b = GPR_b;
                    subtract = 1'b1;
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
                    {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                    {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                    {GPR_c_val, GPR_c_dat} = {1'b1, ADDSUBTRACT_c};
                    {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                    {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                    // No integer overflow exception occurs under any circumstance.
                    {SPR_o_val, SPR_z_val} = {1'b0, ADDSUBTRACT_c == 32'd0};
                end : SUB_UNSIGNED_INSTRUCTION
                default: begin
                    ADDSUBTRACT_a = {N{1'b0}};
                    ADDSUBTRACT_b = {N{1'b0}};
                    subtract = 1'b0;
                    CLO_a = {N{1'b0}};
                    CLZ_a = {N{1'b0}};
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

    //-------------------------------------------------------------------------
    // Module Instances
    //-------------------------------------------------------------------------
    FixedPointAddSubtract
    #(  //--------------------------------//-----------------------------------
        // Parameters                     // Descriptions
        //--------------------------------//-----------------------------------
        .N        ( N                  ), // Width of operands A, B, C in bits.
        .MODEL    ( "DataFlow"       ), // Modeling Technique
        .TOP      ( "CarryLookAheadAdd")  // TOP to be used.
    )                                     //
    u_FixedPointAddSubtract               //
    (   //--------------------------------//-----------------------------------
        // Controls                       // Direction, Size & Descriptions
        //--------------------------------//-----------------------------------
        .subtract ( subtract           ), // [I][1] Subtract operation select
        //--------------------------------//-----------------------------------
        // Inputs                         // Direction, Size & Descriptions
        //--------------------------------//-----------------------------------
        .a        ( ADDSUBTRACT_a      ), // [I][N] Operand A
        .b        ( ADDSUBTRACT_b      ), // [I][N] Operand B
        //--------------------------------//-----------------------------------
        // Outputs                        // Direction, Size & Descriptions
        //--------------------------------//-----------------------------------
        .c        ( ADDSUBTRACT_c      ), // [O][N] Result C
        .co       ( ADDSUBTRACT_co     )  // [O][1] Add Overflow
    );


    FixedPointCountLeadingZeros
    #(  //--------------------------------//-----------------------------------
        // Parameters                     // Descriptions
        //--------------------------------//-----------------------------------
        .N        ( N                  )  // Width of operands A, B, C in bits.
    )                                     //
    u_FixedPointCountLeadingZeros         //
    (   //--------------------------------//-----------------------------------
        // Inputs                         // Descriptions
        //--------------------------------//-----------------------------------
        .a        ( CLZ_a              ), // [I][N] Operand A
        //--------------------------------//-----------------------------------
        // Outputs                        // Descriptions
        //--------------------------------//-----------------------------------
        .c        ( CLZ_c              )  // [O][N] Result C
    );

    FixedPointCountLeadingOnes
    #(  //--------------------------------//-----------------------------------
        // Parameters                     // Descriptions
        //--------------------------------//-----------------------------------
        .N        ( N                  )  // Datapath width in bits.
    )
    u_FixedPointCountLeadingOnes
    (   //--------------------------------//-----------------------------------
        // Inputs                         // Descriptions
        //--------------------------------//-----------------------------------
        .a        ( CLO_a              ), // [I][N] Operand A
        //--------------------------------//-----------------------------------
        // Outputs                        // Descriptions
        //--------------------------------//-----------------------------------
        .c        ( CLO_c              )  // [O][N] Result C
    );
endmodule : ALUAddSubtract
`default_nettype wire
