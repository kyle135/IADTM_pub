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
#(  //----------------------------------//-------------------------------------
    // Parameters                       // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer   N = 32,         // Data Path width in bits.
    parameter integer   R = 32,         // Register Count
    parameter integer   O = $clog2(R)   //
)  (//----------------------------------//-------------------------------------
    // Inputs                           // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] Instruction,    // Instruction
    input  wire [N-1:0] ProgramCounter, // 
    input  wire [N-1:0] GPR_a,          // General Purpose Register index A's data.
    input  wire [N-1:0] GPR_b,          // General Purpose Register index B's data.
    input  wire [N-1:0] GPR_c,          // General Purpose Register index C's data.
    input  wire [N-1:0] SPR_h,          // Special Purpose Register Hi data.
    input  wire [N-1:0] SPR_l,          // Special Purpose Register Lo data.
    //----------------------------------//-------------------------------------
    // Outputs                          // Description(s)
    //----------------------------------//-------------------------------------
    output reg  [N-1:0] GPR_a_dat,      //
    output reg          GPR_a_val,      //
    output reg  [N-1:0] GPR_b_dat,      //
    output reg          GPR_b_val,      //
    output reg  [N-1:0] GPR_c_dat,      //
    output reg          GPR_c_val,      //
    output reg  [N-1:0] SPR_h_dat,      //
    output reg          SPR_h_val,      //
    output reg  [N-1:0] SPR_l_dat,      //
    output reg          SPR_l_val,      // 
    output reg          SPR_o_val,      // Overflow
    output reg          SPR_z_val       // Zero
);

    //-------------------------------------------------------------------------
    // Local Net Declarations.
        //-------------------------------------------------------------------------
    wire [5:0] SPECIAL_OP  = 6'b000000;
    wire [5:0] SPECIAL2_OP = 6'b011100;
    //---------------------------------------------------------*/------------------------------//-+---+-----------------------:
    // CPU Logical Instruction Op Codes                        */ Functions                    // | T |    Assembly Code      |
    //---------------------------------------------------------*/------------------------------//-+---+-----------------------:
    wire [5:0] AND_OP  = SPECIAL_OP; /* AND                    */ wire [5:0] AND_FUNC = 6'h24; // | R | and
    wire [5:0] ANDI_OP = 6'h0C;      /* AND Immediate          */                              // | I | andi
    wire [5:0] LUI_OP  = 6'h0F;      /* Load Upper Immediate   */                              // | I | lui
    wire [5:0] NOR_OP  = 6'h00;      /* Not OR                 */ wire [5:0] NOR_FUNC = 6'h27; // | R | nor
    wire [5:0] OR_OP   = 6'h00;      /* OR                     */ wire [5:0] OR_FUNC  = 6'h25; // | R | or
    wire [5:0] ORI_OP  = 6'h0D;      /* OR immediate           */ wire [5:0] ORI_FUNC = 6'h00; // | I | ori
    wire [5:0] XOR_OP  = 6'h00;      /* Exclusive OR           */ wire [5:0] XOR_FUNC = 6'h26; // |   |
    wire [5:0] XORI_OP = 6'h0E;      /* Exclusive OR immediate */                              // |   |

    wire [ 15:0] Imm16;
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
    
    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    assign Imm16 = Instruction[15:0];    
    
    // Case Z definition
    // In the casez the don't-care value can represented by the question mark (?)
    // while the High-Impedence value is represented by the letter z (z).
    always_comb begin
        AND_a  = {N{1'b0}};
        AND_b  = {N{1'b0}};
        NOR_a  = {N{1'b0}};
        NOR_b  = {N{1'b0}};
        OR_a   = {N{1'b0}};
        OR_b   = {N{1'b0}};
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
                //---------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 1 0 0 |
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]         AND
                // [Assembly]     AND c, a, b
                // [Operation]    GPR[c] ← GPR[a] AND GPR[b]
                // [Description]  The contents of GPR[a] are combined with the contents of GPR[b]
                // in a bitwise logical AND operation. The result is placed into GPR[c]
                AND_a  = GPR_a;
                AND_b  = GPR_b;
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b1, AND_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : AND_INSTRUCTION
            {ANDI_OP,  5'b?????, 5'b?????, 16'b????????????????}: begin : AND_IMMEDIATE_INSTRUCTION
                //---------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15                            0
                //   .-------------.-----------.-----------.---------------------------------.
                // I | 0 0 1 1 0 0 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
                //   '-------------'-----------'-----------'---------------------------------'
                //         |6|          |5|         |5|                     |16|
                // [Name]         ANDI
                // [Assembly]     ANDI b, a, immediate
                // [Operation]    GPR[c] ← GPR[a] AND zero_extend(immediate)
                // [Description]  The 16-bit immediate is zero-extended to the left and 
                // combined with the contents of GPR rs in a bitwise logical AND operation. The 
                // result is placed into GPR[b]
                AND_a  = GPR_a;
                AND_b  = {16'd0, Imm16};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b1, AND_b};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : AND_IMMEDIATE_INSTRUCTION
            {NOR_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, NOR_FUNC}: begin : NOR_INSTRUCTION
                //---------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 1 1 1 |
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]         NOR
                // [Assembly]     NOR c, a, b
                // [Operation]    GPR[c] ← GPR[a] AND GPR[b]
                // [Description]  The contents of GPR[a] are combined with the contents of GPR[b]
                // in a bitwise logical AND operation. The result is placed into GPR[c]
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NOR_a  = GPR_a;
                NOR_b  = GPR_b;
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b1, NOR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : NOR_INSTRUCTION
            {OR_OP,    5'b?????, 5'b?????, 5'b?????, 5'b00000, OR_FUNC}: begin : OR_INSTRUCTION
                //--------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 1 0 1 |
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]         OR
                // [Assembly]     OR c, a, b
                // [Operation]    GPR[c] ← GPR[a] OR GPR[b]
                // [Description]  The contents of GPR[a] are combined with the contents of GPR[b]
                // in a bitwise logical OR operation. The result is placed into GPR[c].
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = GPR_a;
                OR_b   = GPR_b;
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b1, OR_c };
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : OR_INSTRUCTION
            {ORI_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, ORI_FUNC}: begin : OR_IMMEDIATE_INSTRUCTION
                //---------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15                            0
                //   .-------------.-----------.-----------.---------------------------------.
                // I | 0 0 1 1 0 1 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
                //   '-------------'-----------'-----------'---------------------------------'
                //         |6|          |5|         |5|                     |16|
                // [Name]         ORI
                // [Assembly]     ORI b, a, immediate
                // [Operation]    GPR[c] ← GPR[a] OR zero_extend(immediate)
                // [Description]  The 16-bit immediate is zero-extended to the left and combined 
                // with the contents of GPR[a] in a bitwise logical OR operation. The result is 
                // placed into GPR[b]
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = GPR_a;
                OR_b   = {16'd0, Imm16};
                XOR_a  = {N{1'b0}};
                XOR_b  = {N{1'b0}};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b1, OR_c };
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : OR_IMMEDIATE_INSTRUCTION
            {XOR_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, XOR_FUNC}: begin : XOR_INSTRUCTION
                //--------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15       11 10       6  5           0
                //   .-------------.-----------.-----------.-----------.-----------.-------------.
                // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 1 1 0 |
                //   '-------------'-----------'-----------'-----------'-----------'-------------'
                //         |6|          |5|         |5|         |5|         |5|          |6|
                // [Name]         XOR
                // [Assembly]     XOR c, a, b
                // [Operation]    GPR[c] ← GPR[a] XOR GPR[b]
                // [Description]  Combine the contents of GPR[a] and GPR[b] in a bitwise logical 
                // Exclusive OR operation and place the result into GPR[c].
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XOR_a  = GPR_a;
                XOR_b  = GPR_b;
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b0, GPR_b};
                {GPR_c_val, GPR_c_dat} = {1'b1, XOR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : XOR_INSTRUCTION
            {XORI_OP,   5'b?????, 5'b?????, 16'd0}: begin : XOR_IMMEDIATE_INSTRUCTION
                //---------------------------------------------------------------------------------
                //    31         26 25       21 20       16 15                            0
                //   .-------------.-----------.-----------.---------------------------------.
                // I | 0 0 1 1 1 0 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
                //   '-------------'-----------'-----------'---------------------------------'
                //         |6|          |5|         |5|                     |16|
                // [Name]         XORI
                // [Assembly]     XORI b, a, immediate
                // [Operation]    GPR[c] ← GPR[a] XOR zero_extend(immediate)
                // [Description]  The 16-bit immediate is zero-extended to the left and combined 
                // with the contents of GPR[a] in a bitwise logical XOR operation. The result is 
                // placed into GPR[b]
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
                XOR_a  = GPR_a;
                XOR_b  = {16'd0, Imm16};
                {GPR_a_val, GPR_a_dat} = {1'b0, GPR_a};
                {GPR_b_val, GPR_b_dat} = {1'b1, XOR_c};
                {GPR_c_val, GPR_c_dat} = {1'b0, GPR_c};
                {SPR_h_val, SPR_h_dat} = {1'b0, SPR_h};
                {SPR_l_val, SPR_l_dat} = {1'b0, SPR_l};
                {SPR_o_val, SPR_z_val} = {1'b0,  1'b0};
            end : XOR_IMMEDIATE_INSTRUCTION
            default: begin
                AND_a  = {N{1'b0}};
                AND_b  = {N{1'b0}};
                NOR_a  = {N{1'b0}};
                NOR_b  = {N{1'b0}};
                OR_a   = {N{1'b0}};
                OR_b   = {N{1'b0}};
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

    //-----------------------------------------------------------------------------------
    // Module Instances
    //-----------------------------------------------------------------------------------
    BitWiseAND
    #(  //---------------------//--------------------------------------------------------
        // Parameter(s)        // Description(s)
        //---------------------//--------------------------------------------------------
        .N ( N              )  // Width of data in bits.
    )                          //
    u_BitWiseAND               //
    (   //---------------------//--------------------------------------------------------
        // Register Data       // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .a ( AND_a          ), // [I][N] (rs) Source register data
        .b ( AND_b          ), // [I][N] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic ALUOut   // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .c ( AND_c          )  // [O][N]
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
        .a ( NOR_a          ), // [I][N] (rs) Source register data
        .b ( NOR_b          ), // [I][N] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic Result   // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .c ( NOR_c          )  // [O][N]
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
        .a ( OR_a           ), // [I][N] (rs) Source register data
        .b ( OR_b           ), // [I][N] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic Result   // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .c ( OR_c           )  // [O][N]
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
        .a  ( XOR_a         ), // [I][N] (rs) Source register data
        .b  ( XOR_b         ), // [I][N] (rd) Destination register data
        //---------------------//--------------------------------------------------------
        // Arithmetic Result   // Direction, Size & Description(s)
        //---------------------//--------------------------------------------------------
        .c ( XOR_c          )  // [O][N]
    );    
    
endmodule : ALULogical
`default_nettype wire
