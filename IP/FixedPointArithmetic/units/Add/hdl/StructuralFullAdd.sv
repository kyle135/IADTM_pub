//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralFullAdd
(   //--------------//---------------------------------------------------------
    // Inputs       // Description(s)
    //--------------//---------------------------------------------------------
    input  wire a,  // Operand A
    input  wire b,  // Operand B
    input  wire ci, // Carry In 
    //--------------//---------------------------------------------------------
    // Output(s)    // Description(s)
    //--------------//---------------------------------------------------------
    output wire c,  // Result C
    output wire co  // Carry Out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire a_xor_b;
    wire a_or_b;
    wire a_and_b;
    wire a_or_b_and_ci;

    //-------------------------------------------------------------------------
    // Module Instances
    //-------------------------------------------------------------------------
    // Summation Logic             z              a              b
    xor u_a_xor_b                 (a_xor_b,       a,             b );
    xor u_a_xor_b_xor_ci          (c,             a_xor_b,       ci); 
    // Carry Logic                 z              a              b
    and u_a_and_b                 (a_and_b,       a,             b );
    or  u_a_or_b                  (a_or_b,        a,             b );
    and u_a_or_b_and_ci           (a_or_b_and_ci, a_or_b,        ci);
    or  u_a_or_b_and_ci_or_a_and_b(co,            a_or_b_and_ci, ci);


endmodule : StructuralFullAdder
`default_nettype wire
