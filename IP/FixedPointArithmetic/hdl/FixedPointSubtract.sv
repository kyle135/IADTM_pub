//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  Fixed Point Arithmetic
// IP Name:      FixedPointSubtract
// Description:  
// Dependencies: 
//
//-----------------------------------------------------------------------------
`default_nettype none
module FixedPointSubtract
#(  //---------------------------------------------//------------------------------------
    // Parameter(s)                                // Description(s)
    //---------------------------------------------//------------------------------------
    parameter integer N         = 32,              // Data path width in bits.
    parameter string  ALGORITHM = "RippleCarrySubtraction"  //
)  (//---------------------------------------------//------------------------------------
    // Inputs                                      // Description(s)
    //---------------------------------------------//------------------------------------
    input  wire [N-1:0] a,                         //
	input  wire [N-1:0] b,                         //
    input  wire         carry_in,                  //
    //---------------------------------------------//------------------------------------
    // Inputs                                      // Description(s)
    //---------------------------------------------//------------------------------------
	output wire         carry_out,                 //
	output wire [N-1:0] c                          //
);
    //-----------------------------------------------------------------------------------
    // Local nets
    //-----------------------------------------------------------------------------------
    wire [N:0] a_extended;
    wire [N:0] b_extended;
    wire [N:0] b_prime;
    
    genvar n;
    generate
        if (ALGORITHM == "RippleCarrySubtraction") begin : RIPPLECARRYSUBTRACTION_INSTANCE
            RippleCarrySubtraction
            #(  //-------------------------//------------------------------------------
                // Paremeter(s)            // Description(s)
                //-------------------------//------------------------------------------
                .N          ( N         )  //
            )                              //
            u_RippleCarrySubtraction       //
            (   //-------------------------//------------------------------------------
                //                         // Direction, Size & Descriptions
                //-------------------------//------------------------------------------
                .a          ( a         ), // [I][N] Operand A
                .b          ( b         ), // [I][N] Operand B
                .carry_in   ( carry_in  ), // [I][1] Carry In
                .c          ( c         ), // [O][N] Result
                .carry_out  ( carry_out )  // [O][1] Carry out
            );
        end : RIPPLECARRYSUBTRACTION_INSTANCE
    endgenerate

endmodule : FixedPointSubtract
`default_nettype wire
