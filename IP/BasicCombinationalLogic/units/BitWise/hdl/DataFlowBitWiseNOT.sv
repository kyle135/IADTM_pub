//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  DataFlow Bit-Wise NOT
// Module Name:  DataFlowBitWiseNOT
// Dependencies: None
//-----------------------------------------------------------------------------
`default_nettype none
module DataFlowBitWiseNOT
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8        // Width of input a in bits
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire  [N-1:0] a,         // Input A
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output wire  [N-1:0] c          // Result C
);

    //-------------------------------------------------------------------------
    // Combinational Logic              
    //-------------------------------------------------------------------------
    //   Truth Table
    // .------.------.
    // | a[i] | c[i] |
    // :------+------:
    // |  0   |  1   |
    // |  0   |  0   |
    // '------'------'
    assign c = ~a;

endmodule : DataFlowBitWiseNOT
`default_nettype wire