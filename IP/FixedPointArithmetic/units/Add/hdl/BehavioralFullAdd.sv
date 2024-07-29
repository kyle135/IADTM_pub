//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   FullAdd
// Model:       Behavioral
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralFullAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry in
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output reg  [N-1:0] c,      // Result
    output reg          co      // Carry out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    reg a_xor_b;
    reg a_or_b;
    reg a_and_b;
    reg a_or_b_and_ci;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    // Summation Logic
    always@* a_xor_b       = a ^ b;
    always@* c             = a_xor_b ^ ci; 
    // Carry Logic
    always@* a_and_b       = a & b;
    always@* a_or_b        = a | b;
    always@* a_or_b_and_ci = a_or_b & ci;
    always@* co            = a_or_b_and_ci | ci;

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : BehavioralFullAdd
`default_nettype wire
