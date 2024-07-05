//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Behavioral Bit-Wise NOT
// Module Name:  BehavioralBitWiseNOT
// Dependencies: None
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralBitWiseNOT
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8             // The width in bits of the operand and result.
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              // Input A
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output reg  [N-1:0] c               // Result C
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
    always@* c = ~a;
    
endmodule
`default_nettype wire
