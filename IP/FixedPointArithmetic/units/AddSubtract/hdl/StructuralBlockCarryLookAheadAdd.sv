//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralBlockCarryLookAheadAdder
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
        // Local Signals
        //-------------------------------------------------------------------------

        //-------------------------------------------------------------------------
        // Module Instantiation
        //-------------------------------------------------------------------------            
        genvar i;
        generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION

    end : STRUCTURAL_GENERATION
    endgenerate
    
endmodule : StructuralRippleCarryLookAheadAdder
`default_nettype wire