//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   AddSubtract
// Algorithm:   CarrySaveAdd
// Modeling:    Behavioral, Dataflow, Structural
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module CarrySaveAdd
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
    output wire [N-1:0] c,                  // Result C
    output wire         co                  // Carry out
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
            BehavioralCarrySaveAdd
            #(  //---------------------//--------------------------------------
                // Parameter(s)        // Description(s)
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_BehavioralCarrySaveAdd   //
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
            DataFlowCarrySaveAdd
            #(  //---------------------//--------------------------------------
                // Parameter(s)        // Description(s)
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_DataFlowCarrySaveAdd     //
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
            StructuralCarrySaveAdd
            #(  //---------------------//--------------------------------------
                // Parameter(s)        // Description(s)
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_StructuralCarrySaveAdd   //
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

endmodule : CarrySaveAdd
`default_nettype wire