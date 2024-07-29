//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   RippleCarryLookAheadAdd
// Model:       DataFlow
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module DataFlowRippleCarryLookAheadAdd
#(  //--------------------------------------//---------------------------------
    // Parameter(s)                         // Description(s)
    //--------------------------------------//---------------------------------
    parameter integer N     = 32,           //
    parameter string  MODEL = "DataFlow"    //
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Descriptions
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  // Operand A
    input  wire [N-1:0] b,                  // Operand B
    input  wire         ci,                 // Carry in
    //--------------------------------------//---------------------------------
    // Outputs                              // Descriptions
    //--------------------------------------//---------------------------------
    output wire [N-1:0] c,                  // Result
    output wire         co                  // Carry out
);
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire [N-1:0] cx;

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    assign c = a ^ b ^ {cx[N-2:0], ci};
    assign cx = {cx[N-2:0], ci} & (a | b) | (a & b);
    assign co = cx[N-1];

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instances
    //-------------------------------------------------------------------------

endmodule : DataFlowRippleCarryLookAheadAdd
`default_nettype wire
