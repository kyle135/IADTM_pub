
`default_nettype none
module DataFlowLogicalNOT
#(  //----------------------------------//-------------------------------------
    // Parameters                       // Description(s)
    //----------------------------------//-------------------------------------    
    parameter integer N = 8             // Width of input to be logically NOT'd
)  (//----------------------------------//-------------------------------------
    // Input Ports                      // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              // Input to be logically NOT'd
    //----------------------------------//-------------------------------------    
    // Output Ports                     // Description(s)
    //----------------------------------//-------------------------------------
    output wire         c               // The logical inverse of a.
);

    //----------------------------------//-------------------------------------
    // Local Signals                    // Description(s)
    //----------------------------------//-------------------------------------
    wire a_or;

    //----------------------------------//-------------------------------------
    // Combinational Logic              // Description(s)
    //----------------------------------//-------------------------------------
    assign a_or = | a;                  // Unitary OR
    assign c    = ~a_or;                // Single Bit Inversion

endmodule : DataFlowLogicalNOT
`default_nettype wire
