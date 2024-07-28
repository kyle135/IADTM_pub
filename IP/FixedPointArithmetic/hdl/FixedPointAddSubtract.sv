//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//-----------------------------------------------------------------------------
module FixedPointAdd
#(  //----------------------------------------------//-------------------------
    // Parameters                                   // Description(s)
    //----------------------------------------------//-------------------------
    parameter int    N         = 32,                //
    parameter string MODEL     = "Structural",      //
    parameter string ALGORITHM = "RippleCarry"      //
)  (//----------------------------------------------//-------------------------
    // Inputs                                       // Description(s)
    //----------------------------------------------//-------------------------
    input  wire [N-1:0] a,                          //
    input  wire [N-1:0] b,                          //
    input  wire         carry_in,                   //
    //----------------------------------------------//-------------------------
    // Outputs                                      // Description(s)
    //----------------------------------------------//-------------------------
    output wire [N-1:0] c,                          //
    output wire         carry_out                   //
);
        
    //-------------------------------------------------------------------------
    // Local Signals
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
        if (ALGORITHM == "RippleCarry") begin : ADDRIPPLECARRY_INTANSTIATION
            AddRippleCarry
            #(  //----------------------------------//---------------------------------
                // Parameters                       // Description(s)
                //----------------------------------//---------------------------------
                .N         ( N                   ), //
                .MODEL     ( MODEL               )  //
            )                                       //
            u_AddRippleCarry                        //
            (   //----------------------------------//---------------------------------
                // Inputs                           // Direction, Size & Description(s)
                //----------------------------------//---------------------------------
                .a         ( a                   ), // [I][N] Operand A
                .b         ( b                   ), // [I][N] Operand B
                .carry_in  ( carry_in            ), // [I][1] Carry In
                //----------------------------------//---------------------------------
                // Outputs                          // Direction, Size & Description(s)
                //----------------------------------//---------------------------------
                .c         ( c                   ), // [O][N] Result Sum
                .carry_out ( carry_out           )  // [O][1] Result Carry
            );                                      //
        end : ADDRIPPLECARRY_INTANSTIATION
        else begin : RTL_CODE
            assign {carry_out, c} = a + b + carry_in;
        end : RTL_CODE
    endgenerate
    
endmodule : FixedPointAdd
    