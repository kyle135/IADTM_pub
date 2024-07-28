//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralCarrySelectAdder
    #(  //--------------------------------------//---------------------------------
        // Parameters                           // Description(s)
        //--------------------------------------//---------------------------------
        parameter int    N     = 32             //
    )  (//--------------------------------------//---------------------------------
        // Inputs                               // Description(s)
        //--------------------------------------//---------------------------------
        input  wire [N-1:0] a,                  //
        input  wire [N-1:0] b,                  //
        input  wire         carry_in,           //
        //--------------------------------------//---------------------------------
        // Outputs                              // Description(s)
        //--------------------------------------//---------------------------------
        output wire [N-1:0] c,                  //
        output wire         carry_out           //
    );
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------

    
    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------            
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_FULL_ADDER_GENERATION
        // Summation Logic
        xor u_a_xor_b(a_xor_b[i], a[i], b[i]);
        if (i == 0) xor u_a_xor_b_xor_carry_in(c[i], a_xor_b[i], carry_in); 
        else        xor u_a_xor_b_xor_carry_in(c[i], a_xor_b[i], carry[i-1]);
            // Carry Logic
        and u_a_and_b(a_and_b[i], a[i], b[i]);
        or  u_a_or_b(a_or_b[i], a[i], b[i]);
        if (i == 0) and u_a_or_b_and_carry_in(a_or_b_and_carry_in[i], a_or_b[i], carry_in);
        else        and u_a_or_b_and_carry_in(a_or_b_and_carry_in[i], a_or_b[i], carry[i-1]);
                    
        if (i == N-1) or  u_a_or_b_and_carry_in_or_a_and_b(carry_out, a_or_b_and_carry_in[i], carry[i-1]);
        else          or  u_a_or_b_and_carry_in_or_a_and_b(carry[i],  a_or_b_and_carry_in[i], carry[i-1]);
    end : STRUCTURAL_FULL_ADDER_GENERATION
    endgenerate
    
endmodule : StructuralCarrySkipAdder
`default_nettype wire