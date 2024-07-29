//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   HalfAdder
// Model:       Structural
// Description:
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralHalfAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits.
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output reg  [N-1:0] c,      // Result C
    output reg          co      // Carry out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire [N-1:0] not_b;
    wire [N-1:0] not_a;
    wire [N-1:0] not_a_and_b;
    wire [N-1:0] a_and_not_b;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    
    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    //                               z            a            b
    not u_not_a                     (not_a,       a);
    not u_not_b                     (not_b,       b);
    and u_not_a_and_b               (not_a_and_b, not_a,       b);
    and u_a_and_not_b               (a_and_not_b, a,           not_b);
    or  u_not_a_and_b_or_a_and_not_b(c,           not_a_and_b, a_and_not_b);
    and u_and                       (co,          a,           b);

endmodule : StructuralHalfAdd
`default_nettype wire
