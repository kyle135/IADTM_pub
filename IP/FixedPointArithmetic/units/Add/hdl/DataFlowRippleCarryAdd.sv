//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   RippleCarryAdd
// Model:       DataFlow
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module DataFlowRippleCarryAdd
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter integer N     = 32,           //
    parameter string  MODEL = "DataFlow"    //
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  //
    input  wire [N-1:0] b,                  //
    input  wire         cx_in,              //
    //--------------------------------------//---------------------------------
    // Outputs                              // Description(s)
    //--------------------------------------//---------------------------------
    output wire [N-1:0] c,                  //
    output wire         co                  //
);
    
    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] cx;
    
    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    assign c = a ^ b ^ {cx[N-2:0], cx_in};
    assign cx = {cx[N-2:0], cx_in} & (a | b) | (a & b);
    assign co = cx[N-1];

endmodule : DataFlowRippleCarryAdd
`default_nettype wire
