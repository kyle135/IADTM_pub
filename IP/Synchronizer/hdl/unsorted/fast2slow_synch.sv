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
* .-----------.                          |                           .-----------.
* : .-------. : fast clock domain        |         slow clock domain : .-------. :
* : | D   Q |=:==========================|===========================:>| D   Q | :
* : |       | :                          |                           : |       | :
* : |>      | :                          |                           : |>      | :
* : '-------' :                          |                           : '-------' :
* :     ^     :                          |                           :     ^     :
* :     |     :                          |                           :     |     :
* : .-------. :   .-------.   .-------.  |                           : .-------. :
* : |  ACK  |<:---| Q   D |<--| Q   D |<-----------------------------: |  ACK  | :
* : |       | :   |       |   |       |  |                           : |       | :
* : |       | :   |      <|   |      <|  |                           : |       | :
* : |       | :   '-------'   '-------'  |                           : |       | :
* : |       | :                          |   .-------.   .-------.   : |       | :
* : |  REQ  |-:--------------------------|-->| D   Q |-->| D   Q |---:>|  REQ  | :
* : |       | :                          |   |       |   |       |   : |       | :
* : |       | :                          |   |>      |   |>      |   : |       | :
* : |       | :                          |   '-------'   '-------'   : |       | :
* : '-------' :                          |                           : '-------' :
* '-----------'                          |                           '-----------'
*
* To-Do:
*
**************************************************************************************************/

module fast2slow_synch #(
	//----------------------------------------------//---------------------------------------------
	// Parameter(s)									// Description(s)
	//----------------------------------------------//---------------------------------------------
	parameter						DAT_WID = 1		// Data Width in bits
)  (//----------------------------------------------//---------------------------------------------
	// Fast Clock Interface							// Description(s)
	//----------------------------------------------//---------------------------------------------
	input	wire					fast_clk,		// Fast Core Clock
	input	wire					fast_rst,		// Fast Core Reset (Active-High)
	input	wire	[DAT_WID-1:0]	fast_dat,		// Fast Core Data Line
	//----------------------------------------------//---------------------------------------------
	// Slow Clock Interface							// Description(s)
	//----------------------------------------------//---------------------------------------------
	input	wire					slow_clk,		// Slow Core Clock
	input	wire					slow_rst,		// Slow Core Reset (Active-High)
	input	wire	[DAT_WID-1:0]	slow_dat		// Slow Core Data Line
);


	//---------------------------------------------------------------------------------------------
	//
	//---------------------------------------------------------------------------------------------



endmodule : fast2slow_synch