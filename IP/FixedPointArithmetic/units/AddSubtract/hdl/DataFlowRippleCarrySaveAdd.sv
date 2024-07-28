//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------

module DataFlowAddRippleCarry
    #(  //--------------------------------------//---------------------------------
        // Parameters                           // Description(s)
        //--------------------------------------//---------------------------------
        parameter int    N     = 32,            //
        parameter string MODEL = "DataFlow"    //
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
    wire [N-1:0] carry;
    
    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    assign c = a ^ b ^ {carry[N-2:0], carry_in};
    assign carry = {carry[N-2:0], carry_in} & (a | b) | (a & b);
    assign carry_out = carry[N-1];

endmodule : DataFlowAddRippleCarry
    