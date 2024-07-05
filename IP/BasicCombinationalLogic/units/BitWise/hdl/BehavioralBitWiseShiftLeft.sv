//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Behavioral Bit-Wise Shift Left
// Module Name:  BehavioralBitWiseShiftLeft
// Dependencies: 
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralBitWiseShiftLeft
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8,            // The width in bits of the operand and result.
    parameter integer O = $clog2(N)     //
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              // Operand A
    input  wire [O-1:0] b,              // Operand B
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output reg  [N-1:0] c               // Result C
);

    //-------------------------------------------------------------------------
    // Combinational Logic                          
    //-------------------------------------------------------------------------
    always@* c = a << b;
    
endmodule : BehavioralBitWiseShiftLeft
`default_nettype wire
