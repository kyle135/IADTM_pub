//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module CarrySaveAdder
    #(  //--------------------------------------//---------------------------------
        // Parameters                           // Description(s)
        //--------------------------------------//---------------------------------
        parameter int    N     = 32,            // Datapath width in bits.
        parameter string MODEL = "Behavioral"   // Which modelling style
    )  (//--------------------------------------//---------------------------------
        // Inputs                               // Description(s)
        //--------------------------------------//---------------------------------
        input  wire [N-1:0] a,                  //
        input  wire [N-1:0] b,                  //
        input  wire         carry_in,           //
        //--------------------------------------//---------------------------------
        // Outputs                              // Description(s)
        //--------------------------------------//---------------------------------
        output reg  [N-1:0] c,                  //
        output reg          carry_out           //
    );
    

endmodule : CarrySaveAdder
`default_nettype wire