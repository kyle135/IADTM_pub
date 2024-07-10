//---------------------------------------------------------------------------------------
// Company       : It's All Digital To Me
// Engineer      : Kyle D. Gilsdorf
// Create Date   : 09/21/2013
// Design Name   : Toggle Flip-Flop (Structural)
// Module Name   : behaviouralToggleFlipFlop
// Project Name  : Basic Flip Flops
// Target Devices: Target Agnostic
// Tool versions : Tool Agnostic
// Description   : The following module
// Dependencies  : Hope. Magic. Love...
// Revision      :
//-----------------------------------------------------------------------------
`default_nettype none
module structuralToggleFlipFlop (
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

endmodule : structuralToggleFlipFlop
`default_nettype wire
