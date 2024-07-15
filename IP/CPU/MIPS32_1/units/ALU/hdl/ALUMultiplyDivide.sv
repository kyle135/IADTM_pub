//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  MIPS I 32-bit ALU
// Module Name:  ALUMultiplyDivide
// Description:  All of the Multiply/Divide Instructions
// Dependencies:
// · FixedPointDivide.sv
// · FixedPointMultiply.sv
//-------------------------------------------------------------------------------------------------
`default_nettype none
module ALUMultiplyDivide
#(  //--------------------------------------//-----------------------------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//-----------------------------------------------------
    parameter integer   N = 32,             // Data Path width in bits.
    parameter integer   R = 32,             // Register Count
    parameter integer   O = $clog2(R)       // Address width for GPR registers.
)  (//--------------------------------------//-----------------------------------------------------
    // Inputs from Registered Data Sources  // Description(s)
    //--------------------------------------//-----------------------------------------------------
    input  wire [N-1:0] Instruction,        //
    input  wire [N-1:0] ProgramCounter,     //
    input  wire [N-1:0] GPR_a,              // General Purpose Register index A's data.
    input  wire [N-1:0] GPR_b,              // General Purpose Register index B's data.
    input  wire [N-1:0] GPR_c,              // General Purpose Register index C's data.
    input  wire [N-1:0] SPR_h,              // Special Purpose Register Hi data.
    input  wire [N-1:0] SPR_l,              // Special Purpose Register Lo data.
    //--------------------------------------//-----------------------------------------------------
    // Outputs from Registered Data Sources // Description(s)
    //--------------------------------------//-----------------------------------------------------    
    output reg  [N-1:0] GPR_a_dat,          // GPR a register write back data.
    output reg          GPR_a_val,          // GPR a register write back enable.
    output reg  [N-1:0] GPR_b_dat,          // GPR b register write back data.
    output reg          GPR_b_val,          // GPR b register write back enable.
    output reg  [N-1:0] GPR_c_dat,          // GPR c register write back data.
    output reg          GPR_c_val,          // GPR c register write back enable.
    output reg  [N-1:0] SPR_h_dat,          // SPR h register write back data.
    output reg          SPR_h_val,          // SPR h register write back enable.
    output reg  [N-1:0] SPR_l_dat,          // SPR l register write back data
    output reg          SPR_l_val,          // SPR l register write back enable
    output reg          SPR_o_val,          // SPR OverFlow flag 
    output reg          SPR_z_val           // SPR Zero flag
);

    //---------------------------------------------------------------------------------------------
    // Local Net Declarations.
    //---------------------------------------------------------------------------------------------
    wire [5:0] SPECIAL_OP  = 6'b000000;
    wire [5:0] SPECIAL2_OP = 6'b011100;
    //---------------------------------------------------------------------------------*/--------------------------------//-.---.-----------------------.
    // CPU Arithmetic Instructions Op Codes                                            */ Functions                      // | T |    Assembly Code      |
    //---------------------------------------------------------------------------------*/--------------------------------//-+---+-----------------------:
    wire [5:0] DIV_OP    = SPECIAL_OP; /* Divide (with overflow)                       */ wire [5:0] DIV_FUNC   = 6'h1A; // | R | div   a, b            |   
    wire [5:0] DIVU_OP   = SPECIAL_OP; /* Divide Unsigned Word                         */ wire [5:0] DIVU_FUNC  = 6'h1B; // | R | divu  a, b            |
    wire [5:0] MADD_OP   = SPECIAL2_OP;/* Multiply and Add Word to Hi, Lo              */ wire [5:0] MADD_FUNC  = 6'h00; // | R | madd  a, b            |
    wire [5:0] MADDU_OP  = SPECIAL2_OP;/* Multiply and Add Unsigned Word to Hi, Lo     */ wire [5:0] MADDU_FUNC = 6'h01; // | R | maddu a, b            |
    wire [5:0] MSUB_OP   = SPECIAL2_OP;/* Multiply and Subtract Word to Hi, Lo         */ wire [5:0] MSUB_FUNC  = 6'h04; // | R | msub  a, b            |
    wire [5:0] MSUBU_OP  = SPECIAL2_OP;/* Multiply and Subtract Unsigned Word to Hi, Lo*/ wire [5:0] MSUBU_FUNC = 6'h05; // | R | msubu a, b            |
    wire [5:0] MUL_OP    = SPECIAL2_OP;/* Multiply Word to GPR                         */ wire [5:0] MUL_FUNC   = 6'h02; // | R | mul   c, a, b         |
    wire [5:0] MULT_OP   = SPECIAL_OP; /* Multiply Word                                */ wire [5:0] MULT_FUNC  = 6'h18; // | R | mult  a, b            |
    wire [5:0] MULTU_OP  = SPECIAL_OP; /* Multiply Unsigned Word                       */ wire [5:0] MULTU_FUNC = 6'h19; // | R | multu a, b            |
    //
    reg  [  N-1:0] DIV_a, DIV_b;
    wire [2*N-1:0] DIV_c;
    reg  [  N-1:0] MUL_a, MUL_b;
    wire [2*N-1:0] MUL_c;

    //---------------------------------------------------------------------------------------------
    // Combintational Logic
    //---------------------------------------------------------------------------------------------
    // Case Z definition
    // In the casez the don't-care value can represented by the question mark (?)
    // while the High-Impedence value is represented by the letter z (z).
    always_comb begin
        DIV_a = {N{1'b0}};
        DIV_b = {N{1'b0}};
        MUL_a = {N{1'b0}};
        MUL_b = {N{1'b0}};
        {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
        {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
        {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
        {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
        {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
        {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
        casez(Instruction)
            {DIV_OP,   5'b?????, 5'b?????, 5'b00000, 5'b00000, DIV_FUNC}: begin : DIV_INSTRUCTION
                //-----------------------------------------------------------------------
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | x00 |  a  |  b  | 0x0 | 0x0 | 0x1A | DIV (Divide with overflow)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]    DIV  a, b
                // [Operation]   Lo = GPR[a] / GPR[b]; Hi = GPR[a] % GPR[b]
                // [Description] The 32-bit word value in GPR[a] is divided by the 32-bit
                // value in GPR[b], treating both operands as signed values.
                // The 32-bit quotient is placed into special ALULoOut and the 32-bit
                // remainder is placed into special ALU Hi Out.
                // No arithmetic exception occurs under any circumstances.
                DIV_a = GPR_a;
                DIV_b = GPR_b;
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b1, DIV_c[31: 0]};
                {SPR_l_val, SPR_l_dat} = {1'b1, DIV_c[63:32]};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0};
            end : DIV_INSTRUCTION
            {DIVU_OP,  5'b?????, 5'b?????, 5'b00000, 5'b00000, DIVU_FUNC}: begin : DIVU_INSTRUCTION
                //---------------------------------------------------------------------------------
                // Divide (with overflow)
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | x00 |  a  | R2  | 0x0 | 0x0 | 0x1B | DIVU (Divide Unsigned)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]    DIVU    a, b
                // [Operation]   Lo = GPR[a] / GPR[b]; Hi = GPR[a] % GPR[b]
                // [Description] Divide register GPR[a] by register GPR[b]. Leave the
                // quotient in register lo and the remainder in register hi. Note that
                // if an operand is negative, the remainder is unspecified by the MIPS
                // architecture.
                DIV_a = GPR_a;
                DIV_b = GPR_b;
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = GPR_a[31] | GPR_b[31] ?  {1'b1, 32'd0} : {1'b1, DIV_c[31: 0]}; // Remainder
                {SPR_l_val, SPR_l_dat} = {1'b1, DIV_c[63:32]}; // Dividend
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0};
            end : DIVU_INSTRUCTION
            {MADD_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, MADD_FUNC}: begin : MADD_INSTRUCTION
                //-----------------------------------------------------------------------
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | x00 |  a  |  b  | 0x0 | 0x0 | 0x18 | MADD (Multiply and Add)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]    MADD a, b
                // [Operation]   (Hi,Lo) += GPR[a] * GPR[b]
                // [Description]
                DIV_a = {N{1'b0}};
                DIV_b = {N{1'b0}};
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : MADD_INSTRUCTION
            {MADDU_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, MADDU_FUNC}: begin : MADDU_INSTRUCTION
                //-----------------------------------------------------------------------
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | x00 |  a  |  b  | 0x0 | 0x0 | 0x18 | MADDU (Multiply and Add Unsgined)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]    MADDU	a, b
                // [Operation]   (SPR[h],SPR[l]) += GPR[a] * GPR[b]
                // [Description]
                DIV_a = {N{1'b0}};
                DIV_b = {N{1'b0}};
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : MADDU_INSTRUCTION
            {MSUB_OP,   5'b?????, 5'b?????, 5'b0000, 5'b00000, MSUB_FUNC}: begin : MSUB_INSTRUCTION
                //---------------------------------------------------------------------------------
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | x1C |  a  |  b  |  c  | 0x0 | 0x04 | MSUB (Multiply and Subtract Word to Hi,Lo)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]     MSUB  a, rb
                // [Operation]    (HI || LO) - (GPR[a] * GPR[b]
                // [Description] The 32-bit word value in GPR[a] is multiplied by the 32-
                // bit value in GPR[b], treating both operands as signed values, to
                // produce a 64-bit result. The product is subtracted from the 64-bit
                // concatenated values of HI and LO.. The most significant 32 bits of the
                // result are written into HI and the least signficant 32 bits are
                // written into LO. No arithmetic exception occurs under any circumstance.
                DIV_a = {N{1'b0}};
                DIV_b = {N{1'b0}};
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : MSUB_INSTRUCTION
            {MSUBU_OP,   5'b?????, 5'b?????, 5'b0000, 5'b00000, MSUBU_FUNC}: begin : MSUBU_INSTRUCTION
                //-----------------------------------------------------------------------
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | x1C |  a  |  b  |  c  | 0x0 | 0x05 | MSUBU (Multiply and Subtract Word to Hi,Lo)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]    MSUB  a, rb
                // [Operation]   (HI || LO) - (GPR[a] * GPR[b]
                // [Description] The 32-bit word value in GPR rs is multiplied by the 32-
                // bit word value in GPR[b], treating both operands as unsigned values,
                // to produce a 64-bit result. The product is subtracted from the 64-bit
                // concatenated values of HI and LO. The most significant 32 bits of the
                // result are written into HI and the least signficant 32 bits are
                // written into LO. No arithmetic exception occurs under any circumstances.
                DIV_a = {N{1'b0}};
                DIV_b = {N{1'b0}};
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : MSUBU_INSTRUCTION
            {MUL_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, MUL_FUNC}: begin : MUL_INSTRUCTION
                //-----------------------------------------------------------------------
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | x00 |  a  |  b  |  c  | 0x0 | 0x18 | MUL (Multiply)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]    MUL		c, a, b
                // [Operation]   GPR[c] = GPR[a] * GPR[b]
                // [Description]
                DIV_a = {N{1'b0}};
                DIV_b = {N{1'b0}};
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : MUL_INSTRUCTION
            {MULT_OP,  5'b?????, 5'b?????, 5'b?????, 5'b00000, MULT_FUNC}: begin : MULT_INSTRUCTION
                //-----------------------------------------------------------------------
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | x00 |  a  |  b  | 0x0 | 0x0 | 0x18 | MULT (Multiply)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]   MULT a, b
                // [Operation]  (Hi,Lo) = GPR[a] * GPR[b]
                DIV_a = {N{1'b0}};
                DIV_b = {N{1'b0}};
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : MULT_INSTRUCTION
            {MULTU_OP, 5'b?????, 5'b?????, 5'b?????, 5'b00000, MULTU_FUNC}: begin : MULTU_INSTRUCTION
                //-----------------------------------------------------------------------
                //    31 26 25 21 20 16 15 11 10  6 5    0
                //   .-----.-----.-----.-----.-----.------.
                // R | 0x0 |  a |   b  | 0x0 | 0x0 | 0x19 |  MULTU (Multiply Unsigned)
                //   '-----'-----'-----'-----'-----'------'
                //     |6|   |5|   |5|   |5|   |5|   |6|
                // [Assembly]    MULTU	a, b
                // [Operation]   (Hi,Lo) = GPR[a] * GPR[b]
                // [Description] Multiply registers GRP[a] and GPR[b]. Leave the low-
                // order word of the product in register lo and the high-order word in
                // register hi.
                DIV_a = {N{1'b0}};
                DIV_b = {N{1'b0}};
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end : MULTU_INSTRUCTION
            default: begin
                DIV_a = {N{1'b0}};
                DIV_b = {N{1'b0}};
                MUL_a = {N{1'b0}};
                MUL_b = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0, 1'b0 };
            end
        endcase
    end

    //---------------------------------------------------------------------------------------------
    // Module Instances
    //---------------------------------------------------------------------------------------------
    FixedPointMultiply
    #(  //-------------------------------//--------------------------------------------------------
        // Parameter(s)                  // Description(s)
        //-------------------------------//--------------------------------------------------------
        .N          ( N               )  // Width of operands A, B, C in bits.
    )                                    //
    u_FixedPointMultiply                 //
    (   //-------------------------------//--------------------------------------------------------
        // Arithmetic Inputs             // Direction, Size & Description(s)
        //-------------------------------//--------------------------------------------------------
        .a          ( MUL_a           ), // [I][N] Operand A for a * b operation.
        .b          ( MUL_b           ), // [I][N] Operand A for a * b operation.
        //-------------------------------//--------------------------------------------------------
        // Arithmetic Outputs            // Direction, Size & Description(s)
        //-------------------------------//--------------------------------------------------------
        .c          ( MUL_c           )  // [O][2N] C for c = a * b operation.
        );

    FixedPointDivide
    #(  //-------------------------------//--------------------------------------------------------
        // Parameter(s)                  // Description(s)
        //-------------------------------//--------------------------------------------------------
        .N          ( N               )  // Width of data in bits.
    )                                    //
    u_FixedPointDivide                   //
    (   //-------------------------------//--------------------------------------------------------
        // Arithmetic Inputs             // Direction, Size & Description(s)
        //-------------------------------//--------------------------------------------------------
        .a          ( DIV_a           ), // [I][N] Operand A for c = a / b operation.
        .b          ( DIV_b           ), // [I][N] Operand B for c = a / b operation.
        //-------------------------------//-------------------------------------------------------
        // Arithmetic Outputs            // Direction, Size & Description(s)
        //-------------------------------//-------------------------------------------------------
        .c          ( DIV_c           )  // [I][2N] Result C for c = a / b operation.
    );

endmodule : ALUMultiplyDivide
`default_nettype wire