//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is 
//               licensed under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Project Name: Basic Logic
// Unit Name:    Logical
// Design Name:  Behavioral Logical AND (by n-bits)
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
    always@* A = |a;
    
    always@* B = |b;
    
    always@* c = A & B;

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------

endmodule : BehavioralLogicalAND
`default_nettype wire
