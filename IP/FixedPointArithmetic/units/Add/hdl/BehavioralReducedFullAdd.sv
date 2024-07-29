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
module BehavioraReducedFullAdd
(   //--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry in
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output reg  [N-1:0] c,      // Result
    output reg          cp,     // Carry Propagate
    output reg          cg      // Carry Generate
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    reg not_cg;
    reg pre;
    reg pre_and_cin;
    reg pre_or_cin;
    reg not_pre_and_cin;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    always@* cg              = a & b;
    always@* cp              = a | b;
    always@* not_cg          = ~cg;
    always@* pre             = not_cg & cp;

    always@* pre_and_cin     = pre & cin;
    always@* pre_or_cin      = pre | cin;
    always@* not_pre_and_cin = ~pre_and_cin;
    always@* c               = not_pre_and_cin & pre_or_cin;
    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : BehavioralReducedFullAdd
`default_nettype wire
