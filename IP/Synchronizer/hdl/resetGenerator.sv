//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  Synchronizer
// IP Name:      Reset Generator
// Description: This creates Acitve-High and Active-Low resets based on a given source reset.
//
//-----------------------------------------------------------------------------
`default_nettype none
module reset_generator
(    //-------------------------//---------------------------------------------
    // Source Signals           // Description(s)
    //--------------------------//---------------------------------------------
    input  wire  source_rst,    // The reference reset signal we wish to target to a different clock domain,
    //--------------------------//---------------------------------------------
    // Target Signals           // Description(s)
    //--------------------------//---------------------------------------------
    input  wire  target_clk,    // The target clock in which to synchronze the source reset to.
    output reg   target_rst,    // The synchronized and flopped reset (Active-High)
    output reg   target_rst_n   // The synchronized and flopped reset (Active-Low)
);


    //-------------------------------------------------------------------------
    // Local Nets
	//-------------------------------------------------------------------------
	wire synchornized_source_rst;

    //----------------------------------------------------------------------------------------------------------------
    // Module Instance(S): We need to localize the external reset to the target clock domain.
    reset_synchornizer
    #(                                //
        .DEPTH            ( 3                            ),    // [SD] The depth of the synchronization stages.
    ) u_reset_synchronizer
    (                                //
        ( source_rst                ),    // [I][ 1] The reset we need to synchroize.
        ( tarket_clk                ),    // [I][ 1] The clock we need to synchronize to.
        ( synchronized_source_rst    )    // [O][ 1] The reset synchronized to the target clock domain.
    );


    //-------------------------------------------------------------------------
    // Synchronous Logic
    // The goal here is to generate the Active-Low and Active-High resets such 
    // that they assert or de-assert on the same clock edge.
    always_ff @(posedge target_clk ) begin : RESET_FLOPPING
        target_rst        <= synchronized_source_rst;
        target_rst_n    <=~synchronized_source_rst;
    end : RESET_FLOPPING


endmodule : reset_generator
`default_nettype wire
