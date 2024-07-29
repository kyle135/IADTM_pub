//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   CarrySelectAdd
// Modeling:    Behavioral, Dataflow, Structural
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module CarrySelectAdd
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Descriptions
    //--------------------------------------//---------------------------------
    parameter integer N     = 32,           // Datapath width in bits.
    parameter string  MODEL = "Behavioral"  // Which modelling style
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Descriptions
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  // Operand A
    input  wire [N-1:0] b,                  // Operand B
    input  wire         ci,                 // Carry in
    //--------------------------------------//---------------------------------
    // Outputs                              // Descriptions
    //--------------------------------------//---------------------------------
    output wire [N-1:0] c,                  // Result C
    output wire         co                  // Carry out
);

    generate
        if (MODEL == "Behavioral") begin : BEHAVIORAL_INTANSTIATION
            BehavioralCarrySelectAdd
            #(  //---------------------//--------------------------------------
                // Parameters          // Descriptions
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_BehavioralCarrySelectAdd //
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//---------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .cout ( cout        )  // [O][1] Result Carry
            );                         //
        end : BEHAVIORAL_INTANSTIATION
        else if (MODEL == "DataFlow") begin : DATAFLOW_INTANSTIATION
            DataFlowCarrySelectAdd
            #(  //---------------------//--------------------------------------
                // Parameters          // Descriptions
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_DataFlowCarrySelectAdd   //
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .cout ( cout        )  // [O][1] Result Carry
            );                         //
        end : DATAFLOW_INTANSTIATION
        else if (MODEL == "Structural") begin : STRUCTURAL_INSTANTIATION
            StructuralCarrySelectAdd
            #(  //---------------------//--------------------------------------
                // Parameters          // Descriptions
                //---------------------//--------------------------------------
                .N    ( N           )  // Data-path width in bits
            )                          //
            u_StructuralCarrySelectAdd //
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][N] Operand A
                .b    ( b           ), // [I][N] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][N] Result Sum
                .cout ( cout        )  // [O][1] Result Carry
            );                         //
        end : STRUCTURAL_INSTANTIATION
    endgenerate

endmodule : CarrySelectAdd
`default_nettype wire
