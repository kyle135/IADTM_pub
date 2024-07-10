//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  Synchronizer
// IP Name:      SignalDebouncer
//-----------------------------------------------------------------------------
`default_nettype none
module SignalDebouncer 
(   //------------------------------//-----------------------------------------
    // Global Signals               // Description(s)
    //------------------------------//-----------------------------------------
    input  wire clk,                // Core Clock
    input  wire rstn,               // Asynchronous Reset (Active-Low)
    //------------------------------//-----------------------------------------
    // Input to be debounces        // Description(s)
    //------------------------------//-----------------------------------------
    input  wire switch,			    //
    output wire positive_edge,	    //
    output wire positive_toggled,	//
    output wire negative_edge,	    //
    output wire negative_toggled);	//

    //-------------------------------------------------------------------------
    // Parameters
    //-------------------------------------------------------------------------
    parameter integer TURN_ON_CLOCK_COUNT  = 7;
    parameter integer TURN_OFF_CLOCK_COUNT = 10;

    //-------------------------------------------------------------------------
    // Local Net's.
    //-------------------------------------------------------------------------
    wire filteredSignal;

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    sig_hys
    #(  .TURN_ON_CLOCK_COUNT  (32'd60000),
        .TURN_OFF_CLOCK_COUNT (32'd35000)
    )
    i_sig_hys
    (   .clk            ( clk              ), // [I][1] Core Clock
        .rstn           ( rstn             ), // [I][1] Asynchronous Reset (Active-Low)
        .dirtySignal    ( switch           ), // [I][1] Dirty Signal
        .filteredSignal ( filteredSignal   )  // [O][1] Filtered Signal
    );

   PositiveEdgeDetect i_ped
    (   .clk            ( clk              ), // [I][1] Core Clock
        .rstn           ( rstn             ), // [I][1] Asynchronous Reset (Active-Low)
        .sig            ( filteredSignal   ), // [I][1] Filtered Signal
        .pulse          ( positive_edge    )  // [O][1] Positive pulse detection of filtered signal.
    );

   NegativeEdgeDetect i_ned
    (   .clk            ( clk              ), // [I][1] Core Clock
        .rstn           ( rstn             ), // [I][1] Asynchronous Reset (Active-Low)
        .sig            ( filteredSignal   ), // [I][1] Filtered Signal
        .pulse          ( negative_edge    )  // [O][1] Negative pulse detection of filtered signal.
    );

   ToggleFlipFlop i_tff_1
    (   .clk            ( clk              ), // [I][1] Core Clock
        .rstn           ( rstn             ), // [I][1] Asynchronous Reset (Active-Low)
        .toggle         ( positive_edge    ), // [I][1] Toggle current state
        .t_out          ( positive_toggled )  // [O][1] Current toggle state
    );

    ToggleFlipFlop i_tff_2
    (   .clk            ( clk              ), // [I][1] Core Clock
        .rstn           ( rstn             ), // [I][1] Asynchronous Reset (Active-Low)
        .toggle         ( negative_edge    ), // [I][1] Toggle current state
        .t_out          ( negative_toggled )  // [O][1] Current toggle state
    );
endmodule : SignalDebouncer
`default_nettype wire
