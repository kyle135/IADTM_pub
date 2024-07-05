`ifndef SIMULATION_COMMON_VH
    `define SIMULATION_COMMON_VH



 
`ifndef __SIM_COMMON_VH__
	`define __SIM_COMMON_VH__
// Clock Parameters																// Description(s)
parameter int		KHz					= 1e3;									//
parameter int		MHz					= 1e6;									//
// Clock Domain Frequencies														//-------------------------------------


//------------------------------------------------------------------------------//-------------------------------------
//  Useful Measurements															// Description(s)
//------------------------------------------------------------------------------//-------------------------------------
// Sizes in bytes																//-------------------------------------

//------------------------------------------------------------------------------//-------------------------------------
// Type Definitions																// Description(s)
//------------------------------------------------------------------------------//-------------------------------------
typedef enum bit [ 1: 0] {														//
	GOOD								= 2'd 0,								//
	BAD									= 2'd 1,								//
	NONE								= 2'd 2									//
} checksum_type_t;																///////////////////////////////////////
// TCP IP Common Type Definition(s)												//-------------------------------------
typedef enum bit [15: 0] {														//
	ET_INTERNET_PROTOCOL_VERSION_4		= 16'h0800,								//
	ET_INTERNET_PROTOCOL_VERISON_6		= 16'h86DD								//
} eth_ether_type_t;																///////////////////////////////////////
//																				//
typedef enum bit [ 3:0 ] {														//
	IP_VERISON_RESERVED_0				= 4'd 0,								//
	IP_VERISON_UNASSIGNED_1				= 4'd 1,								//
	IP_VERISON_UNASSIGNED_2				= 4'd 2,								//
	IP_VERISON_UNASSIGNED_3				= 4'd 3,								//
	IP_VERSION_4						= 4'd 4,								//
	IP_VERSION_STREAMIP					= 4'd 5,								//
	IP_VERSION_6						= 4'd 6,								//
	IP_VERISON_IX						= 4'd 7,								//
	IP_VERISON_P						= 4'd 8,								//
	IP_VERISON_TUBA						= 4'd 9,								//
	IP_VERISON_UNASSIGNED_10			= 4'd10,								//
	IP_VERISON_UNASSIGNED_11			= 4'd11,								//
	IP_VERISON_UNASSIGNED_12			= 4'd12,								//
	IP_VERISON_UNASSIGNED_13			= 4'd13,								//
	IP_VERISON_UNASSIGNED_14			= 4'd14,								//
	IP_VERISON_RESERVED_15				= 4'd15									//
} ipx_version_t;																///////////////////////////////////////
//


//---------------------------------------------------------------------------------------------------------------------
// Text Colorization.															// Description(s)
//---------------------------------------------------------------------------------------------------------------------
`define setTextInverse		$write("%c[7m",27);
`define setTextReset		$write("%c[0m",27);

`define setTextRedFront		$write("%c[1;31m",27);
`define setTextRedBack		$write("%c[1;41m",27);
`define setTextRedBold		$write("%c[1;91m",27);

`define setTextGreenFront	$write("%c[1;32m",27);
`define setTextGreenBack	$write("%c[1;42m",27);
`define setTextGreenBold	$write("%c[1;92m",27);

`define setTextYellowFront	$write("%c[1;33m",27);
`define setTextYellowBack	$write("%c[1;43m",27);
`define setTextYellowBold	$write("%c[1;93m",27);

`define DISPLAY_VARIABLE( name, format, value ) \
	`setTextReset \
	begin \
		$write ( "{" );	\
		`setTextInverse	\
		$write ( "%m" ); \
		`setTextReset \
		$write ( "}" ); \
	end \
	$write ( " " ); \
	begin \
		$write ( "[" ); \
		`setTextYellowBack  \
		$write ( "Variable" ); \
		`setTextReset \
		$write ( "]" ); \
	end \
	$write ( " " ); \
	begin \
		`setTextYellowBold \
		$write ( "%s", name ); \
		`setTextReset \
		$write ( "=" ); \
		`setTextYellowFront \
		$write ( format, value ); \
		`setTextReset \
	end \
	$display ( );



`endif /* __SIMULATION_COMMON_VH__ */
