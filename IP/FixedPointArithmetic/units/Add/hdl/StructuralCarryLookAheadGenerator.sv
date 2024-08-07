
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
#(  //----------------------//-------------------------------------------------
    // Parameter(s)         // Description(s)
    //----------------------//-------------------------------------------------
    parameter integer N = 4 // Datapath width in bits.
)  (//----------------------//-------------------------------------------------
    // Input(s)             // Description(s)
    //----------------------//-------------------------------------------------
    input  wire a,          // Operand A
    input  wire b,          // Operand B
    input  wire cp,         // Carry Propagate
    input  wire cg,         // Carry Generate
    input  wire ci,         // Carry In
    //----------------------//-------------------------------------------------
    // Output(s)            // Description(s)
    //----------------------//-------------------------------------------------
    output wire co          // Carry Out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire cx;
    wire cp_and_cx;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION
        and u_cp_and_cx(cp_and_cx, cp, ci);
        or  u_cg_or_cp_and_cx(co, cg, cp_and_cx);        
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