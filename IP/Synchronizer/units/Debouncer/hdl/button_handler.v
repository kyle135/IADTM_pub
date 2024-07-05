///////////////////////////////////////////////////////////////////////////////
//
// Engineer: Kyle D. Gilsdorf
//
///////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ns 

module button_handler (
    ///////////////////////////////
    // Global Signals
    ///////////////////////////////
    input  wire clk,             // 50MHz Clock
    input  wire reset_b,         // Active-Low Reset. All LEDs should glow when asserted.
    //////////////////////////////
    //
    //////////////////////////////
    input  wire switch,			//
    output wire positive_edge,	//
    output wire positive_toggled,	//
    output wire negative_edge,	//
    output wire negative_toggled);	//

    parameter TURN_ON_CLOCK_COUNT = 7;
    parameter TURN_OFF_CLOCK_COUNT = 10;

   /***********************************************************
    * Signal Declaration                                      *
    ***********************************************************/

   wire fil_sig;

   /***********************************************************
    * Combinational Logic                                     *
    ***********************************************************/

   /***********************************************************
    * Synchronous Logic                                       *
    ***********************************************************/

   /***********************************************************
    * Module Instantiation                                    *
    ***********************************************************/

   sig_hys
      // While there are a total of six parameters inside of the sig_hys module
      // 
      #(.TURN_ON_CLOCK_COUNT  (32'd60000),
        .TURN_OFF_CLOCK_COUNT (32'd35000))
      i_sig_hys
         (.clk                  (clk),               // I
          .reset_b              (reset_b),           // I
          .dir_sig              (switch),            // I
          .fil_sig              (fil_sig));          // O

   ped
      i_ped
         (.clk                  (clk),               // I
          .reset_b              (reset_b),           // I
          .sig                  (fil_sig),           // I
          .pulse                (positive_edge));    // O

   ned
      i_ned
          (.clk                  (clk),               // I
           .reset_b              (reset_b),           // I
           .sig                  (fil_sig),           // I
           .pulse                (negative_edge));    // O

   tff
      i_tff_1
          (.clk                  (clk),               // I
           .reset_b              (reset_b),           // I
           .toggle               (positive_edge),     // I
           .t_out                (positive_toggled)); // O

   tff
      i_tff_2
          (.clk                  (clk),               // I
           .reset_b              (reset_b),           // I
           .toggle               (negative_edge),     // I
           .t_out                (negative_toggled)); // O

endmodule

