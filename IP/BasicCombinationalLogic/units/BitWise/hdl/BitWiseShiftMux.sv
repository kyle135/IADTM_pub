//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Bit-Wise Shif mux tOP
// Module Name:  BitWiseShiftMUX
// Dependencies: 
//-----------------------------------------------------------------------------
module BitWiseShiftMUX
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8             // The width in bits of the operand and result.
)  (//----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output wire [N-1:0] c,              // The output that was selected.
    //----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire         sel,            // The selection line
    input  wire [N-1:0] a,              // Operand A
    input  wire [N-1:0] b               // Operand B
);
    
    assign c = sel ? a : b;
    
endmodule : BitWiseShiftMUX