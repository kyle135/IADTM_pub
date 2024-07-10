//---------------------------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 11/26/2020, 1:19:27 PM 
// Design Name: Pointer (Behavioural)
// Module Name: behaviouralPointer_xN
// Project Name: Basic Logic
// Target Devices: None.
// Tool versions: None.
// Description: The following module
// Dependencies: None
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//---------------------------------------------------------------------------------------
`default_nettype none
module behaviouralPointer_xN #(
    //-----------------------------------------//----------------------------------------
    // Parameter(s)                            // Description(s)
    //-----------------------------------------//----------------------------------------
    parameter addressWidth =5                  // Address Width
)  (//-----------------------------------------//----------------------------------------
    // Global Signals                          // Description(s)
    //-----------------------------------------//----------------------------------------
    input  wire                  clock,        // Core Clock
    input  wire                  reset,        // Synchronous Reset (Active-High)
    // Pointer Interface                       //----------------------------------------
    input  wire                  decrement,    // Decrement Pointer
    input  wire                  increment,    // Increment Pointer
    output reg  [addressWidth:0] pointer       // Pointer
);
    //-----------------------------------------------------------------------------------
    // Synchronous Logic
    //-----------------------------------------------------------------------------------
    always_ff @ (posedge clock, posedge reset ) begin : FLIP_FLOP_BLOCK
       if      ( reset     ) pointer <= 0;
       else if ( increment ) pointer <= pointer + 1;
       else if ( decrement ) pointer <= pointer - 1;
    end : FLIP_FLOP_BLOCK

endmodule : behaviouralPointer_xN
`default_nettype wire