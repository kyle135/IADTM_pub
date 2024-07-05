//-----------------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 09/21/2013
// Design Name: Behavioral Logical AND (by n-bits)
// Unit Name: Logical
// Module Name: BehavioralLogicalAND
// Project Name: Basic Logic
// Dependencies: None
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralLogicalAND
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8             // The number of bits of the operands.
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire  [N-1:0] a,             // Operand A
    input  wire  [N-1:0] b,             // Operand B
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output reg           c              // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    reg A;
    reg B;

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    always_comb A = |a;
    always_comb B = |b;
    always_comb c = A & B;

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------

endmodule : BehavioralLogicalAND
`default_nettype wire
