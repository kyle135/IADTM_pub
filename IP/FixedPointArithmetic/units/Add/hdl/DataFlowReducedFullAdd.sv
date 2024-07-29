//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   ReducedFullAdd
// Model:       DataFlow
// Description:
//
//-----------------------------------------------------------------------------
`default_nettype none
module DataFlowReducedFullAdd
(   //------------------//-----------------------------------------------------
    // Inputs           // Descriptions
    //------------------//-----------------------------------------------------
    input  wire a,      // Operand A
    input  wire b,      // Operand B
    input  wire ci,     // Carry in
    //------------------//-----------------------------------------------------
    // Outputs          // Descriptions
    //------------------//-----------------------------------------------------
    output wire c,      // Result
    output wire cp,     // Carry Propagate
    output wire cg      // Carry Generate
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire not_cg;
    wire pre;
    wire pre_and_cin;
    wire pre_or_cin;
    wire not_pre_and_cin;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    assign cg              = a & b;
    assign cp              = a | b;
    assign not_cg          = ~cg;
    assign pre             = not_cg & cp;

    assign pre_and_cin     = pre & cin;
    assign pre_or_cin      = pre | cin;
    assign not_pre_and_cin = ~pre_and_cin;
    assign c               = not_pre_and_cin & pre_or_cin;

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : DataFlowReducedFullAdd
`default_nettype wire
