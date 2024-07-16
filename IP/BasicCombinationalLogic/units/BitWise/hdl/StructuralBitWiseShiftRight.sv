//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Structural Bit-Wise Shift Right
// Module Name:  StructuralBitWiseShiftRight
// Dependencies:
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralBitWiseShiftRight
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8,            // The width in bits of the operand and result.
    parameter integer O = $clog2(N)     //
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              // Operand A
    input  wire [O-1:0] b,              // Operand B Shift Amount
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output wire [N-1:0] c               // Result C
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] a_sel [O];

    //-------------------------------------------------------------------------
    // Module Instantiations
    //-------------------------------------------------------------------------    
    genvar o;
    generate
        for (o = 0; o < O; o = o + 1 ) begin : SHIFT_BLOCK
            // o = 4                                         c         b[4], {0000000000000000, a_sel[3  ][31:16]
            if      (o == (O-1)) BitWiseShiftMUX #(N) u_mux (c,        b[o], 32'({{(2**o){1'b0}},   a_sel[o-1][N-1:(2**o)]}), 32'(a_sel[o-1]));
            // o = 0                                         a_sel[0], b[0], {               0, a         [31:1]}
            else if (o == 0)     BitWiseShiftMUX #(N) u_mux (a_sel[o], b[o], 32'({{(2**o){1'b0}},   a         [N-1:(2**o)]}), 32'(a         ));
            // o = 1                                         a_sel[1], b[1],                00, a_sel[0  ][31 2]
            // o = 2                                         a_sel[2], b[2],              0000, a_sel[1  ][31:4]
            // o = 3                                         a_sel[3], b[3],         000000000, a_sel[2  ][31:8]
            else                 BitWiseShiftMUX #(N) u_mux (a_sel[o], b[o], 32'({{(2**o){1'b0}},   a_sel[o-1][N-1:(2**o)]}), 32'(a_sel[o-1]));
        end : SHIFT_BLOCK
    endgenerate

endmodule : StructuralBitWiseShiftRight
`default_nettype wire
