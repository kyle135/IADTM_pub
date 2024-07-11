//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------

`default_nettype none
module FixedPointArithmetic(



);


typedef enum logic [2:0] {      //
    ROTATE_RIGHT_SHIFT     = 0, // Wrap-around
    LOGICAL_RIGHT_SHIFT    = 1, // 0 into LSB
    ARITHMETIC_RIGHT_SHIFT = 2, // Replicate MSB
    ROTATE_LEFT_SHIFT      = 3, //
    LOGICAL_LEFT_SHIFT     = 4, // 0 into MSB
    ARITHMETIC_LEFT_SHIFT  = 5  // 0 into LSB
} ShiftOperation_t;             //




endmodule : FixedPointArithmetic
`default_nettype wire
