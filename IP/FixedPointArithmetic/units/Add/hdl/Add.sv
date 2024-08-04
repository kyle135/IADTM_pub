//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   FullAdd
// Model:       Behavioral
// Description: 
//-----------------------------------------------------------------------------
`default_nettype none
module Add
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //-----------------------------------------//---------------------------------------------
    parameter integer  N    = 32,              // Datapath width in bits
    parameter string   MODEL= "Behavioral",    //
    parameter string   TOP  = "RippleCarryAdd" //
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry in
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output reg  [N-1:0] c,      // Result
    output reg          co      // Carry out
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
        if (TOP == "RippleCarryAdd") begin : RIPPLECARRYADD_INTANSTIATION
            RippleCarryAdd
            #(  //------------------//-----------------------------------------
                // Parameters       // Descriptions
                //------------------//-----------------------------------------
                .N      ( N      ), // Data-path width in bits
                .MODEL  ( MODEL  )  // Which modeling technique
            )                       //
            u_RippleCarryAdd        //
            (   //------------------//-----------------------------------------
                // Inputs           // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .a      ( a      ), // [I][N] Operand A
                .b      ( b      ), // [I][N] Operand B
                .ci     ( ci     ), // [I][1] Carry In
                //------------------//-----------------------------------------
                // Outputs          // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .c      ( c      ), // [O][N] Result Sum
                .co     ( co     )  // [O][1] Result Carry
            );                      //
        end : RIPPLECARRYADD_INTANSTIATION
        else if (TOP == "CarryLookAheadAdd") begin : CARRYLOOKAHEADADD_INTANSTIATION
            CarryLookAheadAdd
            #(  //------------------//-----------------------------------------
                // Parameters       // Descriptions
                //------------------//-----------------------------------------
                .N      ( N      ), // Data-path width in bits.
                .MODEL  ( MODEL  )  // Which modeling technique?
            )                       //
            u_CarryLookAheadAdd     //
            (   //------------------//-----------------------------------------
                // Inputs           // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .a      ( a      ), // [I][N] Operand A
                .b      ( b      ), // [I][N] Operand B
                .ci     ( ci     ), // [I][1] Carry In
                //------------------//-----------------------------------------
                // Outputs          // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .c      ( c      ), // [O][N] Result Sum
                .co     ( co     )  // [O][1] Result Carry
            );                      //
        end : CARRYLOOKAHEADADD_INTANSTIATION
        else if (TOP == "BlockCarryLookAhead") begin : BLOCKCARRYLOOKAHEAD_INSTANTIATION
            BlockCarryLookAhead
            #(  //------------------//-----------------------------------------
                // Parameters       // Descriptions
                //------------------//-----------------------------------------
                .N      ( N      ), // Data-path width in bits.
                .MODEL  ( MODEL  )  // Which modeling technique?
            )                       //
            u_BlockCarryLookAhead
            (   //------------------//-----------------------------------------
                // Inputs           // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .a      ( a      ), // [I][N] Operand A
                .b      ( b      ), // [I][N] Operand B
                .ci     ( ci     ), // [I][1] Carry In
                //------------------//-----------------------------------------
                // Outputs          // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .c      ( c      ), // [O][N] Result Sum
                .co     ( co     )  // [O][1] Result Carry
            );                      //
        end : BLOCKCARRYLOOKAHEAD_INSTANTIATION
        else if (TOP == "CarrySkipAdd") begin : CARRYSKIPADD_INSTANTIATION
            CarrySkipAdd
            #(  //------------------//-----------------------------------------
                // Parameters       // Descriptions
                //------------------//-----------------------------------------
                .N      ( N      ), // Data-path width in bits.
                .MODEL  ( MODEL  )  // Which modeling technique?
            )                       //
            u_CarrySkipAdd          //
            (   //------------------//-----------------------------------------
                // Inputs           // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .a      ( a      ), // [I][N] Operand A
                .b      ( b      ), // [I][N] Operand B
                .ci     ( ci     ), // [I][1] Carry In
                //------------------//-----------------------------------------
                // Outputs          // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .c      ( c      ), // [O][N] Result Sum
                .co     ( co     )  // [O][1] Result Carry
            );                      //
        end : CARRYSKIPADD_INSTANTIATION
        else if (TOP == "CarrySaveAdd") begin : CARRYSAVEADD_INSTANTIATION
            CarrySaveAdd
            #(  //------------------//-----------------------------------------
                // Parameters       // Descriptions
                //------------------//-----------------------------------------
                .N      ( N      ), // Data-path width in bits.
                .MODEL  ( MODEL  )  // Which modeling technique?
            )                       //
            u_CarrySaveAdd          //
            (   //------------------//-----------------------------------------
                // Inputs           // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .a      ( a      ), // [I][N] Operand A
                .b      ( b      ), // [I][N] Operand B
                .ci     ( ci     ), // [I][1] Carry In
                //------------------//-----------------------------------------
                // Outputs          // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .c      ( c      ), // [O][N] Result Sum
                .co     ( co     )  // [O][1] Result Carry
            );                      //
        end : CARRYSAVEADD_INSTANTIATION
        else if (TOP == "CarrySelectAdd") begin : CARRYSELECTADD_INSTANTIATION
            CarrySelectAdd
            #(  //------------------//-----------------------------------------
                // Parameters       // Descriptions
                //------------------//-----------------------------------------
                .N      ( N      ), // Data-path width in bits.
                .MODEL  ( MODEL  )  // Which modeling technique?
            )                       //
            u_CarrySelectAdd        //
            (   //------------------//-----------------------------------------
                // Inputs           // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .a      ( a      ), // [I][N] Operand A
                .b      ( b      ), // [I][N] Operand B
                .ci     ( ci     ), // [I][1] Carry In
                //------------------//-----------------------------------------
                // Outputs          // Direction, Size & Descriptions
                //------------------//-----------------------------------------
                .c      ( c      ), // [O][N] Result Sum
                .co     ( co     )  // [O][1] Result Carry
            );                      //
        end : CARRYSELECTADD_INSTANTIATION
    endgenerate

endmodule : Add
`default_nettype wire
