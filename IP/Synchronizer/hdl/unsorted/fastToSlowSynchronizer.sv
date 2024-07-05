//-------------------------------------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 11/25/2020, 3:23:29 PM
// Design Name: Fast To Slow Synchronizer (Hand-Shake)
// Module Name: fastToSlowSynchronizer
// Project Name: synchronizers
// Target Devices: none
// Tool versions:
// Description:
// Dependencies: None
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// .-----------.                                 |                                 .-----------.
// | .-------. | fastClock domain                |                slowClock domain | .-------. |
// | | D   Q |=:=================================|=================================:>| D   Q | |
// | |       | |                                 |                                 | |       | |
// | |>      | |                                 |                                 | |>      | |
// | '-------' |                                 |                                 | '-------' |
// |     ^     |                                 |                                 |     ^     |
// |     |     | fastClock_dataChangeAcknowledge |                                 |     |     |
// | .-------. |   .-------.   .-------.         | slowClock_dataChangeAcknowledge | .-------. |
// | |  ACK  |<+---| Q   D |<--| Q   D |<--------+---------------------------------+-+  ACK  | |
// | |       | |   |       |   |       |         |                                 | |       | |
// | |       | |   |>      |   |>      |         |                                 | |       | |
// | |       | |   '-------'   '-------'         |                                 | |       | |
// | |       | |                                 | slowClock_dataChangeRequest     | |       | |
// | |       | |                                 |       .-------.   .-------.     | |       | |
// | |  REQ  |-+---------------------------------+------>| D   Q |-->| D   Q |-----+>|  REQ  | |
// | |       | | fastClock_dataChangeRequest     |       |   |       |   |         | |       | |
// | |       | |                                 |       |>      |   |>      |     | |       | |
// | |>      | |                                 |       '-------'   '-------'     | |>      | |
// | '-------' |                                 |                                 | '-------' |
// '-----------'                                 |                                 '-----------'
//
// To-Do:
//
//-------------------------------------------------------------------------------------------------
`default_nettype none

module fastToSlowSynchronizer #(
    //----------------------------------------------//---------------------------------------------
    // Parameter(s)                                 // Description(s)
    //----------------------------------------------//---------------------------------------------
    parameter   DATA_WIDTH         = 1,             // Data Width in bits
    parameter   SYNCHRONIZER_WIDTH = 2              // Number of stages in synchronizers
)  (//----------------------------------------------//---------------------------------------------
    // Fast Clock Interface							// Description(s)
    //----------------------------------------------//---------------------------------------------
    input  wire                  fastClock,         // Fast Core Clock
    input  wire                  fastReset,         // Fast Core Reset (Active-High)
    input  wire [DATA_WIDTH-1:0] fastData,          // Fast Core Clock Data Line
    //----------------------------------------------//---------------------------------------------
    // Slow Clock Interface							// Description(s)
    //----------------------------------------------//---------------------------------------------
    input  wire                  slowClock,         // Slow Core Clock
    input  wire                  slowReset,         // Slow Core Reset (Active-High)
    output reg  [DATA_WIDTH-1:0] slowData           // Slow Core Data Line
);

    reg                   fastClock_dataChangeRequest;
    wire                  slowClock_dataChangeRequest;
    wire                  fastClock_dataChangeAcknowledge;
    reg                   slowClock_dataChangeAcknowledge;
    reg  [DATA_WIDTH-1:0] fastClock_data;
    wire [DATA_WIDTH-1:0] slowClock_data;
    //-------------------------------------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------------------------------------
    always_ff @(posedge fastClock) begin : REQUEST_BLOCK
        if ( fastReset ) begin
            fastClock_dataChangeRequest <= 1'b0;
            fastClock_data <= {DATA_WIDTH{1'b0}};
        end else if ( fastClock_data              != fastData &&
                      fastClock_dataChangeRequest == 1'b0 ) begin
            fastClock_dataChangeRequest <= 1'b1;
            fastClock_data <= fastData;
        end else if ( fastClock_dataChangeRequest     == 1'b1 &&
                      fastClock_dataChangeAcknowledge == 1'b1 ) begin
            fastClock_dataChangeRequest <= 1'b0;
        end
    end : REQUEST_BLOCK

    always_ff @(posedge slowClock) begin : ACKNOWLEDGE_BLOCK
        if          ( slowReset ) begin
            slowClock_dataChangeAcknowledge <= 1'b0;
            slowData <= {DATA_WIDTH{1'b0}};
        end else if ( slowClock_dataChangeRequest == 1'b1 ) begin
            slowClock_dataChangeAcknowledge <= 1'b1;
            slowData <= slowClock_data;
        end else if ( slowClock_dataChangeRequest     == 1'b0 &&
                      slowClock_dataChangeAcknowledge == 1'b1 ) begin
            slowClock_dataChangeAcknowledge <= 1'b0;
        end
    end : ACKNOWLEDGE_BLOCK

    //-------------------------------------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------------------------------------

    //-------------------------------------------------------------------------------------------------------
    // Module Instances
    //-------------------------------------------------------------------------------------------------------
    slowToFastSynchronizer    #(                                     //--------------------------------------
        //-----------------------------------------------------------//--------------------------------------
        // Parameter(s)                                              // Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .DATA_WIDTH             ( 1                               ), // Data Width in bits
        .SYNCHRONIZER_WIDTH     ( SYNCHRONIZER_WIDTH              )  // Number of stages in synchronizers
    ) slowToFastSynchronizerRequest (
        //-----------------------------------------------------------//--------------------------------------
        // Source Clock Interface                                    // Direction, Size & Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .sourceData             ( fastClock_dataChangeRequest     ), // [I][ 1] Source Core Data Line
        //-----------------------------------------------------------//--------------------------------------
        // Sink Clock Interface                                      // Direction, Size & Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .sinkClock              ( slowClock                       ), // [I][ 1] Sink Core Clock
        .sinkReset              ( slowReset                       ), // [I][ 1] Sink Core Reset (Active-High)
        .sinkData               ( slowClock_dataChangeRequest     )  // [O][ 1] Sink Core Data Line
    );

    slowToFastSynchronizer     #(                                    //--------------------------------------
        //-----------------------------------------------------------//--------------------------------------
        // Parameter(s)                                              // Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .DATA_WIDTH             ( 1                               ), // Data Width in bits
        .SYNCHRONIZER_WIDTH     ( SYNCHRONIZER_WIDTH              )  // Number of stages in synchronizers
    ) slowToFastSynchronizerAcknowledge (                            //--------------------------------------
        //-----------------------------------------------------------//--------------------------------------
        // Source Clock Interface                                    // Direction, Size & Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .sourceData             ( slowClock_dataChangeAcknowledge ), // [I][ 1] Source Core Data Line
        //-----------------------------------------------------------//--------------------------------------
        // Sink Clock Interface                                      // Direction, Size & Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .sinkClock              ( fastClock                       ), // [I][ 1] Sink Core Clock
        .sinkReset              ( fastReset                       ), // [I][ 1] Sink Core Reset (Active-High)
        .sinkData               ( fastClock_dataChangeAcknowledge )  // [O][ 1] Sink Core Data Line
    );

    slowToFastSynchronizer      #(                                   //--------------------------------------
        //-----------------------------------------------------------//--------------------------------------
        // Parameter(s)                                              // Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .DATA_WIDTH              ( DATA_WIDTH                     ), // Data Width in bits
        .SYNCHRONIZER_WIDTH      ( SYNCHRONIZER_WIDTH             )  // Number of stages in synchronizers
    ) slowToFastSynchronizerData (                                   //--------------------------------------
        //-----------------------------------------------------------//--------------------------------------
        // Source Clock Interface                                    // Direction, Size & Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .sourceData              ( fastClock_data                 ), // [I][DW] Source Core Data Line
        //-----------------------------------------------------------//--------------------------------------
        // Sink Clock Interface                                      // Direction, Size & Description(s)
        //-----------------------------------------------------------//--------------------------------------
        .sinkClock               ( slowClock                      ), // [I][ 1] Sink Core Clock
        .sinkReset               ( slowReset                      ), // [I][ 1] Sink Core Reset (Active-High)
        .sinkData                ( slowData                       )  // [O][DW] Sink Core Data Line
    );

endmodule : fastToSlowSynchronizer

`default_nettype wire
