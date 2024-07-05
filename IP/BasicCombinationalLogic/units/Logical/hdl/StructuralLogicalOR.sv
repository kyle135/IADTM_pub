`default_nettype none
module StructuralLogicalOR
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-------------------------------------
    parameter integer N = 8         // The maximum number of bits
)  (//----------------------------------//-------------------------------------
    // Input(s)                         // Description(s)
    //----------------------------------//-------------------------------------
    input  wire  [N-1:0] a,         // Input A
    input  wire  [N-1:0] b,         // Input B
    //----------------------------------//-------------------------------------
    // Output(s)                        // Description(s)
    //----------------------------------//-------------------------------------
    output wire              c          // Result
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] A;
    wire [N-1:0] B;
    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module instance(s)
    //-------------------------------------------------------------------------
    genvar i;
    generate
        for ( i = 1; i < N; i = i + 1 ) begin : GENERATE_LOOP
            or u_A ( A[i], a[i], A[i-1] );      // A = |a
            or u_B ( B[i], b[i], B[i-1] );      // B = |b
        end : GENERATE_LOOP
        or a_or_b(c, A[N-1], B[N-1]);           // c = A | B
    endgenerate

endmodule : StructuralLogicalOR
`default_nettype wire
