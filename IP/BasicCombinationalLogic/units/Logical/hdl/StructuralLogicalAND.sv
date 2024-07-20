//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is 
//               licensed under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:      BasicCombinationalLogic
// Unit Name:    Logical
// Design Name:  Structural Logical AND (by n-bits)
// Module Name:  StructuralLogicalAND
// Dependencies: None
//---------------------------------------------------------------------------------------
`default_nettype none
module StructuralLogicalAND
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8             // The number of bits of the operands.
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              // Operand A
    input  wire [N-1:0] b,              // Operand B
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output wire         c               // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] A;
    wire [N-1:0] B;
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
            or or_b ( B[i], b[i], B[i-1] );
        end : GENERATE_LOOP
        and a_and_b(c, A[N-1], B[N-1]);
    endgenerate

endmodule : StructuralLogicalAND
`default_nettype wire