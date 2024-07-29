//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   FullAdd
// Model:       DataFlow
// Description: 
//
//-----------------------------------------------------------------------------
`default_nettype none
module DataFlowFullAdd
#(  //--------------------------//--------------------------------------------
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
    output wire [N-1:0] c,      // Result
    output wire         co      // Carry out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire a_xor_b;
    wire a_or_b;
    wire a_and_b;
    wire a_or_b_and_ci;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    // Summation Logic
    assign a_xor_b       = a ^ b;
    assign c             = a_xor_b ^ ci; 
    // Carry Logic
    assign a_and_b       = a & b;
    assign a_or_b        = a | b;
    assign a_or_b_and_ci = a_or_b & ci;
    assign co            = a_or_b_and_ci | ci;

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : DataFlowFullAdd
`default_nettype wire
