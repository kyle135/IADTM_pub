
//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Descriptions: 
//
//-----------------------------------------------------------------------------
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module FIFOPointer
#(  //----------------------------------------//-------------------------------
    // Parameters                             //
    //----------------------------------------//-------------------------------
    parameter integer   A = 4                 //
)  (//----------------------------------------//-------------------------------
    // Global Signals                         // Description(s)
    //----------------------------------------//-------------------------------
    input  wire         clk,                  //
    input  wire         rstn,                 //
    //----------------------------------------//-------------------------------
    //                                        // Description(s)
    //----------------------------------------//-------------------------------
    output reg  [A  :0] pointer,              //
    input  wire         increment             //
);


    always @(posedge clk, negedge rstn)
            if      (~rstn    ) pointer <= {A+1{1'b0}};
            else if (increment) pointer <= pointer + 1;

endmodule : FIFOPointer
`default_nettype wire
