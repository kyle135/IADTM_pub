//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is 
//               licensed under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:      BasicCombinationalLogic
// Unit Name:    Logical
// Design Name:  Behavioral Logical Greater Than (by n-bits)
// Module Name:  BehavioralLogicalGT
// Dependencies: None
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralLogicalGT
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
    always_comb c = a > b;

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------

endmodule : BehavioralLogicalGT
`default_nettype wire
