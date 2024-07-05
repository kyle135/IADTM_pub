//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Bit-Wise OR
// Module Name:  BitWiseOR
// Dependencies: 
// - StructuralBitWiseOR
// - BehavioralBitWiseOR
// - DataFlowBitWiseOR
//-----------------------------------------------------------------------------
`default_nettype none
module BitWiseOR #(
    //--------------------------------------//---------------------------------
    // Parameter(s)                         // Description(s)
    //--------------------------------------//---------------------------------
    parameter integer N     = 32,           // N of data in bits.
    parameter string  MODEL = "Structural"  // "Structural", "Behavioral", or "DataFlow"
)  (//--------------------------------------//---------------------------------
    // Data Input(s)                        // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  // Operand A
    input  wire [N-1:0] b,                  // Operand B
    //--------------------------------------//---------------------------------
    // Output(s)                            // Description(s)
    //--------------------------------------//---------------------------------
    output wire [N-1:0] c                   // Result C
);

    //-------------------------------------------------------------------------
    // Module Instances
    //-------------------------------------------------------------------------
    generate
        if (MODEL == "Structural") begin
            StructuralBitWiseOR
            #(  //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                    ) // The width in bits of the operands and result.
            )                               //
            u_StructuralBitWiseOR           //
            (   //--------------------------//---------------------------------
                // Input(s)                 // Direction, Size & Description(s)
                //--------------------------//---------------------------------
                .a ( a                   ), // [I][N] Operand A
                .b ( b                   ), // [I][N] Operand B
                //--------------------------//---------------------------------
                // Output(s)                // Direction, Size & Description(s)
                //--------------------------//---------------------------------
                .c  ( c                  )  // [O][N] Result C
            );
        end
        else if (MODEL == "Behavioral") begin
            BehavioralBitWiseOR
            #(  //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                   )  // The width in bits of the operands and result.
            )                               //
            u_BehavioralBitWiseOR           //
            (   //--------------------------//---------------------------------
                // Input(s)                 // Direction, Size & Description(s)
                //--------------------------//---------------------------------
                .a ( a                   ), // [I][N] Operand A
                .b ( b                   ), // [I][N] Operand B
                //--------------------------//---------------------------------
                // Output(s)                // Direction, Size & Description(s)
                //--------------------------//---------------------------------
                .c ( c                   )  // [O][N] Result C
            );
        end
        else if (MODEL == "DataFlow") begin
            DataFlowBitWiseOR
            #(  //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                   )  // The width in bits of the operands and result.
            )                               //
            u_DataFlowBitWiseOR             //
            (   //--------------------------//--------------------------------
                // Input(s)                 // Direction, Size & Description(s)
                //--------------------------//--------------------------------
                .a  ( a                  ), // [I][N] Operand A
                .b  ( b                  ), // [I][N] Operand B
                //--------------------------//--------------------------------
                // Output(s)                // Direction, Size & Description(s)
                //--------------------------//--------------------------------
                .c   ( c                 )  // [O][N] Result C
            );
        end
    endgenerate

endmodule : BitWiseOR
`default_nettype wire