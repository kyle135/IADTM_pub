
`default_nettype none
module nStagesynchronizer #(
    //------------------------------------------------------//---------------------------------------------------------
    // Parameter(s)                                            // Description(s)
    //------------------------------------------------------//---------------------------------------------------------
    parameter integer N = 5,    // Address N in bits
    parameter integer S = 2
)  
(//------------------------------------------------------//---------------------------------------------------------
    input  wire         clk,        //
    input  wire         rstn,        //
    input  wire [N-1:0] dat,            //
    output reg  [N-1:0] sync_dat
);

            reg  [pointerN:0]    destinationPointerSync;    //

    always @( posedge destinationClock or posedge destinationReset ) begin : POINTER_SYNCHRONIZATION
        if ( destinationReset )    { destinationPointer, destinationPointerSync } <= {            pointerN'(0),       pointerN'(0) };
        else                      { destinationPointer, destinationPointerSync } <= { destinationPointerSync,      sourcePointer          };
    end : POINTER_SYNCHRONIZATION

endmodule : nStagesynchronizer
`default_nettype wire
