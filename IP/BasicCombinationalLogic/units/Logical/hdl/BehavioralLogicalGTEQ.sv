//-----------------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 09/21/2013
// Design Name: Behavioral Logical Greater Than or Equal to (by n-bits)
// Unit Name: Logical
// Module Name: BehavioralLogicalGTEQ
// Project Name: Basic Logic
// Dependencies: None
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralLogicalGTEQ
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

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    always_comb c = a >= b;

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------

endmodule : BehavioralLogicalGTEQ
`default_nettype wire
