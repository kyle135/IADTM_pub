//-----------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  09/21/2013
// Design Name:  Structural Unary XOR
// Project Name: IP
// Module Name:  BasicCombinationalLogic
// Unit Name:    Unary
// Moudle Name:  StructuralUnaryXOR
// Dependencies: None
// Description:  &
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralUnaryXOR
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
    output wire          c              // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] xor_a;
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
            if   (i ==   1) xor u_xor (xor_a[1], a[1],     a[  0]);
            if   (i == N-1) xor u_xor (c,        a[i], xor_a[i-1]);
            else            xor u_xor (xor_a[i], a[i], xor_a[i-1]);
        end : GENERATE_BLOCK
    endgenerate

endmodule : StructuralUnaryXOR
`default_nettype wire
