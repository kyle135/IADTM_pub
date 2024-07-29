//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   ReducedFullAdd
// Modeling:    Behavioral, Dataflow, Structural
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module ReducedFullAdd
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Descriptions
    //--------------------------------------//---------------------------------
    parameter string  MODEL = "Behavioral"  // Which modeling style
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Descriptions
    //--------------------------------------//---------------------------------
    input  wire a,                          // Operand A
    input  wire b,                          // Operand B
    input  wire ci,                         // Carry in
    //--------------------------------------//---------------------------------
    // Outputs                              // Descriptions
    //--------------------------------------//---------------------------------
    output wire c,                          // Result C
    output wire co                          // Carry out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    
    //-------------------------------------------------------------------------
    // Sequential Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    generate
        if (MODEL == "Behavioral") begin : BEHAVIORAL_INTANSTIATION
            BehavioralReducedFullAdd u_BehavioralReducedFullAdd
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][1] Operand A
                .b    ( b           ), // [I][1] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][1] Result Sum
                .co   ( co          )  // [O][1] Result Carry
            );                         //
        end : BEHAVIORAL_INTANSTIATION
        else if (MODEL == "DataFlow") begin : DATAFLOW_INTANSTIATION
            DataFlowReducedFullAdd u_DataFlowReducedFullAdd
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][1] Operand A
                .b    ( b           ), // [I][1] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][1] Result Sum
                .co   ( co          )  // [O][1] Result Carry
            );                         //
        end : DATAFLOW_INTANSTIATION
        else if (MODEL == "Structural") begin : STRUCTURAL_INSTANTIATION
            StructuralReducedFullAdd u_StructuralReducedFullAdd
            (   //---------------------//--------------------------------------
                // Inputs              // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .a    ( a           ), // [I][1] Operand A
                .b    ( b           ), // [I][1] Operand B
                .cin  ( cin         ), // [I][1] Carry In
                //---------------------//--------------------------------------
                // Outputs             // Direction, Size & Descriptions
                //---------------------//--------------------------------------
                .c    ( c           ), // [O][1] Result Sum
                .co   ( co          )  // [O][1] Result Carry
            );                         //
        end : STRUCTURAL_INSTANTIATION
    endgenerate

endmodule : ReducedFullAdd
`default_nettype wire
