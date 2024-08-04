//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   CarryLookAheadAdd
// Model:       Structural
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralCarryLookAheadAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits.
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire [N-1:0] ci,     // Carry In
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output wire [N-1:0] c,      // Result C
    output wire         co      // Carry Out
);
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire [N-1:0] cg;
    wire [N-1:0] cp;
    wire [N  :0] cx;
    
    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    assign cx[0] = ci;
    assign co    = cx[N-1];

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------        
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION
        StructuralReducedFullAdd 
        #(  //--------------//-------------------------------------------------
            // Parameters // Descriptions
            //--------------//-------------------------------------------------
            .N   ( 1     )  // Datapath width in bits.
        )
        u_StructuralReducedFullAdd_carry
        (   //--------------//-------------------------------------------------
            // Inputs     // Direction, Size and Descriptions
            //--------------//-------------------------------------------------
            .a   ( a[i]  ), // [I][1] Operand A
            .b   ( b[i]  ), // [I][1] Operand B
            .ci ( cx[i] ), // [I][1] Carry In
            //--------------//-------------------------------------------------
            // Outputs    // Direction, Size and Descriptions
            //--------------//-------------------------------------------------
            .c   ( c[i]  ), // [O][1] Result
            .cg  ( cg[i] ), // [O][1] Carry Generate
            .cp  ( cp[i] )  // [O][1] Carry Propagate
        );

        StructuralCarryLookAheadGenerator
        #(  //--------------//----------------------------------------------
            // Parameters // Descriptions
            //--------------//----------------------------------------------
            .N   ( 1     )  // Datapath width in bits.
        )
        u_StructuralCarryLookAheadGenerator
        (   //--------------//----------------------------------------------
            // Inputs     // Direction, Size & Descriptions
            //--------------//----------------------------------------------
            .a   ( a[i]  ), // [I][1] Operand A
            .b   ( b[i]  ), // [I][1] Operand B
            .cp  ( cp[i] ), // [I][1] Carry Propagate
            .cg  ( cg[i] ), // [I][1] Carry Generate
            .ci  ( cx[i] ), // [I][1] Carry In
            //--------------//----------------------------------------------
            // Outputs    // Direction, Size & Descriptions
            //--------------//----------------------------------------------
            .co ( cx[i+1])  // [O][1] Carry Out
        );

    end : STRUCTURAL_GENERATION
    endgenerate

endmodule : StructuralCarryLookAheadAdd
`default_nettype wire
