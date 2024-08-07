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
    output wire c,      // Result C
    output wire cp,     // Carry Propagate
    output wire cg      // Carry Generate
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire not_cg;
    wire pre;
    wire pre_and_ci;
    wire pre_or_ci;
    wire not_pre_and_ci;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    assign cg             = a & b;
    assign cp             = a | b;
    assign not_cg         = ~cg;
    assign pre            = not_cg & cp;

    assign pre_and_ci     = pre & ci;
    assign pre_or_ci      = pre | ci;
    assign not_pre_and_ci = ~pre_and_ci;
    assign c              = not_pre_and_ci & pre_or_ci;

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : DataFlowReducedFullAdd
`default_nettype wire
