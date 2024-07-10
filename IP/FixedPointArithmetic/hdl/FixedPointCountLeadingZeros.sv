//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//-----------------------------------------------------------------------------
`default_nettype none
module FixedPointCountLeadingZeros
#(  //----------------------------------//-------------------------------------
    // Parameter(s)                     // Descriptions
    //----------------------------------//-------------------------------------
    parameter integer N = 32            // Integer Width in bits.
)  (//----------------------------------//-------------------------------------
    // Inputs                           // Descriptions
    //----------------------------------//-------------------------------------
    input  wire [N-1:0] a,              //
    //----------------------------------//-------------------------------------
    // Outputs                          // Descriptions
    //----------------------------------//-------------------------------------
    output wire [$clog2(N)-1:0] c
);

    // Encode bits 2 by 2:
    // 00 => 10 : 2 leading zeros
    // 01 => 01 : 1 leading zeros
    // 10 => 00 : 0 leading zeros
    // 11 => 00 : 0 leading zeros
    reg [1:0] encoded_bit_pairs[N/2];
    wire [2:0] assembled_x3_bit_pairs[N/4];
    wire [3:0] assembled_x4_bit_pairs[N/8];
    wire [4:0] assembled_x8_bit_pairs[N/16];

    // .-------.-------.-------.-------.
    // | Case1 | Case2 | Case3 | Case4 |
    // :-------+-------+-------+-------:
    // | 00 00 | 00 01 | 00 1X | 01 XX |
    // | 10 10 | 10 01 | 10 00 | 01 XX |
    // |  100  |  011  |  010  |  001  |
    // '-------'-------'-------'-------'
    function logic [2:0] assemble_x2_pairs;
    input  [1:0] encoded_msb_value;
    input  [1:0] encoded_lsb_value;
    begin
        casez({encoded_msb_value, encoded_lsb_value})
            4'b1010: return 3'b100;
            4'b1001: return 3'b011;
            4'b1000: return 3'b010;
            4'b0100: return 3'b001;
            default: return 3'b000;
        endcase
    end
    endfunction : assemble_x2_pairs

    function logic [3:0] assemble_x3_pairs;
    input  [2:0] encoded_msb_value;
    input  [2:0] encoded_lsb_value;
    begin
        if (encoded_msb_value == 4) return encoded_msb_value + encoded_lsb_value;
        else                        return encoded_msb_value;
    end
    endfunction : assemble_x3_pairs

    function logic [4:0] assemble_x4_pairs;
    input logic [3:0] encoded_msb_value;
    input logic [3:0] encoded_lsb_value;
    begin
        if (encoded_msb_value == 8) return encoded_msb_value + encoded_lsb_value;
        else                        return encoded_msb_value;
    end
    endfunction : assemble_x4_pairs

    genvar i;
    generate
        for (i = 0; i < N; i = i + 2) begin : ENCODED_BIT_PAIRS_BLOCK
            always@* case(a[i+1:i])
                2'b00:   encoded_bit_pairs[i/2] = 2'd2;
                2'b01:   encoded_bit_pairs[i/2] = 2'd1;
                default: encoded_bit_pairs[i/2] = 2'd0;
            endcase
        end : ENCODED_BIT_PAIRS_BLOCK

        for (i = 0; i < N/2; i = i + 2) begin : ASSEMBLE_X2_BIT_PAIRS
            assign assembled_x3_bit_pairs[i/2] = assemble_x2_pairs(encoded_bit_pairs[i+1], encoded_bit_pairs[i+0]);
        end : ASSEMBLE_X2_BIT_PAIRS
        for (i = 0; i < N/4; i = i + 2) begin : ASSEMBLE_X4_BIT_PAIRS
            assign assembled_x4_bit_pairs[i/2] = assemble_x3_pairs(assembled_x3_bit_pairs[i+1], assembled_x3_bit_pairs[i+0]);
        end  : ASSEMBLE_X4_BIT_PAIRS
        for (i = 0; i < N/8; i = i + 2) begin : ASSEMBLE_X8_BIT_PAIRS
            assign assembled_x8_bit_pairs[i/2] = assemble_x4_pairs(assembled_x4_bit_pairs[i+1], assembled_x4_bit_pairs[i+0]);
        end  : ASSEMBLE_X8_BIT_PAIRS
    endgenerate

    assign c = assembled_x8_bit_pairs[1] == 16 ? assembled_x8_bit_pairs[1] + assembled_x8_bit_pairs[0] : assembled_x8_bit_pairs[1];


endmodule : FixedPointCountLeadingZeros
`default_nettype wire
