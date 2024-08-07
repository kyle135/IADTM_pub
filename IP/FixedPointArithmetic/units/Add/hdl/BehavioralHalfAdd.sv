//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   HalfAdd
// Modeling:    Behavioral
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralHalfAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire  [N-1:0] a,     // Operand A
    input  wire  [N-1:0] b,     // Operand B
    input  wire          ci,    // Carry in
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output logic [N-1:0] c,     // Result
    output logic         co     // Carry out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    logic [N-1:0] not_b;
    logic [N-1:0] not_a;
    logic [N-1:0] not_a_and_b;
    logic [N-1:0] a_and_not_b;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    always@* not_a       = ~a;
    always@* not_b       = ~b;
    always@* not_a_and_b = not_a & b;
    always@* a_and_not_b = a & not_b;
    always@* c           = not_a_and_b | a_and_not_b;
    always@* co          = a & b;

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : BehavioralHalfAdd
`default_nettype wire
