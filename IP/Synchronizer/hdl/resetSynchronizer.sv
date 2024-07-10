//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  Synchronizer
//
//-----------------------------------------------------------------------------
`default_nettype none
module reset_synchronizer #(
    parameter int DEPTH    = 3,
    parameter bit POLARITY = 1
)  (//------------------------------//-----------------------------------------
    //                              //
    //------------------------------//-----------------------------------------
    input  wire source_rst,         //
    //------------------------------//-----------------------------------------
    //                              //
    //------------------------------//-----------------------------------------
    input  wire target_clk,         //
    output wire target_rst          //
);
//
    reg [DEPTH] shift_reg;
    
    always_ff @(posedge target_clk ) begin
        if ( source_rst == POLARITY )    shift_reg    <= { DEPTH { POLARITY } };
        else                            shift_reg    <= { shift_reg[DEPTH-2:0], source_rst };
    end
    //

    assign target_rst  = shift_reg[DEPTH-1];

endmodule : reset_synchronizer
`default_nettype wire
