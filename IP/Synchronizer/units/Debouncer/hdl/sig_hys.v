// http://www.testbench.in/TB_13_TIME_SCALE_AND_PRECISION.html
`timescale 1ns/1ns 

module sig_hys
    // I/O Declarations
    (input  wire clk,			    // Synchronous Clock Input
     input  wire reset_b,	  // The unfiltered signal from the outside world.
     input  wire dir_sig,		 // Unfiltered input dirty signal
     output wire fil_sig);		// Cleaned output that changes only once timing 
                            // conditions have been satisfied.

	// Parameter Declarations
	// Default TURN_ON_CLOCK_COUNT used for simple testing.
	parameter TURN_ON_CLOCK_COUNT = 7;
  // Default TURN_OFF_CLOCK_COUNT used for simple testing.
	parameter TURN_OFF_CLOCK_COUNT = 10;
	// It takes exactly 3 clocks before a clean synchronized input can be 
	// considered to be asserted (go to 1) as it must pass through 3
	// Synchronization Flip-Flops.
	parameter ON_SYNCH_BLOCK_CLOCK_COUNT = 3;
	// It takes exactly one clock cycle for the output of the synchronizer's AND 
	// gate to de-assert (go to 0).
  parameter	OFF_SYNCH_BLOCK_CLOCK_COUNT = 1;
	parameter OUTPUT_OFF = 1'b0;
	parameter OUTPUT_ON = 1'b1;

   /***********************************************************
    * Signal Declaration                                      *
    ***********************************************************/

   reg synch_ff1, synch_ff2, synch_ff3, state, next_state;
   reg [31:00] turn_on_count, turn_off_count;

   wire turn_on_active;
   wire turn_off_active;

   /***********************************************************
    * Combinational Logic                                     *
    ***********************************************************/

   assign synch_dir_sig = synch_ff1 & synch_ff2 & synch_ff3;
   assign turn_on_active = (turn_on_count == (TURN_ON_CLOCK_COUNT - ON_SYNCH_BLOCK_CLOCK_COUNT));
   assign turn_off_active = (turn_off_count == (TURN_OFF_CLOCK_COUNT - OFF_SYNCH_BLOCK_CLOCK_COUNT));
   assign fil_sig = next_state;

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

   /***********************************************************
    * Synchronous Logic                                       *
    ***********************************************************/

   always@(posedge clk, negedge reset_b)
      if (~reset_b) state <= OUTPUT_OFF;
      else          state <= next_state;

   always@(posedge clk, negedge reset_b)
      if (~reset_b) begin
         synch_ff1 <= 1'b0;
         synch_ff2 <= 1'b0;
         synch_ff3 <= 1'b0;
      end
      else begin
         synch_ff1 <= dir_sig;
         synch_ff2 <= synch_ff1;
         synch_ff3 <= synch_ff2;
      end

   always@(posedge clk, negedge reset_b)
      if (~reset_b)
         turn_on_count <= 'd0;
      else if (synch_dir_sig & (turn_on_count == 0))
         turn_on_count <= 'd1;
      else if (synch_dir_sig & (turn_on_count == (TURN_ON_CLOCK_COUNT - ON_SYNCH_BLOCK_CLOCK_COUNT)))
         turn_on_count <= (TURN_ON_CLOCK_COUNT - ON_SYNCH_BLOCK_CLOCK_COUNT);
      else if (synch_dir_sig & (turn_on_count != (TURN_ON_CLOCK_COUNT - ON_SYNCH_BLOCK_CLOCK_COUNT)))
        turn_on_count <= turn_on_count + 'd1;
      else if (~synch_dir_sig)
        turn_on_count <= 'd0;

   always@(posedge clk, negedge reset_b)
      if (~reset_b)
         turn_off_count <= 'd0;
      else if (~synch_dir_sig & (turn_off_count == 0))
         turn_off_count <= 'd1;
      else if (~synch_dir_sig & (turn_off_count == (TURN_OFF_CLOCK_COUNT - OFF_SYNCH_BLOCK_CLOCK_COUNT)))
         turn_off_count <= TURN_OFF_CLOCK_COUNT - OFF_SYNCH_BLOCK_CLOCK_COUNT;
      else if (~synch_dir_sig & (turn_off_count != (TURN_OFF_CLOCK_COUNT - OFF_SYNCH_BLOCK_CLOCK_COUNT)))
        turn_off_count <= turn_off_count + 'd1;
      else if (synch_dir_sig)
        turn_off_count <= 'd0;

   /***********************************************************
    * Module Instantiation                                    *
    ***********************************************************/

endmodule
