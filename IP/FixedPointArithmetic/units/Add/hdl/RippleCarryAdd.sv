//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   AddS
// Algorithm:   RippleCarryAdd
// Model:       Behavioral, Dataflow, Structural
// Description:
// SUM:
//     Truth Table                      K-Map
// .---.---.-----.---.  .------------.----------.---------.
// | a | b | ci | c |  |          c | ci' (0) | ci (1) |
// :---+---+-----+---:  :------------+----------+---------:
// | 0 | 0 |  0  | 0 |  | a' b' (00) |     0    |    1    | 
// | 0 | 0 |  1  | 1 |  :------------+----------+---------:   
// | 0 | 1 |  0  | 1 |  | a' b  (01) |     1    |    0    |  
// | 0 | 1 |  1  | 0 |  :------------+----------+---------:
// | 1 | 0 |  0  | 1 |  | a  b  (11) |     0    |    1    | 
// | 1 | 0 |  1  | 0 |  :------------+----------+---------:
// | 1 | 1 |  0  | 0 |  | a  b' (10) |     1    |    0    |
// | 1 | 1 |  1  | 1 |  '------------'----------'---------'
// '---'---'-----'---'
// SOP: c = (a'·b'·ci) + (a'·b·ci') + (a·b·ci) + (a·b'·ci') From the K-Map
//        = a·(b·ci + b'·ci') + a'·(b·ci' + b'·ci)
//        = a·~(b^c) + a'·(b^c)
//        = a ^ (b ^ c)
//        = a ^ b ^ c
//-----------------------------------------------------------------------------
// CARRY:
//     Truth Table                      K-Map
// .---.---.----.----.  .------------.---------.--------.
// | a | b | ci | co |  |         co | ci' (0) | ci (1) |
// :---+---+----+----:  :------------+---------+--------:
// | 0 | 0 | 0  | 0  |  | a' b' (00) |    0    |   0    | 
// | 0 | 0 | 1  | 0  |  :------------+---------+--------:   
// | 0 | 1 | 0  | 0  |  | a' b  (01) |    0    |   1    |  
// | 0 | 1 | 1  | 1  |  :------------+---------+--------:
// | 1 | 0 | 0  | 0  |  | a  b  (11) |    1    |   1    | 
// | 1 | 0 | 1  | 1  |  :------------+---------+--------:
// | 1 | 1 | 0  | 1  |  | a  b' (10) |    0    |   1    |
// | 1 | 1 | 1  | 1  |  '------------'---------'--------'
// '---'---'----'----'
// SOP: co = (b·ci) + (a·ci) + (a·b)
//           = ci·(a + b) + (a·b)
//-----------------------------------------------------------------------------
`default_nettype none
module RippleCarryAdd
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Descriptions
    //--------------------------------------//---------------------------------
    parameter integer N     = 32,           // Datapath width in bits.
    parameter string  MODEL = "Behavioral"  // Which modeling style
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Descriptions
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  // Operand A
    input  wire [N-1:0] b,                  // Operand B
    input  wire         ci,                 // Carry in
    //--------------------------------------//---------------------------------
    // Outputs                              // Descriptions
    //--------------------------------------//---------------------------------
    output reg  [N-1:0] c,                  // Result C
    output reg          co                  // Carry out
);
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    
    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    generate
        if (MODEL == "Behavioral") begin : BEHAVIORAL_INTANSTIATION
            BehavioralRippleCarryAdd
            #(  //---------------------//--------------------------------------
                // Parameters          // Descriptions
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_BehavioralRippleCarryAdd //
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//---------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .ci   ( ci          ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .co   ( co          )  // [O][1] Result Carry
            );                         //
        end : BEHAVIORAL_INTANSTIATION
        else if (MODEL == "DataFlow") begin : DATAFLOW_INTANSTIATION
            DataFlowRippleCarryAdd
            #(  //---------------------//--------------------------------------
                // Parameters          // Descriptions
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_DataFlowRippleCarryAdd   //
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .ci   ( ci          ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .co   ( co          )  // [O][1] Result Carry
            );                         //
        end : DATAFLOW_INTANSTIATION
        else if (MODEL == "Structural") begin : STRUCTURAL_INSTANTIATION
            StructuralRippleCarryAdd
            #(  //---------------------//--------------------------------------
                // Parameters          // Descriptions
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_StructuralRippleCarryAdd //
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .ci    ( ci         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .co   ( co          )  // [O][1] Result Carry
            );                         //
        end : STRUCTURAL_INSTANTIATION
    endgenerate

endmodule : RippleCarryAdd
`default_nettype wire
