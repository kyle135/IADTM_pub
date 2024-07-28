//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralCarryLookAheadAdder
#(  //--------------------------//---------------------------------------------
    // Parameter(s)             // Description(s)
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  //
)  (//--------------------------//---------------------------------------------
    // Input(s)                 // Description(s)
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      //
    input  wire [N-1:0] b,      //
    input  wire         ci,     //
    //--------------------------//---------------------------------------------
    // Output(s)                // Description(s)
    //--------------------------//---------------------------------------------
    output wire [N-1:0] c,      //
    output wire         co      //
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N:0] cx;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combination Logic
    //-------------------------------------------------------------------------
    assign cx[0] = ci;
    assign co    = cx[N];

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------            
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION
        StructuralFullAdder
        (   //---------------//------------------------------------------------
            // Input(s)      // Direction, Size & Description(s)
            //---------------//------------------------------------------------
            .a  ( a[i]    ), // [I][1]
            .b  ( b[i]    ), // [I][1]
            .ci ( cx[i]   ), // [I][1]
            //---------------//------------------------------------------------
            // Outputs       // Direction, Size & Description(s)
            //---------------//------------------------------------------------
            .c  ( c[i]    ), //
            .co ( cx[i+1] )  //
        );
    end : STRUCTURAL_GENERATION
    endgenerate

endmodule : StructuralCarryLookAheadAdder
`default_nettype wire
