//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   RipplerCarryAdd
// Model:       Behavioral
// Description:
//
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralRippleCarryAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire  [N-1:0] a,     // Operand A
    input  wire  [N-1:0] b,     // Operand B
    input  wire          ci,    // Carry In
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output logic [N-1:0] c,      // Result C
    output logic         co      // Carry Out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    logic [N-1:0] cx;             // Internal carry chain

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    always @* begin : BEHAVIORAL_BLOCK
        c  = a ^ b ^ {cx[N-2:0], ci};
        cx = ({cx[N-2:0], ci} & (a | b)) | (a & b);
        co = cx[N-1];
    end : BEHAVIORAL_BLOCK

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------        

endmodule : BehavioralRippleCarryAdd
`default_nettype wire
