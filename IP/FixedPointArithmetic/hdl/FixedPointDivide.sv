//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Deisgn Name:  FixedPointArithmetic
// IP Name:      FixedPointDivide
//-----------------------------------------------------------------------------
module FixedPointDivide
#(  //-------------------------------------------
    //
    //--------------------------------
    parameter integer N = 32
)  (//--------------------------------
    //
    //-----------------------------------------
    input  wire [N-1:0] a,
	input  wire [N-1:0] b,
    //-----------------------------------------
    //
    //-----------------------------------------
	output wire [2*N-1:0] c
);


    assign c = a / b;


endmodule : FixedPointDivide
