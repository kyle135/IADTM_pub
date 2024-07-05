//-----------------------------------------------------------------------------
//	Instition		:	Arizona State University
//	File 			:	compare.v
//	Date			:	1/23/2012
//	Description		:	Compare module to compare RD and WR pointers
//-----------------------------------------------------------------------------

// This block is in the WR Domain. So, wptr is compared with the synchronized
// RD pointer after gray to binary conversion. 
module compare_wr
	#(parameter ADDR = 5)
	(input [ADDR:0] wptr, rptr,
	 output reg full);
	 
	 assign full = (wptr[ADDR] != rptr[ADDR]) & (wptr[ADDR-1:0] == rptr[ADDR-1:0]);	 
endmodule	
				  
// This block is in the RD Domain. So, rptr is compared with the synchronized
// WR pointer after gray to binary conversion.
module compare_rd
	# (parameter ADDR = 5)
	(input [ADDR:0] wptr, rptr,
	 output wire empty);
	 
	assign empty = (wptr[ADDR:0] == rptr[ADDR:0]);
endmodule