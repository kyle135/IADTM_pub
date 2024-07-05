//-------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 11/26/2020, 1:19:27 PM 
// Design Name: Unary NXOR
// Module Name: UnaryNXOR
// Project Name: BasicCombinationalLogic
// Dependencies: 
// - StructuralUnaryNXOR
// - BehavioralUnaryNXOR
// - DataFlowUnaryNXOR
//-----------------------------------------------------------------------------
`default_nettype none
module UnaryNXOR
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
            StructuralUnaryNXOR
                #(
                //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                    ) // Width of operands in bits.
            )                               //
            u_StructuralUnaryNXOR          //
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
            BehavioralUnaryNXOR
            #(  //---------------------------//--------------------------------
                // Parameter(s)              // Description(s)
                //---------------------------//--------------------------------
                .N ( N                    )  // Width of operands in bits.
            )
            u_BehavioralUnaryNXOR
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
            DataFlowUnaryNXOR
            #(  //---------------------------//--------------------------------
                // Parameter(s)              // Description(s)
                //---------------------------//--------------------------------
                .N ( N                    )  // Width of operands in bits.
            )
            u_DataFlowUnaryNXOR
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

endmodule : UnaryNXOR
`default_nettype wire
