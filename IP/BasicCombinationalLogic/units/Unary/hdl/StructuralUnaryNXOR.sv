//-----------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  09/21/2013
// Design Name:  Structural Unary NXOR
// Project Name: IP
// Module Name:  BasicCombinationalLogic
// Unit Name:    Unary
// Moudle Name:  StructuralUnaryNXOR
// Dependencies: None
// Description:  ^~
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralUnaryNXOR
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
    wire [N-1:0] not_a;
    wire [N-1:0] not_a_xor;

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Sequential Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------
    // assign c = ^(~a);
    genvar i, j;
    generate 
        for (j = 0; j < N; j = j + 1) begin :NOT_GENERATE_BLOCK
            not u_not (not_a[j], a[j]);
        end : NOT_GENERATE_BLOCK

        for (i = 1; i < N; i = i + 1) begin : XOR_GENERATE_BLOCK
            if   (i ==   1) xor u_xor (not_a_xor[1], not_a[1], not_a    [  0]);
            if   (i == N-1) xor u_xor (c,            not_a[i], not_a_xor[i-1]);
            else            xor u_xor (not_a_xor[i], not_a[i], not_a_xor[i-1]);
        end : XOR_GENERATE_BLOCK
    
endgenerate
assign c = ^(~a);

endmodule : StructuralUnaryNXOR
`default_nettype wire
