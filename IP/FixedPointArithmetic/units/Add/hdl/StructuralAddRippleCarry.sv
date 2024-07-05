
module StructuralAddRippleCarry
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Description(s)
    //--------------------------------------//---------------------------------
    parameter int    N     = 32,            //
    parameter string MODEL = "Structural"   //
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Description(s)
    //--------------------------------------//---------------------------------
    input  wire [N-1:0] a,                  //
    input  wire [N-1:0] b,                  //
    input  wire         carry_in,           //
    //--------------------------------------//---------------------------------
    // Outputs                              // Description(s)
    //--------------------------------------//---------------------------------
    output wire [N-1:0] c,                  //
    output wire         carry_out           //
);

    //-------------------------------------------------------------------------
    // Local Signals
    //-------------------------------------------------------------------------
    wire [N-1:0] a_xor_b;
    wire [N-1:0] a_or_b;
    wire [N-1:0] a_and_b;
    wire [N-1:0] a_or_b_and_carry;
    wire [N-1:0] carry;

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : SLAP_DOWN_GATES_TIME
            //-----------------------------------------------------------------
            // Sum
            //-----------------------------------------------------------------
            // c[i]    = a[i] ^ b[i] ^ c[i]
            //           ^^^^^^^^^^^
            xor u_a_xor_b (a_xor_b[i], a[i], b[i]);
            // c[i]    = a[i] ^ b[i] ^ c[i]
            //           ^^^^^^^^^^^^^^^^^^
            if (i == 0) xor u_a_xor_c(c[i], a_xor_b[i], carry_in  );
            else        xor u_a_xor_c(c[i], a_xor_b[i], carry[i-1]);
            //-----------------------------------------------------------------
            // Carry
            //-----------------------------------------------------------------
            // cout[i] = cin[i-1]·(a[i] + b[i]) + (a[i]·b[i])
            //                                    ^^^^^^^^^^^
            and u_a_and_b (a_and_b[i], a[i], b[i]);
            // cout[i] = cin[i-1]·(a[i] + b[i]) + (a[i]·b[i])
            //                    ^^^^^^^^^^^^^
            or u_a_or_b (a_or_b[i], a[i], b[i]);
            // cout[i] = cin[i-1]·(a[i] + b[i]) + (a[i]·b[i])
            //           ^^^^^^^^^^^^^^^^^^^^^^
            if (i == 0) and u_c_and_b_or_b (a_or_b_and_carry[i], a_or_b[i], carry_in);
            else        and u_c_and_b_or_b (a_or_b_and_carry[i], a_or_b[i], carry[i-1]);
            // cout[i] = cin[i-1]·(a[i] + b[i]) + (a[i]·b[i])
            //           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            if (i == N-1) or a_or_b_and_carry_or_u_a_and_b(carry_out, a_and_b[i], a_or_b_and_carry[i]);
            else          or a_or_b_and_carry_or_u_a_and_b(carry[i],  a_and_b[i], a_or_b_and_carry[i]);
        end
    endgenerate

endmodule : StructuralAddRippleCarry
