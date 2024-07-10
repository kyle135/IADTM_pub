//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Description:  
//---------------------------------------------------------------------------------------
`default_nettype none
module SlowToFastSynchronizer
#(  //--------------------------//-------------------------------------------------------
    // Parameter(s)             // Description(s)
    //--------------------------//-------------------------------------------------------
    parameter integer N = 1,    // Data Width in bits
    parameter integer D = 2     // Number of stages in synchronizers
)  (//--------------------------//-------------------------------------------------------
    // Source Clock Interface   // Description(s)
    //--------------------------//-------------------------------------------------------
    input  wire [N-1:0] sdat,   // Source Core Data Line
    //--------------------------//-------------------------------------------------------
    // Sink Clock Interface     // Description(s)
    //--------------------------//-------------------------------------------------------
    input  wire         dclk,   // Sink Core Clock
    input  wire         drstn,  // Sink Core Reset (Active-High)
    output wire [N-1:0] ddat    // Sink Core Data Line
);

    //-----------------------------------------------------------------------------------
    // Local Variable(s) 
    //-----------------------------------------------------------------------------------
    reg	[N] synchdat [D];

    //-----------------------------------------------------------------------------------
    // Continuous Assignments
    //-----------------------------------------------------------------------------------
    assign ddat = synchdat[D-1];

    //-----------------------------------------------------------------------------------
    // Synchronous Logic
    //-----------------------------------------------------------------------------------
    genvar i;
    generate
        for ( i = 0; i < D; i = i + 1 ) begin : SYNC_STAGE_GEN_LOOP
            always_ff @ ( posedge dclk, negedge drstn ) begin
                if (~drstn) begin
                    synchdat[i] <= { N { 1'b0 } };
                end else if ( i == 0 ) begin
                    synchdat[0] <= sdat;
                end else begin
                    synchdat[i] <= synchdat[i-1];
                end
            end
        end
    endgenerate

endmodule : SlowToFastSynchronizer
`default_nettype wire