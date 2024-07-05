//-----------------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 09/21/2013
// Design Name: DataFlow Logical Greater Than or Equal To (by n-bits)
// Unit Name: Logical
// Module Name: DataFlowLogicalGTEQ
// Project Name: BasicCombintationlLogic
// Dependencies: None
//-----------------------------------------------------------------------------
`default_nettype none
module DataFlowLogicalGTEQ
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8             // The number of bits of the operands.
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire  [N-1:0] a,             // Operand A
    input  wire  [N-1:0] b,             // Operand B
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output wire          c              // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    assign c = a >= b;

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------

endmodule : DataFlowLogicalGTEQ
`default_nettype wire
