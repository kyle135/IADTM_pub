//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralRippleCarryAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Description(s)
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits
)  (//--------------------------//---------------------------------------------
    // Input(s)                 // Description(s)
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry In
    //--------------------------//---------------------------------------------
    // Outputs                  // Description(s)
    //--------------------------//---------------------------------------------
    output reg  [N-1:0] c,      // Result C
    output reg          co      // Carry Out
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    reg [N-1:0] cx;             // Internal carry chain

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    always@* c  = a ^ b ^ {cx[N-2:0], ci};
    always@* cx = {cx[N-2:0], ci} & (a | b) | (a & b);
    always@* co = cx[N-1];

endmodule : BehavioralRippleCarryAdd
`default_nettype wire
