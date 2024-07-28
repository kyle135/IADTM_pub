//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   AddSubtract
// Algorithm:   RippleCarryAdd
// Modeling:    Behavioral, Dataflow, Structural
// Description:
// SUM:
//     Truth Table                      K-Map
// .---.---.-----.---.  .------------.----------.---------.
// | a | b | cin | c |  |          c | cin' (0) | cin (1) |
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
// SOP: c = (a'·b'·cin) + (a'·b·cin') + (a·b·cin) + (a·b'·cin') From the K-Map
//        = a·(b·cin + b'·cin') + a'·(b·cin' + b'·cin)
//        = a·~(b^c) + a'·(b^c)
//        = a ^ (b ^ c)
//        = a ^ b ^ c
//-----------------------------------------------------------------------------
// CARRY:
//     Truth Table                      K-Map
// .---.---.-----.------.  .------------.----------.---------.
// | a | b | cin | cout |  |       cout | cin' (0) | cin (1) |
// :---+---+-----+------:  :------------+----------+---------:
// | 0 | 0 |  0  |   0  |  | a' b' (00) |     0    |    0    | 
// | 0 | 0 |  1  |   0  |  :------------+----------+---------:   
// | 0 | 1 |  0  |   0  |  | a' b  (01) |     0    |    1    |  
// | 0 | 1 |  1  |   1  |  :------------+----------+---------:
// | 1 | 0 |  0  |   0  |  | a  b  (11) |     1    |    1    | 
// | 1 | 0 |  1  |   1  |  :------------+----------+---------:
// | 1 | 1 |  0  |   1  |  | a  b' (10) |     0    |    1    |
// | 1 | 1 |  1  |   1  |  '------------'----------'---------'
// '---'---'-----'------'
// SOP: cout = (b·cin) + (a·cin) + (a·b)
//           = cin·(a + b) + (a·b)
//-----------------------------------------------------------------------------
`default_nettype none
module RippleCarryAdd
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter integer N     = 32,           // Datapath width in bits.
    parameter string  MODEL = "Behavioral"  // Which modeling style
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  // Operand A
    input  wire [N-1:0] b,                  // Operand B
    input  wire         ci,                 // Carry in
    //--------------------------------------//---------------------------------
    // Outputs                              // Description(s)
    //--------------------------------------//---------------------------------
    output reg  [N-1:0] c,                  // Result C
    output reg          co                  // Carry out
);
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    
    //-------------------------------------------------------------------------
    // Sequential Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    generate
        if (MODEL == "Behavioral") begin : BEHAVIORAL_INTANSTIATION
            BehavioralRippleCarryAdd
            #(  //---------------------//--------------------------------------
                // Parameter(s)        // Description(s)
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_BehavioralRippleCarryAdd //
            (   //---------------------//--------------------------------------
                // Input(s)            // Direction, Size & Description(s)
                //---------------------//---------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Output(s)           // Direction, Size & Description(s)
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .cout ( cout        )  // [O][1] Result Carry
            );                         //
        end : BEHAVIORAL_INTANSTIATION
        else if (MODEL == "DataFlow") begin : DATAFLOW_INTANSTIATION
            DataFlowRippleCarryAdd
            #(  //---------------------//--------------------------------------
                // Parameter(s)        // Description(s)
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_DataFlowRippleCarryAdd   //
            (   //---------------------//--------------------------------------
                // Input(s)            // Direction, Size & Description(s)
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Output(s)           // Direction, Size & Description(s)
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .cout ( cout        )  // [O][1] Result Carry
            );                         //
        end : DATAFLOW_INTANSTIATION
        else if (MODEL == "Structural") begin : STRUCTURAL_INSTANTIATION
            StructuralRippleCarryAdd
            #(  //---------------------//--------------------------------------
                // Parameter(s)        // Description(s)
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_StructuralRippleCarryAdd //
            (   //---------------------//--------------------------------------
                // Input(s)            // Direction, Size & Description(s)
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Output(s)           // Direction, Size & Description(s)
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .cout ( cout        )  // [O][1] Result Carry
            );                         //
        end : STRUCTURAL_INSTANTIATION
    endgenerate

endmodule : RippleCarryAdd
`default_nettype wire
