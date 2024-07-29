//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   RippleCarryAdd
// Model:       Structural
// Description:
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralRippleCarryAdd
#(  //--------------------------//-----------------------------------------
    // Parameters               // Descriptions
    //--------------------------//-----------------------------------------
    parameter integer   N = 32  // Datapath width in bits
)  (//--------------------------//-----------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//-----------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry in
    //--------------------------//-----------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//-----------------------------------------
    output wire [N-1:0] c,      // Result
    output wire         co      // Carry out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire [N:0] cx;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combination Logic
    //-------------------------------------------------------------------------
    assign cx[0] = ci;
    assign co    = cx[N];

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------            
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION
        StructuralFullAdder
        (   //---------------//------------------------------------------------
            // Inputs      // Direction, Size & Descriptions
            //---------------//------------------------------------------------
            .a  ( a[i]    ), // [I][1] Operand A
            .b  ( b[i]    ), // [I][1] Operand B
            .ci ( cx[i]   ), // [I][1] Carry in
            //---------------//------------------------------------------------
            // Outputs       // Direction, Size & Descriptions
            //---------------//------------------------------------------------
            .c  ( c[i]    ), // [O][1] Result C
            .co ( cx[i+1] )  // [O][1] Carry out
        );
    end : STRUCTURAL_GENERATION
    endgenerate

endmodule : StructuralRippleCarryAdd
`default_nettype wire
