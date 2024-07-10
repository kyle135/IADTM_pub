//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  MIPS I 32-bit ALU
// Module Name:  ALULogical
// Description:  All of the logical instructions.
// Dependencies:
// · BitWiseAND.sv
// · BitWiseNAND.sv
// · BitWiseNOR.sv
// · BitWiseOR.sv
// · BitWiseXNOR.sv
// · BitWiseXOR.sv
//-----------------------------------------------------------------------------
`default_nettype none
module ALULogical
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter integer   N = 32,             // Data Path width in bits.
    parameter integer   R = 32,             // Register Count
    parameter integer   O = $clog2(R)       //
)  (//--------------------------------------//---------------------------------
    // Inputs from Registered Data Sources  // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] Instruction,        // Encoded ALU Operation Commands from ALU Decoder
    input  wire [N-1:0] ProgramCounter,     //
    input  wire [N-1:0] GPR_a,              // General Purpose Register index A's data.
    input  wire [N-1:0] GPR_b,              // General Purpose Register index B's data.
    input  wire [N-1:0] GPR_c,              // General Purpose Register index C's data.
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
    output reg          SPR_o_val,          // Overflow
    output reg          SPR_z_val           // Zero
);
    
    import MIPS32_1_hdl_pkg::*;

    //-----------------------------------------------------------------------------------
    // Local Net Declarations.
    //-----------------------------------------------------------------------------------
    reg  [N-1:0] AND_a, AND_b;
    wire [N-1:0] AND_c;
    reg  [N-1:0] NAND_a, NAND_b;
    wire [N-1:0] NAND_c;
    reg  [N-1:0] NOR_a, NOR_b;
    wire [N-1:0] NOR_c;
    reg  [N-1:0] OR_a, OR_b;
    wire [N-1:0] OR_c;
    reg  [N-1:0] XNOR_a, XNOR_b;
    wire [N-1:0] XNOR_c;
    reg  [N-1:0] XOR_a, XOR_b;
    wire [N-1:0] XOR_c;
    
    //------------------------------------------------------------------------------------
    // Combinational Logic
    //------------------------------------------------------------------------------------
    // Case Z definition
    // In the casez the don't-care value can represented by the question mark (?)
    // while the High-Impedence value is represented by the letter z (z).
    always_comb begin
        AND_a  = {N{1'b0}};
        AND_b  = {N{1'b0}};
        NAND_a = {N{1'b0}};
        NAND_b = {N{1'b0}};
        NOR_a  = {N{1'b0}};
        NOR_b  = {N{1'b0}};
        OR_a   = {N{1'b0}};
        OR_b   = {N{1'b0}};
        XNOR_a = {N{1'b0}};
        XNOR_b = {N{1'b0}};
        XOR_a  = {N{1'b0}};
        XOR_b  = {N{1'b0}};
        {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
        {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
        {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
        {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
        {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
        {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
        casez(Instruction)
            {AND_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, AND_FUNC}: begin : AND_INSTRUCTION
                //-------------------------------------------------------------------------------------
                //  31 26 25 21 20 16 15 11 10 06 05   0
                // .-----.-----.-----.-----.-----.------.
                // | x23 | a | rt  |    immediate     | AND (and)
                // '-----'-----'-----'-----'-----'------'
                //   |6|   |5|   |5|   |5|   |5|    |6|
                // Format: I
                // Purpose:
                // Description: MEM[$s + offset] = $t
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NAND_a = {N{1'b0}};
                NAND_b = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XNOR_a = {N{1'b0}};
                XNOR_b = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : AND_INSTRUCTION
            {ANDI_OP,  5'b?????, 5'b?????, 16'b????????????????}: begin : AND_IMMEDIATE_INSTRUCTION
                //  31 26 25 21 20 16 15              00
                // .-----.-----.-----.------------------.
                // | 0xC | a | rt  |    immediate     | ANDI (And Immediate)
                // '-----'-----'-----'------------------'
                //   6     5     5            16
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NAND_a = {N{1'b0}};
                NAND_b = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XNOR_a = {N{1'b0}};
                XNOR_b = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : AND_IMMEDIATE_INSTRUCTION
            {OR_OP,    5'b?????, 5'b?????, 5'b?????, 5'b00000, OR_FUNC}: begin : OR_INSTRUCTION
                //  31 26 25 21 20 16 15 11 10 06 05  00
                // .-----.-----.-----.-----.-----.------.
                // | 0x0 | a | rt  | rd  | 0x0 | 0x25 | OR (or)
                // '-----'-----'-----'-----'-----'------'
                //   |6|   |5|   |5|   |5|   |5|    |6|
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NAND_a = {N{1'b0}};
                NAND_b = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XNOR_a = {N{1'b0}};
                XNOR_b = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : OR_INSTRUCTION
            {ORI_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, ORI_FUNC}: begin : OR_IMMEDIATE_INSTRUCTION
                //  31 26 25 21 20 16 15 11 10 06 05  00
                // .-----.-----.-----.-----.-----.------.
                // | 0x0 | a | rt  | rd  | 0x0 | 0x25 | OR (or)
                // '-----'-----'-----'-----'-----'------'
                //   |6|   |5|   |5|   |5|   |5|    |6|
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NAND_a = {N{1'b0}};
                NAND_b = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XNOR_a = {N{1'b0}};
                XNOR_b = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : OR_IMMEDIATE_INSTRUCTION
            {XOR_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, XOR_FUNC}: begin : XOR_INSTRUCTION
                //  31 26 25 21 20 16 15 11 10 06 05  00
                // .-----.-----.-----.-----.-----.------.
                // | 0x0 | a | rt  | rd  | 0x0 | 0x25 | XOR (xor)
                // '-----'-----'-----'-----'-----'------'
                //   |6|   |5|   |5|   |5|   |5|    |6|
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NAND_a = {N{1'b0}};
                NAND_b = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XNOR_a = {N{1'b0}};
                XNOR_b = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : XOR_INSTRUCTION
            {NOR_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, NOR_FUNC}: begin : NOR_INSTRUCTION
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NAND_a = {N{1'b0}};
                NAND_b = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XNOR_a = {N{1'b0}};
                XNOR_b = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : NOR_INSTRUCTION
            default: begin
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NAND_a = {N{1'b0}};
                NAND_b = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XNOR_a = {N{1'b0}};
                XNOR_b = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end
        endcase
    end

    //---------------------------------------------------------------------------------------------
    // Module Instances
    //---------------------------------------------------------------------------------------------
    BitWiseAND
    #(  //----------------------//--------------------------------------------------------
        // Parameter(s)         // Description(s)
        //----------------------//--------------------------------------------------------
        .N ( N               )  // Width of data in bits.
    )                           //
    u_BitWiseAND                //
    (   //----------------------//--------------------------------------------------------
        // Register Data        // Direction, Size & Description(s)
        //----------------------//--------------------------------------------------------
        .a ( AND_a               ), // [I][DW] (rs) Source register data
        .b ( AND_b               ), // [I][DW] (rd) Destination register data
        //----------------------//--------------------------------------------------------
        // Arithmetic ALUOut    // Direction, Size & Description(s)
        //----------------------//--------------------------------------------------------
        .c ( AND_c    )  // [O][DW]
    );

    BitWiseNAND
    #(  //---------------------//--------------------------------------------------------
        // Parameter(s)        // Description(s)
        //---------------------//--------------------------------------------------------
        .N ( N              )  // Width of data in bits.
    )                          //
    u_BitWiseNAND              //
    (   //---------------------//--------------------------------------------------------
        // Register Data       // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .a ( NAND_a         ), // [I][N] (rs) Source register data
        .b ( NAND_b         ), // [I][N] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic ALUOut   // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .c ( NAND_c         )  // [O][N]
    );

    BitWiseNOR
    #(  //---------------------//--------------------------------------------------------
        // Parameter(s)        // Description(s)
        //---------------------//--------------------------------------------------------
        .N ( N              )  // Width of data in bits.
    )                          //
    u_BitWiseNOR               //
    (   //---------------------//--------------------------------------------------------
        // Register Data       // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .a ( NOR_a          ), // [I][DW] (rs) Source register data
        .b ( NOR_b          ), // [I][DW] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic ALUOut   // Description(s)
        //---------------------//--------------------------------------------------------
        .c ( NOR_c          )  // [O][DW]
    );

    BitWiseOR
    #(  //---------------------//--------------------------------------------------------
        // Parameter(s)        // Description(s)
        //---------------------//--------------------------------------------------------
        .N ( N              )  // Width of data in bits.
    )                          //
    u_BitWiseOR                //
    (   //---------------------//--------------------------------------------------------
        // Register Data       // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .a ( OR_a           ), // [I][DW] (rs) Source register data
        .b ( OR_b           ), // [I][DW] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic Result   // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .c ( OR_c            )  // [O][DW]
    );

    BitWiseXNOR
    #(  //---------------------//--------------------------------------------------------
        // Parameter(s)        // Description(s)
        //---------------------//--------------------------------------------------------
        .N ( N              )  // Width of data in bits.
    )                          //
    u_BitWiseXNOR              //
    (   //---------------------//--------------------------------------------------------
        // Register Data       // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .a  ( XNOR_a        ), // [I][DW] (rs) Source register data
        .b  ( XNOR_b        ), // [I][DW] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic Result   // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .c ( XNOR_c         )  // [O][DW]
    );

    BitWiseXOR
    #(  //---------------------//--------------------------------------------------------
        // Parameter(s)        // Description(s)
        //---------------------//--------------------------------------------------------
        .N ( N              )  // Width of data in bits.
    )                          //
    u_BitWiseXOR               //
    (   //---------------------//--------------------------------------------------------
        // Register Data       // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .a  ( XOR_a         ), // [I][DW] (rs) Source register data
        .b  ( XOR_b         ), // [I][DW] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic Result   // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .c ( XOR_c          )  // [O][DW]
    );    
    
endmodule : ALULogical
`default_nettype wire
