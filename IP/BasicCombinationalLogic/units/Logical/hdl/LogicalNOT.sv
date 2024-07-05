//-----------------------------------------------------------------------------
// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Create Date: 11/26/2020, 1:19:27 PM 
// Design Name: Logical NOT
// Module Name: LogicalNOT
// Project Name: BasicCombinationalLogic
// Dependencies: 
// - StructuralLogicalNOT
// - BehavioralLogicalNOT
// - DataFlowLogicalNOT
//-----------------------------------------------------------------------------
`default_nettype none
module LogicalNOT
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter string  MODEL = "Structural", // "Structural", "Behavioral", or "DataFlow" modeling.    
    parameter integer N     = 8             // Width of operands in bits.
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
            StructuralLogicalNOT
                #(
                //--------------------------//---------------------------------
                // Parameter(s)             // Description(s)
                //--------------------------//---------------------------------
                .N ( N                    ) // Width of operands in bits.
            )                               //
            u_StructuralLogicalNOT         //
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
            BehavioralLogicalNOT
            #(  //---------------------------//--------------------------------
                // Parameter(s)              // Description(s)
                //---------------------------//--------------------------------
                .N ( N                    )  // Width of operands in bits.
            )
            u_BehavioralLogicalNOT
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
            DataFlowLogicalNOT
            #(  //---------------------------//--------------------------------
                // Parameter(s)              // Description(s)
                //---------------------------//--------------------------------
                .N ( N                    )  // Width of operands in bits.
            )
            u_DataFlowLogicalNOT
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

endmodule : LogicalNOT
`default_nettype wire
