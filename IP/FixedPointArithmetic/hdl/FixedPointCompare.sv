//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)

//-----------------------------------------------------------------------------
`default_nettype none
module FixedPointCompare
#(  //--------------------------------------//---------------------------------
    // Parameter(s)                         // Description(s)
    //--------------------------------------//---------------------------------
    parameter string  MODEL = "Structural", // "Structural", "Behavioral", or 
    //                                      // "DataFlow" modeling.
    parameter integer N = 5                 // Width of operands in bits.
)  (//--------------------------------------//---------------------------------
    // To be compared                       // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  //
    input  wire [N-1:0] b,                  //
    //--------------------------------------//---------------------------------
    // Results of Comparson                 // Description(s)
    //--------------------------------------//---------------------------------
    output wire         lt,                 // a is less than b
    output wire         lteq,               // a is less than or equal to b
    output wire         eq,                 // a is equal to b
    output wire         gt,                 // a is greater than b
    output wire         gteq,               // a is greater than or equal to b
    output wire         neq                 // a is not equal to b
);

    LogicalLT
    #(  //----------------//---------------------------------------------------
        // Parameters     // Description(s)
        //----------------//---------------------------------------------------
        .MODEL ( MODEL ), // Modeling technique.    
        .N     ( N     )  // Width of operands in bits.
    )                     //
    u_lt                  //
    (   //----------------//---------------------------------------------------
        // Input Ports    // Description(s)
        //----------------//---------------------------------------------------
        .a     ( a     ), // [I][N] Operand A
        .b     ( b     ), // [I][N] Operand B
        //----------------//---------------------------------------------------
        // Output Ports   // Description(s)
        //----------------//---------------------------------------------------
        .c     ( lt    )  // [O][1] Result C
    );

    LogicalLTEQ
    #(  //----------------//---------------------------------------------------
        // Parameters     // Description(s)
        //----------------//---------------------------------------------------
        .MODEL ( MODEL ), // Modeling technique.
        .N     ( N     )  // Width of operands in bits.
    )                     //
    u_lteq                //
    (   //----------------//---------------------------------------------------
        // Input Ports    // Description(s)
        //----------------//---------------------------------------------------
        .a     ( a     ), // [I][N] Operand A
        .b     ( b     ), // [I][N] Operand B
        //----------------//---------------------------------------------------
        // Output Ports   // Description(s)
        //----------------//---------------------------------------------------
        .c     ( lteq  )  // [O][1] Result C
    );

    LogicalEQ
    #(  //----------------//---------------------------------------------------
        // Parameters     // Description(s)
        //----------------//---------------------------------------------------
        .MODEL ( MODEL ), // Modeling technique.
        .N     ( N     )  // Width of operands in bits.
    )                     //
    u_eq                  //
    (   //----------------//---------------------------------------------------
        // Input Ports    // Description(s)
        //----------------//---------------------------------------------------
        .a     ( a     ), // [I][N] Operand A
        .b     ( b     ), // [I][N] Operand B
        //----------------//---------------------------------------------------
        // Output Ports   // Description(s)
        //----------------//---------------------------------------------------
        .c     ( eq    )  // [O][1] Result C
    );

    LogicalGT
    #(  //----------------//---------------------------------------------------
        // Parameters     // Description(s)
        //----------------//---------------------------------------------------
        .MODEL ( MODEL ), // Modeling technique.
        .N     ( N     )  // Width of operands in bits.
    )                     //
    u_gt                  //
    (   //----------------//---------------------------------------------------
        // Input Ports    // Description(s)
        //----------------//---------------------------------------------------
        .a     ( a     ), // [I][N] Operand A
        .b     ( b     ), // [I][N] Operand B
        //----------------//---------------------------------------------------
        // Output Ports   // Description(s)
        //----------------//---------------------------------------------------
        .c     ( gt    )  // [O][1] Result C
    );

    LogicalGTEQ
    #(  //----------------//---------------------------------------------------
        // Parameters     // Description(s)
        //----------------//---------------------------------------------------
        .MODEL ( MODEL ), // "Structural", "Behavioral", or "DataFlow" modeling.     
        .N     ( N     )  // Width of operands in bits.
    )                     //
    u_gteq                //
    (   //----------------//---------------------------------------------------
        // Input Ports    // Description(s)
        //----------------//---------------------------------------------------
        .a     ( a     ), // [I][N] Operand A
        .b     ( b     ), // [I][N] Operand B
        //----------------//---------------------------------------------------
        // Output Ports   // Description(s)
        //----------------//---------------------------------------------------
        .c     ( gteq  )  // [O][1] Result C
    );

    LogicalNEQ
    #(  //----------------//---------------------------------------------------
        // Parameters     // Description(s)
        //----------------//---------------------------------------------------
        .MODEL ( MODEL ), // "Structural", "Behavioral", or "DataFlow" modeling.     
        .N     ( N     )  // Width of operands in bits.
    )                     //
    u_neq                //
    (   //----------------//---------------------------------------------------
        // Input Ports    // Description(s)
        //----------------//---------------------------------------------------
        .a     ( a     ), // [I][N] Operand A
        .b     ( b     ), // [I][N] Operand B
        //----------------//---------------------------------------------------
        // Output Ports   // Description(s)
        //----------------//---------------------------------------------------
        .c     ( neq   )  // [O][1] Result C
    );

endmodule : FixedPointCompare
`default_nettype wire
