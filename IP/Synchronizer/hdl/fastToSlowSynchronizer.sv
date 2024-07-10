//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Project Name: Synchronizer
// Module Name:  fastToSlowSynchronizer
// Design Name:  Fast To Slow Synchronizer (Hand-Shake)
// .-----------.                        |                         .-----------.
// | .-------. | fast clock domain      |       slow clock domain | .-------. |
// | | D   Q |=|========================|=========================|>| D   Q | |
// | |       | |                        |                         | |       | |
// | |>      | |                        |                         | |>      | |
// | '-------' |                        |                         | '-------' |
// |     ^     |                        |                         |     ^     |
// |     |     |                        |                         |     |     |
// | .-------. |   .------.   .------.  |                         | .-------. |
// | |  ACK  |<+---| Q  D |<--| Q  D |<---------------------------+-|  ACK  | |
// | |       | |   |      |   |      |  |                         | |       | |
// | |       | |   |     <|   |     <|  |                         | |       | |
// | |       | |   '------'   '------'  |                         | |       | |
// | |       | |                        |   .------.   .------.   | |       | |
// | |  REQ  |-+------------------------|-->| D  Q |-->| D  Q |---+>|  REQ  | |
// | |       | |                        |   |      |   |      |   | |       | |
// | |       | |                        |   |>     |   |>     |   | |       | |
// | |       | |                        |   '------'   '------'   | |       | |
// | '-------' |                        |                         | '-------' |
// '-----------'                        |                         '-----------'
// Dependencies: None
//
//-----------------------------------------------------------------------------
`default_nettype none
module FastToSlowSynchronizer
#(  //------------------------------//-----------------------------------------
    // Parameter(s)                 // Description(s)
    //------------------------------//-----------------------------------------
    parameter integer   N = 1,      // Data Width in bits
    parameter integer   S = 2       // Number of stages in synchronizers
)  (//------------------------------//-----------------------------------------
    // Fast Clock Interface         // Description(s)
    //------------------------------//-----------------------------------------
    input  wire         fast_clk,   // Fast Core Clock
    input  wire         fast_rstn,  // Fast Core Reset (Active-High)
    input  wire [N-1:0] fast_data,  // Fast Core Clock Data Line
    //------------------------------//-----------------------------------------
    // Slow Clock Interface			// Description(s)
    //------------------------------//-----------------------------------------
    input  wire         slow_clk,   // Slow Core Clock
    input  wire         slow_rstn,  // Slow Core Reset (Active-High)
    output reg  [N-1:0] slow_data   // Slow Core Data Line
);

    //-------------------------------------------------------------------------
    // Local net declarations
    //-------------------------------------------------------------------------
    reg          fast_req;
    wire         slow_req;
    wire         fast_ack;
    reg          slow_ack;
    reg  [N-1:0] fast_clk_data;
    wire [N-1:0] slow_clk_data;

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------
    always_ff @(posedge fast_clk, negedge fast_rstn) begin : REQUEST_BLOCK
        if ( ~fast_rstn ) begin
            fast_req <= 1'b0;
            fast_clk_data <= {N{1'b0}};
        end
        else if (fast_clk_data != fast_data && fast_req == 1'b0 ) begin
            fast_req <= 1'b1;
            fast_clk_data <= fast_data;
        end
        else if (fast_req     == 1'b1 && fast_ack == 1'b1 ) begin
            fast_req <= 1'b0;
        end
    end : REQUEST_BLOCK

    always_ff @(posedge slow_clk, negedge slow_rstn) begin : ACKNOWLEDGE_BLOCK
        if (~slow_rstn ) begin
            slow_ack <= 1'b0;
            slow_data <= {N{1'b0}};
        end
        else if (slow_req == 1'b1) begin
            slow_ack  <= 1'b1;
            slow_data <= slow_clk_data;
        end
        else if (slow_req == 1'b0 && slow_ack == 1'b1 ) begin
            slow_ack  <= 1'b0;
        end
    end : ACKNOWLEDGE_BLOCK

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instances
    //-------------------------------------------------------------------------
    SlowToFastSynchronizer
    #(  //-----------------------------//--------------------------------------
        // Parameter(s)                // Description(s)
        //-----------------------------//--------------------------------------
        .N          ( 1             ), // Data Width in bits
        .S          ( S             )  // Number of stages in synchronizers
    )                                  //
    req_sync                           //
    (                                  //
        //-----------------------------//--------------------------------------
        // Source Clock Interface      // Direction, Size & Description(s)
        //-----------------------------//--------------------------------------
        .sourceData ( fast_req      ), // [I][1] Source Core Data Line
        //-----------------------------//--------------------------------------
        // Sink Clock Interface        // Direction, Size & Description(s)
        //-----------------------------//--------------------------------------
        .sinkClock  ( slow_clk      ), // [I][1] Sink Core Clock
        .sinkReset  ( slow_rstn     ), // [I][1] Sink Core Reset (Active-High)
        .sinkData   ( slow_req      )  // [O][1] Sink Core Data Line
    );

    SlowToFastSynchronizer
    #(  //-----------------------------//--------------------------------------
        // Parameter(s)                // Description(s)
        //-----------------------------//--------------------------------------
        .N          ( 1             ), // Data Width in bits
        .S          ( S             )  // Number of stages in synchronizers
    )                                  //
    ack_sync                           //             
    (  //------------------------------//--------------------------------------
        // Source Clock Interface      // Direction, Size & Description(s)
        //-----------------------------//--------------------------------------
        .sourceData ( slow_ack      ), // [I][1] Source Core Data Line
        //-----------------------------//--------------------------------------
        // Sink Clock Interface        // Direction, Size & Description(s)
        //-----------------------------//--------------------------------------
        .sinkClock  ( fast_clk      ), // [I][1] Sink Core Clock
        .sinkReset  ( fast_rstn     ), // [I][1] Sink Core Reset (Active-High)
        .sinkData   ( fast_ack      )  // [O][1] Sink Core Data Line
    );

    SlowToFastSynchronizer
    #(  //-----------------------------//--------------------------------------
        // Parameter(s)                // Description(s)
        //-----------------------------//--------------------------------------
        .N          ( N             ), // Data Width in bits
        .S          ( S             )  // Number of stages in synchronizers
    ) 
    data_sync                          //--------------------------------------
    (   //-----------------------------//--------------------------------------
        // Source Clock Interface      // Direction, Size & Description(s)
        //-----------------------------//--------------------------------------
        .sourceData ( fast_clk_data ), // [I][N] Source Core Data Line
        //-----------------------------//--------------------------------------
        // Sink Clock Interface        // Direction, Size & Description(s)
        //-----------------------------//--------------------------------------
        .sinkClock  ( slow_clk      ), // [I][1] Sink Core Clock
        .sinkReset  ( slow_rstn     ), // [I][1] Sink Core Reset (Active-High)
        .sinkData   ( slow_data     )  // [O][N] Sink Core Data Line
    );

endmodule : FastToSlowSynchronizer
`default_nettype wire
