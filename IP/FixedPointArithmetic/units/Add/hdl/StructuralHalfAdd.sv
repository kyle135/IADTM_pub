//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralHalfAdder
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter integer N     = 32             // Datapath width in bits.
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  //
    input  wire [N-1:0] b,                  //
    //--------------------------------------//---------------------------------
    // Outputs                              // Description(s)
    //--------------------------------------//---------------------------------
    output reg  [N-1:0] c,                  //
    output reg          carry_out           //
);

    //----------------------------
    //
    //----------------------------------------------
    wire [N-1:0] not_b;
    wire [N-1:0] not_a;
    wire [N-1:0] not_a_and_b;
    wire [N-1:0] a_and_not_b;

    //-------------------------------------------------------------------------
    // Module Instances
    //-------------------------------------------------------------------------
    //                               z            a            b
    not u_not_a                     (not_a,       a);
    not u_not_b                     (not_b,       b);
    and u_not_a_and_b               (not_a_and_b, not_a,       b);
    and u_a_and_not_b               (a_and_not_b, a,           not_b);
    or  u_not_a_and_b_or_a_and_not_b(c,           not_a_and_b, a_and_not_b);
    and u_and                       (carry_out,   a,           b);

endmodule : StructuralHalfAdder
`default_nettype wire