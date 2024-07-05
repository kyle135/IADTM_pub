`default_nettype none
module FixedPointSubtract
#(  //------------------------------//-----------------------------------------
    //                              // Description(s)
    //------------------------------//-----------------------------------------
    parameter integer   N = 32      // Data path width in bits.
)  (//------------------------------//-----------------------------------------
    //                              // Description(s)
    //------------------------------//-----------------------------------------
    input  wire [N-1:0] a,          //
	input  wire [N-1:0] b,          //
    input  wire         carry_in,   //
	output wire         carry_out,  //
	output wire [N-1:0] c           //
);
   
   
   wire [N-1:0] a_extended;
   wire [N-1:0] b_extended;
   
    FixedPointAdd
    #(  //--------------------------//-----------------------------------------
        // Paremeter(s)             // Description(s)
        //--------------------------//-----------------------------------------
        .N          ( N          )  //
    )                               //
    u_FixedPointAdd                 //
    (   //--------------------------//-----------------------------------------
        //                          // Direction, Size & Descriptions
        //--------------------------//-----------------------------------------
        .a          ( a_extended ), // [I][ W]
        .b          ( b_extended ), // [I][ W]
        .carry_in   ( carry_in   ), // [I][ 1]
        .c          ( c          ), // [O][ W]
        .carry_out  ( carry_out  )  // [O][ 1]
    );
   


    assign a_extended = ~a + 1;
    assign b_extended =  b;
   
endmodule : FixedPointSubtract
`default_nettype wire