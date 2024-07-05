//-------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 11/26/2020, 1:19:27 PM 
// Design Name: Unary NAND
// Module Name: UnaryNAND
// Project Name: BasicCombinationalLogic
// Dependencies: 
// - StructuralUnaryNAND
// - BehavioralUnaryNAND
// - DataFlowUnaryNAND
//-----------------------------------------------------------------------------
`default_nettype none
module UnaryNAND
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter string  MODEL = "Structural", // "Structural", "Behavioral", or "DataFlow" modeling.
    parameter integer N = 8                 // Width of operands in bits.
)  (//--------------------------------------//---------------------------------
    // Input Ports                          // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  // Operand A
    //--------------------------------------//---------------------------------
    // Output Ports                         // Description(s)
    //--------------------------------------//---------------------------------
    output wire         c                   // Result C
);

    generate
        if (MODEL == "Structural") begin
            StructuralUnaryNAND
                #(
                //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                    ) // Width of operands in bits.
            )                               //
            u_StructuralUnaryNAND          //
            (   //--------------------------//---------------------------------
                // Input(s)                 // Direction, Size & Description(s)
                //--------------------------//---------------------------------
                .a ( a                   ), // [I][N] Operand A
                //--------------------------//---------------------------------
                // Output(s)                // Direction, Size & Description(s)
                //--------------------------//---------------------------------
                .c ( c                   )  // [I][1] Result C
            );
        end
        else if (MODEL == "Behavioral") begin
            BehavioralUnaryNAND
            #(  //---------------------------//--------------------------------
                // Parameter(s)              // Description(s)
                //---------------------------//--------------------------------
                .N ( N                    )  // Width of operands in bits.
            )
            u_BehavioralUnaryNAND
            (   //---------------------------//--------------------------------
                // Input(s)                  // Direction, Size & Description(s)
                //---------------------------//--------------------------------
                .a ( a                    ), // [I][N] Operand A
                //---------------------------//--------------------------------
                // Output(s)                 // Direction, Size & Description(s)
                //---------------------------//--------------------------------
                .c ( c                    )  // [I][1] Result C
            );
        end
        else if (MODEL == "DataFlow") begin
            DataFlowUnaryNAND
            #(  //---------------------------//--------------------------------
                // Parameter(s)              // Description(s)
                //---------------------------//--------------------------------
                .N ( N                    )  // Width of operands in bits.
            )
            u_DataFlowUnaryNAND
            (   //---------------------------//--------------------------------
                // Input(s)                  // Direction, Size & Description(s)
                //---------------------------//--------------------------------
                .a ( a                    ), // [I][N] Operand A
                //---------------------------//--------------------------------
                // Output(s)                 // Direction, Size & Description(s)
                //---------------------------//--------------------------------
                .c ( c                    )  // [I][1] Result C
            );
    end
    endgenerate

endmodule : UnaryNAND
`default_nettype wire
