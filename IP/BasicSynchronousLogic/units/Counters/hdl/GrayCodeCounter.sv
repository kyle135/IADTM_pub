//-----------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------
`default_nettype none
module GrayCodeCounter 
#(
    parameter WIDTH = 5
)
(   //-------------------------------------------------------------------------
    //
    //-------------------------------------------------------------------------
    // 'op' should be connected to READ/WRITE.		
    input   wire 	op,							  
    // clk should be connected to WCLK/RCLK in the appropriate domains.
    input   wire    clk,	
    // active_low, async reset_b resets the counters so that the pointers 
    // are put to 0.
    input   wire    reset_b,
    // fifo_status is the signal that decides if the FIFO is FULL/EMPTY
    input   wire    increment,	
    // Pointers should have 1 bit more than the DEPTH of the FIFO so that
    // write/read pointers can wrap around. and FULL/EMPTY are distinct.
    output  reg   [WIDTH-1:0]  gray,
    output  reg   [WIDTH-1:0]  binary
); 
        
        wire [ADDR:0] binary_next;
        wire [ADDR:0] gray_next;
        
        assign binary_next = binary + (!fifo_status & op); 
        assign gray_next = (binary_next>>1) ^ binary_next;	
            
    always @ (posedge clk, negedge reset_b)
        if (!reset_b) 		binary <= 'h0;
        else 				binary <= binary_next; 	 		
    
    always @ (posedge clk, negedge reset_b) 
        if (!reset_b) 	gray <= 'h0;
        else			gray <= gray_next;	

endmodule : GrayCodeCounter
`default_nettype wire