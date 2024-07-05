//-----------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  09/21/2013
// Design Name:  Structural Unary XNOR
// Project Name: IP
// Module Name:  BasicCombinationalLogic
// Unit Name:    Unary
// Moudle Name:  StructuralUnaryXNOR
// Dependencies: None
// Description:  &
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralUnaryXNOR
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8             // The number of bits of the operands.
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire  [N-1:0] a,             // Operand A
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output reg           c              // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] a_xor;
    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Sequential Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------
    genvar i;
    generate 
    for (i = 1; i < N; i = i + 1) begin : GENERATE_BLOCK
        if   (i == 1)   xor u_xor (a_xor[1], a[1], a    [  0]);
        else            xor u_xor (a_xor[i], a[i], a_xor[i-1]);
    end : GENERATE_BLOCK
    not u_not (c, a_xor[N-1]);
endgenerate
endmodule : StructuralUnaryXNOR
`default_nettype wire
