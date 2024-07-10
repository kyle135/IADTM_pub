//---------------------------------------------------------------------------------------
// Company       : It's All Digital To Me
// Engineer      : Kyle D. Gilsdorf
// Create Date   : 09/21/2013
// Design Name   : Toggle Flip-Flop (Behavioural)
// Module Name   : behaviouralToggleFlipFlop
// Project Name  : Basic Flip Flops
// Target Devices: Target Agnostic
// Tool versions : Tool Agnostic
// Description   : The following module
// Dependencies  : Hope. Magic. Love...
// Revision      :
//-----------------------------------------------------------------------------
`default_nettype none
module behaviouralToggleFlipFlop (
    //---------------------------------//--------------------------------------
    // Global Signal(s)                // Description(s)
    //---------------------------------//--------------------------------------
    input  wire clock,                 // Core Clock
    input  wire reset,                 // Core Logic Reset (Active-High)
    //---------------------------------//--------------------------------------
    // Input(s)                        // Description(s)
    //---------------------------------//--------------------------------------
    input  wire toggle,                // Operator
    //---------------------------------//--------------------------------------
    // Output(s)                       // Description(s)
    //---------------------------------//--------------------------------------
    output reg  dataOut                // Result
);

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------
    always_ff @( posedge clock, posedge reset ) begin : TOGGLE_FLIP_FLOP_BLOCK
        if ( reset ) begin : RESET_BLOCK
            dataOut <= 1'b0;
        end : RESET_BLOCK
        else if ( toggle ) begin : TOGGLE_BLOCK
            dataOut <= ~dataOut;
        end : TOGGLE_BLOCK
    end : : TOGGLE_FLIP_FLOP_BLOCK

endmodule : behaviouralToggleFlipFlop
`default_nettype wire