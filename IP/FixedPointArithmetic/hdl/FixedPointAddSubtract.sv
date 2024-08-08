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
    parameter int    N     = 32,                // Datapath width in bits.
    parameter string MODEL = "Structural",      // Modeling Technique
    parameter string TOP   = "RippleCarryAdd"   // TOP to be used.
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
    logic [N-1:0] b_complemented;
    logic [N-1:0] b_selected;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    assign b_complemented = ~b;
    // Stupid Hack
    assign b_selected     = subtract ? b_complemented : b;
    
    //-------------------------------------------------------------------------
    // Sequential Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    Add
    #(  //-------------------------//------------------------------------------
        // Parameters              // Descriptions
        //-------------------------//------------------------------------------
        .N      ( N             ), // Datapath width in bits.
        .MODEL  ( MODEL         ), // Modeling Technique
        .TOP    ( TOP           )  // TOP to be used.
    )                              //
    u_Add                          //
    (   //-------------------------//------------------------------------------
        // Inputs                  // Direction, Size & Descriptions
        //-------------------------//------------------------------------------
        .a      ( a             ), // [I][N] Operand A
        .b      ( b_selected    ), // [I][N] Operand B
        .ci     ( subtract      ), // [I][1] Carry In
        //-------------------------//------------------------------------------
        // Outputs                 // Direction, Size & Descriptions
        //-------------------------//------------------------------------------
        .c      ( c             ), // [O][N] Result C
        .co     ( co            )  // [O][1] Result Carry
    );                             //
    
endmodule : FixedPointAddSubtract
`default_nettype wire
