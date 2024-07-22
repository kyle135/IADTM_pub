

`default_nettype none
module RippleCarrySubtraction
#(  //-----------------------------
    // Parameters
    //---------------------------------
    parameter integer N = 32
)  (//-------------------------------------
    // Inputs
    //-------------------------------
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    input  wire         carry_in,
    //------------------------
    // Outputs
    //--------------------------------
    output wire [N-1:0] c,
    output wire         carry_out
);

    
    wire [N-1:0] carry;

    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : RIPPLECARRYSUBTRACTION_BLOCK
        // .-------.---.---.-----.---.------.
        // | a - b | a | b | cin | c | cout |
        // '-------:---+---+-----+---+------:
        //         | 0 | 0 |  0  | 0 |  0   |
        //         | 0 | 0 |  1  | 0 |  1   |
        //         | 0 | 1 |  1  | 1 |  1   |
        //         | 0 | 1 |  0  | 0 |  1   |
        //         | 1 | 0 |  0  | 1 |  0   |
        //         | 1 | 0 |  1  | 0 |  0   |
        //         | 1 | 1 |  1  | 0 |  1   |
        //         | 1 | 1 |  0  | 0 |  0   |
        //         '---'---'-----'---'------'
        // .--------------.----------.---------. .--------------.----------.---------.
        // |      c       | (0) ~cin | (1) cin | |    cout      | (0) cin' | (1) cin |
        // :--------------+----------+---------: :--------------+----------+---------+
        // | (00) ~a & ~b | (000) 0  | (001) 0 | | (00) ~a & ~b | (000) 0  | (001) 1 |
        // | (01) ~a &  b | (010) 0  | (011) 1 | | (01) ~a &  b | (010) 1  | (011) 1 |
        // | (11)  a &  b | (110) 0  | (101) 0 | | (11)  a &  b | (110) 0  | (101) 0 |
        // | (10)  a   ~b | (100) 1  | (111) 0 | | (10)  a & ~b | (100) 0  | (111) 1 |
        // '--------------'----------'---------' '--------------'----------'---------'
        if (i == 0) begin
            assign c[0]    =( a[0] & ~b[0] & ~carry_in) | // (100)
                            (~a[0] &  b[0] &  carry_in);  // (011)
            assign carry[0]=(~a[0] &  b[0]            ) | // (01X)
                            ( a[0] &  b[0] &  carry_in) | // (111)
                            (~a[0] & ~b[0] &  carry_in);  // (001)
        end else begin
            assign c[i]    =( a[i] & ~b[i] & ~carry[i-1]) | // (100)
                            (~a[i] &  b[i] &  carry[i-1]);  // (011)
            assign carry[i]=(~a[i] &  b[i]              ) | // (01X)
                            ( a[i] &  b[i] &  carry[i-1]) | // (111)
                            (~a[i] & ~b[i] &  carry[i-1]);  // (001)        
        end
    end : RIPPLECARRYSUBTRACTION_BLOCK
    endgenerate

    assign carry_out = carry[N-1];
    
endmodule : RippleCarrySubtraction
`default_nettype wire
