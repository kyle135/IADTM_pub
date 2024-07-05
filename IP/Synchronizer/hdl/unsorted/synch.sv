/**************************************************************************************************
* Copyright, XcelaStream
* ALL RIGHTS RESERVED
*
* XcelaStream, Inc.
* 7669 Limestone Drive
* Gainesville, VA 20155-4038
*
* NO PART OF THIS CODE MAY BE COPIED, MODIFIED, SOLD OR DISTRIBUTED TO ANYONE WHO IS NOT AN 
* XCELASTREAM EMPLOYEE WITHOUT WRITTEN AUTHORIZATION FROM XCELASTREAM
*
* Filename    : fast2slow_synch.sv
*
* Author(s)   : Kyle Gilsdorf <kgilsdorf@XcelaStream.com>
*
* Date        : 10/18/2020, 10:03:40 AM 
*
* Description : Fast to Slow Synchronization (Hand-Shake)
*
*
**************************************************************************************************/

module synch #(
	//----------------------------------------------//---------------------------------------------
	// Parameter(s)									// Description(s)
	//----------------------------------------------//---------------------------------------------
	parameter						DAT_WID = 1,	// Data Width in bits
	parameter						SNC_WID = 2		// Number of stages in synchronizers
)  (//----------------------------------------------//---------------------------------------------
	// Source Clock Interface						// Description(s)
	//----------------------------------------------//---------------------------------------------
	input	wire	[DAT_WID-1:0]	source_dat,		// Source Core Data Line
	//----------------------------------------------//---------------------------------------------
	// Sink Clock Interface							// Description(s)
	//----------------------------------------------//---------------------------------------------
	input	wire					sink_clk,		// Sink Core Clock
	input	wire					sink_rst,		// Sink Core Reset (Active-High)
	output	wire	[DAT_WID-1:0]	sink_dat		// Sink Core Data Line

)  (

	reg	[DAT_WID] sync_dat_r [SYN_WID];


	genvar i;
	generate
		for ( i = 0; i < SYN_WID; i = i + 1 ) begin : SYNC_STAGE_GEN_LOOP
			always_ff @ ( posedge sink_clk, posedge sink_rst ) begin
				if ( sink_rst ) begin
					sync_dat_r[i] <= { DAT_WID { 1'b0 } };
				end else if ( i = 0 ) begin
					sync_dat_r[0] <= source_dat;
				end else begin
					sync_dat_r[i] <= sync_dat_r[i-1];
				end
			end
		end
	endgenerate

endmodule : synch