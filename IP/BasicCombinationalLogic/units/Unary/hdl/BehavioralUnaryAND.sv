//-----------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  09/21/2013
// Design Name:  Behavioral Unary AND
// Project Name: IP
// Module Name:  BasicCombinationalLogic
// Unit Name:    Unary
// Moudle Name:  BehavioralUnaryAND
// Dependencies: None
// Description:  &
// Command: 
// make command_line_simulation DUT=UnaryAND MODEL=Behavioral N=32 -gui -title "Unary_BehavioralUnaryAND" -do "quietly set StdArithNoWarnings 1; log -recursive /* -optcells; run -all;" Unary_tb > Unary_BehavioralUnaryAND_vsim.log
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralUnaryAND
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

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    always @* c = (&a);

    //-------------------------------------------------------------------------
    // Sequential Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------

endmodule : BehavioralUnaryAND
`default_nettype wire
