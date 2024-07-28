//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralReducedFullAdd
(   //------------------//-----------------------------------------------------
    // Input(s)         // Description(s)
    //------------------//-----------------------------------------------------
    input  wire a,      // Operand A
    input  wire b,      // Operand B
    input  wire cin,    // Carry In
    //------------------//-----------------------------------------------------
    // Outputs          // Description(s)
    //------------------//-----------------------------------------------------
    output wire c,      // Sum
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
    // Module Instances
    //-------------------------------------------------------------------------
    and u0_and              (cg,              a,               b         );
    or  u0_a_or_b           (cp,              a,               b         );
    not u0_not_cg           (not_cg,          cg                         );
    and u0_not_cg_and_a_or_b(pre,             not_cg,          cp        );

    and u1_and              (pre_and_cin,     pre,             cin       );
    or  u1_a_or_b           (pre_or_cin,      pre,             cin       );
    not u1_not_cg           (not_pre_and_cin, pre_and_cin                );
    and u1_not_cg_and_a_or_b(c,               not_pre_and_cin, pre_or_cin);

endmodule : StructuralReducedFullAdder
`default_nettype wire