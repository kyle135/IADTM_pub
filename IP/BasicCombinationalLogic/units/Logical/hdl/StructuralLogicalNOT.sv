//-----------------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 09/21/2013
// Design Name: Structural Logical NOT (by n-bits)
// Unit Name: Logical
// Module Name: StructuralLogicalNOT
// Project Name: Basic Logic
// Dependencies: None
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralLogicalNOT
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8             // The maximum number of bits
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              // Operand A
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output wire         c               // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] A;
    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------
    genvar i;
    generate
        for ( i = 1; i < N; i = i + 1 ) begin : GENERATE_LOOP
            or or_a ( A[i], a[i], A[i-1] );
        end : GENERATE_LOOP
        not not_or_a(c, A[N-1]);
    endgenerate

endmodule : StructuralLogicalNOT
`default_nettype wire
