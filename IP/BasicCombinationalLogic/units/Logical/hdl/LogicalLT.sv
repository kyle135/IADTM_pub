//-----------------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 11/26/2020, 1:19:27 PM 
// Design Name: Logically Less Than
// Module Name: LogicalLT
// Project Name: BasicCombinationalLogic
// Dependencies: 
// - StructuralLogicalLT
// - BehavioralLogicalLT
// - DataFlowLogicalLT
//-----------------------------------------------------------------------------
`default_nettype none
module LogicalLT
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter string  MODEL = "Structural", // "Structural", "Behavioral", or "DataFlow" modeling.    
    parameter integer N     = 8             // Width of operands in bits.
)  (//--------------------------------------//---------------------------------
    // Input Ports                          // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  // Operand A
    input  wire [N-1:0] b,                  // Operand B
    //--------------------------------------//---------------------------------
    // Output Ports                         // Description(s)
    //--------------------------------------//---------------------------------
    output wire         c                   // Result C
);

    generate
        if (MODEL == "Structural") begin
            StructuralLogicalLT
                #(
                //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                    ) // Width of operands in bits.
            )                               //
            u_StructuralLogicalLT         //
            (   //--------------------------//---------------------------------
                // Input(s)                 // Direction, Size & Description(s)
                //--------------------------//---------------------------------
                .a ( a                   ), // [I][N] Operand A
                .b ( b                   ), // [I][N] Operand A
                //--------------------------//---------------------------------
                // Output(s)                // Direction, Size & Description(s)
                //--------------------------//---------------------------------
                .c ( c                   )  // [I][1] Result C
            );
        end
        else if (MODEL == "Behavioral") begin
            BehavioralLogicalLT
            #(  //---------------------------//--------------------------------
                // Parameter(s)              // Description(s)
                //---------------------------//--------------------------------
                .N ( N                    )  // Width of operands in bits.
            )
            u_BehavioralLogicalLT
            (   //---------------------------//--------------------------------
                // Input(s)                  // Direction, Size & Description(s)
                //---------------------------//--------------------------------
                .a ( a                    ), // [I][N] Operand A
                .b ( b                    ), // [I][N] Operand B
                //---------------------------//--------------------------------
                // Output(s)                 // Direction, Size & Description(s)
                //---------------------------//--------------------------------
                .c ( c                    )  // [I][1] Result C
            );
        end
        else if (MODEL == "DataFlow") begin
            DataFlowLogicalLT
            #(  //---------------------------//--------------------------------
                // Parameter(s)              // Description(s)
                //---------------------------//--------------------------------
                .N ( N                    )  // Width of operands in bits.
            )
            u_DataFlowLogicalLT
            (   //---------------------------//--------------------------------
                // Input(s)                  // Direction, Size & Description(s)
                //---------------------------//--------------------------------
                .a ( a                    ), // [I][N] Operand A
                .b ( b                    ), // [I][N] Operand B
                //---------------------------//--------------------------------
                // Output(s)                 // Direction, Size & Description(s)
                //---------------------------//--------------------------------
                .c ( c                    )  // [I][1] Result C
            );
    end
    endgenerate

endmodule : LogicalLT
`default_nettype wire
