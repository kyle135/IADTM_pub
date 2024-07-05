//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Structural Bit-Wise Shift Left
// Module Name:  StructuralBitWiseShiftLeft
// Dependencies:
// - BitWiseShiftMUX
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralBitWiseShiftLeft
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8,            // The width in bits of the operand and result.
    parameter integer O = $clog2(N)     //
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              // Operand A
    input  wire [O-1:0] b,              // Operand B shft_amt
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
    // If you want to see how this unrolls, uncomment this code.
    // initial
    // begin
    //     for (int i = 0; i < O; i = i + 1)
    //         if      (i == 0)   $display("u_mux (a_sel[%01d], b[%01d] {a       [%02d:%02d], {%02d}{1'b0}, a       );",       i, i,      N-(2**i)-1, 0, 2**i);
    //         else if (i == O-1) $display("u_mux (c,        b[%01d] {a_sel[%01d][%02d:%02d], {%02d}{1'b0}, a_sel[%01d]);",    i,    i-1, N-(2**i)-1, 0, 2**i, i-1);
    //         else               $display("u_mux (a_sel[%01d], b[%01d] {a_sel[%01d][%02d:%02d], {%02d}{1'b0}, a_sel[%01d]);", i, i, i-1, N-(2**i)-1, 0, 2**i, i-1);
    // end
    
    
    genvar o;
    generate
        for (o = 0; o < O; o = o + 1 ) begin : SHIFT_BLOCK
            // o = 4                                         c         b[4], {a_sel[3  ][15        :0]  {0000000000000000}}
            if      (o == (O-1)) BitWiseShiftMUX #(N) u_mux (c,        b[o], {a_sel[o-1][N-(2**o)-1:0], {(2**o){1'b0}}}, a_sel[o-1]);
            // o = 0                                         a_sel[0], b[0], {         a[30        :0], {                0}}, a
            else if (o == 0)     BitWiseShiftMUX #(N) u_mux (a_sel[o], b[o], {         a[N-(2**o)-1:0], {(2**o){1'b0}}}, a         );
            // o = 1                                         a_sel[1], b[1], {a_sel[0  ][29        :0], {                00    
            // o = 2                                         a_sel[2], b[2], {a_sel[1  ][27        :0], {              0000    
            // o = 3                                         a_sel[3], b[3], {a_sel[2  ][23        :0], {          00000000    
            else                 BitWiseShiftMUX #(N) u_mux (a_sel[o], b[o], {a_sel[o-1][N-(2**o)-1:0], {(2**o){1'b0}}}, a_sel[o-1]);
        end : SHIFT_BLOCK
    endgenerate

endmodule : StructuralBitWiseShiftLeft
`default_nettype wire
