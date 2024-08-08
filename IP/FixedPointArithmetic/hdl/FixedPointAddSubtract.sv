//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Description: 
//
//-----------------------------------------------------------------------------
`default_nettype none
module FixedPointAddSubtract
#(  //------------------------------------------//-----------------------------
    // Parameters                               // Descriptions
    //------------------------------------------//-----------------------------
    parameter int    N         = 32,            // Datapath width in bits.
    parameter string MODEL     = "Structural",  // Modeling Technique
    parameter string ALGORITHM = "RippleCarry"  // Algorithm to be used.
)  (//------------------------------------------//-----------------------------
    // Inputs                                   // Descriptions
    //------------------------------------------//-----------------------------
    input  wire         subtract,               // Control signal to enable subtract
    input  wire [N-1:0] a,                      // Operand A
    input  wire [N-1:0] b,                      // Operand B
    //------------------------------------------//-----------------------------
    // Outputs                                  // Descriptions
    //------------------------------------------//-----------------------------
    output wire [N-1:0] c,                      // Result C
    output wire         co                      // Carry Out
);
        
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire [N-1:0] a_complemented;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
        
    //-------------------------------------------------------------------------
    // Sequential Logic
    //-------------------------------------------------------------------------
    assign a_complemented = ~a;
    assign a_selected     = subtract ? a_complemented : a;

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    Add
    #(  //----------------------------------//---------------------------------
        // Parameters                       // Descriptions
        //----------------------------------//---------------------------------
        .N          ( N                  ), // Datapath width in bits.
        .MODEL      ( MODEL              ), // Modeling Technique
        .ALGORITHM  ( ALGORITHM          )  // Algorithm to be used.
    )                                       //
    u_Add                                   //
    (   //----------------------------------//---------------------------------
        // Inputs                           // Direction, Size & Descriptions
        //----------------------------------//---------------------------------
        .a          ( a_selected         ), // [I][N] Operand A
        .b          ( b                  ), // [I][N] Operand B
        .ci         ( subtract           ), // [I][1] Carry In
        //----------------------------------//---------------------------------
        // Outputs                          // Direction, Size & Descriptions
        //----------------------------------//---------------------------------
        .c          ( c                  ), // [O][N] Result C
        .co         ( co                 )  // [O][1] Result Carry
    );                                      //
    
endmodule : FixedPointAdd
`default_nettype wire
