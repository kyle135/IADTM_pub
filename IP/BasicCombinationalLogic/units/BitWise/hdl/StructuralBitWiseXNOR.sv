//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Structural Bit-Wise XNOR
// Module Name:  StructuralBitWiseXNOR
// Dependencies: 
// - Verilog ['xor', 'not']
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralBitWiseXNOR
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8             // The width in bits of the operand and result.
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              // Operand A
    input  wire [N-1:0] b,              // Operand B
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output reg  [N-1:0] c               // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] xor_c;

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------
    genvar i;
    generate
        for ( i = 0; i < N; i = i + 1 ) begin : GENERATE_LOOP
            xor xor_i (xor_c[i], a[i], b[i]);
            not not_i (c[i], xor_c[i]);
        end : GENERATE_LOOP
    endgenerate

endmodule : StructuralBitWiseXNOR
`default_nettype wire
