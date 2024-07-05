//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Design Name:  Structural Bit-Wise OR (by n-bits)
// Module Name:  StructuralBitWiseOR
// Project Name: BasicCombinationalLogic
// Dependencies:
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralBitWiseOR
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
    // Module instance(s)
    //-------------------------------------------------------------------------
    genvar i;
    generate
        for ( i = 0; i < N; i = i + 1 ) begin : GENERATE_LOOP
            or or_i ( c[i], a[i], b[i] );
        end : GENERATE_LOOP
    endgenerate

endmodule : StructuralBitWiseOR
`default_nettype wire
