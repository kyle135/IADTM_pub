///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
// Design Name  : Reset Generator
//
// Authors      : Kyle D. Gilsdorf
//
// Description  : This creates Acitve-High and Active-Low resets based on a given source reset.
//
// To-Do        : Can we allow for an Active-Low reset source without resorting to `defs or repurposing the source_rst
//                name in a bad way.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`default_nettype none
module reset_generator
(    //--------------------------------------------------
    // Source Signals
    //--------------------------------------------------
    input  wire  source_rst,     // The reference reset signal we wish to target to a different clock domain,
    //----------------------------------------------------
    // Target Signals
    //----------------------------------------------------
    input  wire  target_clk,     // The target clock in which to synchronze the source reset to.
    output reg   target_rst,     // The synchronized and flopped reset (Active-High)
    output reg   target_rst_n    // The synchronized and flopped reset (Active-Low)
);


    //-------------------------------------------------------------------------
    // Wires, Reg's, and bits of my....
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


endmodule : xcela_reset_generator
`default_nettype wire
