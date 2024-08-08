



`default_nettype none
module Divide
#(  //----------------------------------//---------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//---------------------------------
    parameter integer N   = 32,         // Data Path width in bits.
    parameter string  TOP = "RTL"       // Modeling Technique
)  (//----------------------------------//---------------------------------
    // Inputs                           // Description(s)
    //----------------------------------//---------------------------------
    input  wire [  N-1:0] a,            // Operand A
    input  wire [  N-1:0] b,            // Operand B
    //----------------------------------//--------------------------------
    // Outputs                          // Description(s)
    //----------------------------------//--------------------------------
    output wire [2*N-1:0] c
);


    generate
        if (TOP == "RTL") begin
            assign c = a / b;
        end
    endgenerate


endmodule : Divide
`default_nettype wire
