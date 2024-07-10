//-----------------------------------------------------------------------------
// Company       : It's All Digital To Me
// Engineer      : Kyle D. Gilsdorf
// Create Date   : 09/21/2013
// Design Name   : Negative Edge Detect (Behavioural)
// Module Name   : behaviouralNegativeEdgeDetect
// Project Name  : Basic Flip Flops
// Target Devices: Target Agnostic
// Tool versions : Tool Agnostic
// Description   : The following module generates a single clock-wide pulse to 
//                 indicated a falling edge has been detected.
// Dependencies  : Hope. Magic. Love...
// Revision      :
//-----------------------------------------------------------------------------
`default_nettype none
module behv_negative_edge_detect 
(   //---------------------------------//--------------------------------------
    // Global Signal(s)                // Description(s)
    //---------------------------------//--------------------------------------
    input  wire clock,                 // Core Clock
    input  wire reset,                 // Core Logic Reset (Active-High)
    //---------------------------------//--------------------------------------
    // Input(s)                        // Description(s)
    //---------------------------------//--------------------------------------
    input  wire signal,                // Incoming signal to edge detect.
    //---------------------------------//--------------------------------------
    // Output(s)                       // Description(s)
    //---------------------------------//--------------------------------------
    output wire pulse                  // Result
);
    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------
    reg q;
    // Singal D-Flip-Flop from which to generate comparison from.
    always_ff @( posedge clock, posedge reset ) begin : FLIP_FLOP_BLOCK
        if ( reset ) begin : RESET_BLOCK
            q <= 1'b0;
        end : RESET_BLOCK
        else begin
            q <= signal;
        end
    end : FLIP_FLOP_BLOCK
    
    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    assign pulse = ~signal & q;

endmodule : behaviouralNegativeEdgeDetect
`default_nettype wire
