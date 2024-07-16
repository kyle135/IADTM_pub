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
    parameter string  ALGORITHM = "BS_COMPLEMENT"  //
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
        // B’s Complement Subtraction
        if (ALGORITHM == "BS_COMPLEMENT") begin : BS_COMPLEMENT_ALGORITHM
            assign a_extended = {a[N-1], a};
            assign b_extended = {b[N-1], b};
    
            for (n =0; n <=N; n = n + 1) begin
                assign b_prime[n] = 1 - b_extended[n];
            end
        end : BS_COMPLEMENT_ALGORITHM
    endgenerate

    FixedPointAdd
    #(  //--------------------------//-----------------------------------------
        // Paremeter(s)             // Description(s)
        //--------------------------//-----------------------------------------
        .N          ( N+1        )  //
    )                               //
    u_FixedPointAdd                 //
    (   //--------------------------//-----------------------------------------
        //                          // Direction, Size & Descriptions
        //--------------------------//-----------------------------------------
        .a          ( a_extended ), // [I][N+1]
        .b          ( b_extended ), // [I][N+1]
        .carry_in   ( b_prime    ), // [I][  1]
        .c          ( c          ), // [O][N+1]
        .carry_out  ( carry_out  )  // [O][  1]
    );

endmodule : FixedPointSubtract
`default_nettype wire
