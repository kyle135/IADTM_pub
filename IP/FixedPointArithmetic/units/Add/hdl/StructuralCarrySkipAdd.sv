//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   RippleCarryAdd
// Model:       Behavioral, Dataflow, Structural
// Description:
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralCarrySkipAdd
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Descriptions
    //--------------------------------------//---------------------------------
    parameter integer   N = 32             //
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Descriptions
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,      //
    input  wire [N-1:0] b,      //
    input  wire         ci,     //
    //--------------------------------------//---------------------------------
    // Outputs                              // Descriptions
    //--------------------------------------//---------------------------------
    output wire [N-1:0] c,                  //
    output wire         co           //
);
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire [N-1:0] cx;    
    wire [N-1:0] a_xor_b;
    wire [N-1:0] a_or_b;
    wire [N-1:0] a_and_b;
    wire [N-1:0] a_or_b_and_ci;
    
    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------            
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION
        // Summation Logic
        xor u_a_xor_b(a_xor_b[i], a[i], b[i]);
        if (i == 0) xor u_a_xor_b_xor_ci(c[i], a_xor_b[i], ci); 
        else        xor u_a_xor_b_xor_ci(c[i], a_xor_b[i], cx[i-1]);
            // Carry Logic
        and u_a_and_b(a_and_b[i], a[i], b[i]);
        or  u_a_or_b(a_or_b[i], a[i], b[i]);
        if (i == 0) and u_a_or_b_and_ci(a_or_b_and_ci[i], a_or_b[i], ci);
        else        and u_a_or_b_and_ci(a_or_b_and_ci[i], a_or_b[i], cx[i-1]);
                    
        if (i == N-1) or  u_a_or_b_and_ci_or_a_and_b(co, a_or_b_and_ci[i], cx[i-1]);
        else          or  u_a_or_b_and_ci_or_a_and_b(cx[i],  a_or_b_and_ci[i], cx[i-1]);
    end : STRUCTURAL_GENERATION
    endgenerate
    
endmodule : StructuralCarrySkipAdd
`default_nettype wire