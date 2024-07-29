//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   BlockCarryLookAheadAdd
// Model:       Structural
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralBlockCarryLookAheadAdd
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter integer   N = 32              //
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  //
    input  wire [N-1:0] b,                  //
    input  wire         ci,                 //
    //--------------------------------------//---------------------------------
    // Outputs                              // Description(s)
    //--------------------------------------//---------------------------------
    output wire [N-1:0] c,                  //
    output wire         co                  //
);
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------            
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION

    end : STRUCTURAL_GENERATION
    endgenerate
    
endmodule : StructuralBlockCarryLookAheadAdd
`default_nettype wire
