//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add

//-----------------------------------------------------------------------------
`default_nettype none
module DataFlowReducedFullAdd
#(  //--------------------------//---------------------------------------------
    // Parameter(s)             // Description(s)
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits
)  (//--------------------------//---------------------------------------------
    // Input(s)                 // Description(s)
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry in
    //--------------------------//--------------------------------------------
    // Output(s)                // Description(s)
    //--------------------------//---------------------------------------------
    output wire [N-1:0] c,      // Result
    output wire         co      // Carry out
);


endmodule : DataFlowReducedFullAdd
`default_nettype wire
