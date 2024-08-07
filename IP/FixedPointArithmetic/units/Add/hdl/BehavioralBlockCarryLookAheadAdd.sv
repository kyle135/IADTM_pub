//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   CarryLookAheadAdd
// Model:       Behavioral
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralBlockCarryLookAheadAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry in
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output logic [N-1:0] c,     // Result C
    output logic         co     // Carry out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    logic [N-1:0] cg;    
    logic [N-1:0] cp;
    logic [N-1:0] cx;
    logic [N-1:0] cgn;
    logic [N-1:0] cgn_and_cp;
    logic [N-1:0] cx_and_cgn;
    logic [N-1:0] cx_or_cgn;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    always_comb begin    
        cp         = a | b;
        cg         = a & b;
        cgn        = ~cg;
        cgn_and_cp = cgn & cp;
        {co, cx}   = cg | (cp & {cx, ci});
        cx_and_cgn = cx & cgn_and_cp;
        cx_or_cgn  = cx | cgn_and_cp;
        c          = ~cx_and_cgn & cx_or_cgn;
    end

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : BehavioralBlockCarryLookAheadAdd
`default_nettype wire
