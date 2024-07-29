
//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   CarryLookAheadGenerator
// Model:       Structural
// Description:
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralCarryLookAheadGenerator
#(  //-----------------------//------------------------------------------------
    // Parameter(s)          // Description(s)
    //-----------------------//------------------------------------------------
    parameter integer N = 4  //
)  (//-----------------------//------------------------------------------------
    // Input(s)              // Description(s)
    //-----------------------//------------------------------------------------
    input  wire [N-1:0] a,   // Operand A
    input  wire [N-1:0] b,   // Operand B
    input  wire [N-1:0] cp,  // Carry Propagate
    input  wire [N-1:0] cg,  // Carry Generate
    input  wire         ci,  // Carry In
    //-----------------------//------------------------------------------------
    // Output(s)             // Description(s)
    //-----------------------//------------------------------------------------
    output wire [N-1:0] co   // Carry Out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire [N  :0] cx;
    wire [N-1:0] cp_and_cx;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    assign cx[0] = ci;
    assign co    = cx[N-1:1];

    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION
        and u_cp_and_cx(cp_and_cx[i+1], cp[i], cx[i]);
        or  u_cg_or_cp_and_cx(cx[i+1], cg[i], cp_and_cx[i]);        
    end : STRUCTURAL_GENERATION
    endgenerate

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------    

endmodule : StructuralCarryLookAheadGenerator
`default_nettype wire