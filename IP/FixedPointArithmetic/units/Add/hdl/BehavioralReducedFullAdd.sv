//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   ReducedFullAdd
// Model:       Behavioral
// Description: 
//
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralReducedFullAdd
(   //------------------//-----------------------------------------------------
    // Inputs           // Descriptions
    //------------------//-----------------------------------------------------
    input  wire a,      // Operand A
    input  wire b,      // Operand B
    input  wire ci,     // Carry in
    //------------------//-----------------------------------------------------
    // Outputs          // Descriptions
    //------------------//-----------------------------------------------------
    output reg  c,      // Result
    output reg  cp,     // Carry Propagate
    output reg  cg      // Carry Generate
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    reg not_cg;
    reg pre;
    reg pre_and_ci;
    reg pre_or_ci;
    reg not_pre_and_ci;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    always@* cg              = a & b;
    always@* cp              = a | b;
    always@* not_cg          = ~cg;
    always@* pre             = not_cg & cp;

    always@* pre_and_ci     = pre & ci;
    always@* pre_or_ci      = pre | ci;
    always@* not_pre_and_ci = ~pre_and_ci;
    always@* c               = not_pre_and_ci & pre_or_ci;
    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : BehavioralReducedFullAdd
`default_nettype wire
