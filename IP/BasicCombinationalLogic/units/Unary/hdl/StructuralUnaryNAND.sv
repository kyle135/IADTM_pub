//-----------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  09/21/2013
// Design Name:  Structural Unary NAND
// Project Name: IP
// Module Name:  BasicCombinationalLogic
// Unit Name:    Unary
// Moudle Name:  StructuralUnaryNAND
// Dependencies: None
// Description:  &
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralUnaryNAND
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
    output wire           c              // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] a_and;
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
        for (i = 0; i < N; i = i + 1) begin : GENERATE_BLOCK
            if   (i == 0)   and u_and (a_and[i], a[i], 1'b1);
            else            and u_and (a_and[i], a[i], a_and[i-1]);
        end : GENERATE_BLOCK
        not u_not (c, a_and[N-1]);
    endgenerate

endmodule : StructuralUnaryNAND
`default_nettype wire
