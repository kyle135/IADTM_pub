
//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  Synchronizer
// IP Name:      SignalHysteresisFilter
//-----------------------------------------------------------------------------
`default_nettype none
module SignalHysteresisFilter
#(  //-------------------------------------------------------------------------
    // Paremeter(s)
    //-------------------------------------------------------------------------

)  (//----------------------------
    //
    input  wire clk,			    // Synchronous Clock Input
    input  wire rstn,	            // The unfiltered signal from the outside world.
    input  wire dirtySignal,	    // Unfiltered input dirty signal
    output wire filteredSignal	    // Cleaned output that changes only once timing 
                                    // conditions have been satisfied.
);

    //-------------------------------------------------------------------------
	// Parameter Declarations
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Local net declarations.
    //-------------------------------------------------------------------------
    reg        synch_ff1, synch_ff2, synch_ff3, state, next_state;
    reg [31:0] turn_on_count, turn_off_count;

    wire turn_on_active;
    wire turn_off_active;

    //-------------------------------------------------------------------------
    // Combinational Logic                                     *
    //-------------------------------------------------------------------------
    assign synch_dirtySignal = synch_ff1 & synch_ff2 & synch_ff3;
    assign turn_on_active = (turn_on_count == (TURN_ON_CLOCK_COUNT - ON_SYNCH_BLOCK_CLOCK_COUNT));
    assign turn_off_active = (turn_off_count == (TURN_OFF_CLOCK_COUNT - OFF_SYNCH_BLOCK_CLOCK_COUNT));
    assign filteredSignal = next_state;

    always@*
        case(state)
            OUTPUT_OFF:
                if	  ( turn_on_active & ~turn_off_active)	next_state = OUTPUT_ON;
                else				                           							next_state = OUTPUT_OFF;
            OUTPUT_ON:
                if	  (~turn_on_active &  turn_off_active)	next_state = OUTPUT_OFF;
                else	                           										next_state = OUTPUT_ON;
            default:                                     next_state = OUTPUT_OFF;
        endcase

    //-------------------------------------------------------------------------
    // Synchronous Logic 
    //-------------------------------------------------------------------------
    always@(posedge clk, negedge rstn)
        if (~rstn) state <= OUTPUT_OFF;
        else          state <= next_state;

    always@(posedge clk, negedge rstn)
        if (~rstn) begin
            synch_ff1 <= 1'b0;
            synch_ff2 <= 1'b0;
            synch_ff3 <= 1'b0;
        end
        else begin
            synch_ff1 <= dirtySignal;
            synch_ff2 <= synch_ff1;
            synch_ff3 <= synch_ff2;
        end

    always@(posedge clk, negedge rstn)
        if (~rstn)
            turn_on_count <= 'd0;
        else if (synch_dirtySignal & (turn_on_count == 0))
            turn_on_count <= 'd1;
        else if (synch_dirtySignal & (turn_on_count == (TURN_ON_CLOCK_COUNT - ON_SYNCH_BLOCK_CLOCK_COUNT)))
            turn_on_count <= (TURN_ON_CLOCK_COUNT - ON_SYNCH_BLOCK_CLOCK_COUNT);
        else if (synch_dirtySignal & (turn_on_count != (TURN_ON_CLOCK_COUNT - ON_SYNCH_BLOCK_CLOCK_COUNT)))
            turn_on_count <= turn_on_count + 'd1;
        else if (~synch_dirtySignal)
            turn_on_count <= 'd0;

    always@(posedge clk, negedge rstn)
        if (~rstn)
            turn_off_count <= 'd0;
        else if (~synch_dirtySignal & (turn_off_count == 0))
            turn_off_count <= 'd1;
        else if (~synch_dirtySignal & (turn_off_count == (TURN_OFF_CLOCK_COUNT - OFF_SYNCH_BLOCK_CLOCK_COUNT)))
            turn_off_count <= TURN_OFF_CLOCK_COUNT - OFF_SYNCH_BLOCK_CLOCK_COUNT;
        else if (~synch_dirtySignal & (turn_off_count != (TURN_OFF_CLOCK_COUNT - OFF_SYNCH_BLOCK_CLOCK_COUNT)))
            turn_off_count <= turn_off_count + 'd1;
        else if (synch_dirtySignal)
            turn_off_count <= 'd0;

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule
`default_nettype wire