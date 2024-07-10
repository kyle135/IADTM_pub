//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
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