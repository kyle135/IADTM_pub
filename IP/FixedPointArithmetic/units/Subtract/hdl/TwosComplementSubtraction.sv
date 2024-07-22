

`default_nettype none
module TwosComplementSubtraction
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
    output wire         carry_out,
    output wire         overflow
);

    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin :  TWOSCOMPLEMENTSUBTRACTION_BLOCK
        

    end : TWOSCOMPLEMENTSUBTRACTION_BLOCK
    endgenerate


endmodule : TwosComplementSubtraction
`default_nettype wire
