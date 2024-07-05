//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Bit-Wise XOR
// Module Name:  BitWiseXOR
// Dependencies: 
// - StructuralBitWiseXOR
// - BehavioralBitWiseXOR
// - DataFlowBitWiseXOR
//-----------------------------------------------------------------------------
`default_nettype none
module BitWiseXOR #(
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
            StructuralBitWiseXOR
            #(  //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                    ) // The width in bits of the operands and result.
            )                               //
            u_StructuralBitWiseXOR          //
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
            BehavioralBitWiseXOR
            #(  //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                   )  // The width in bits of the operands and result.
            )                               //
            u_BehavioralBitWiseXOR          //
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
            DataFlowBitWiseXOR
            #(  //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                   )  // The width in bits of the operands and result.
            )                               //
            u_DataFlowBitWiseXOR            //
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

endmodule : BitWiseXOR
`default_nettype wire
