//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   CarryLookAheadAdd
// Model:       DataFlow
// Description: 
//
//-----------------------------------------------------------------------------
`default_nettype none
module DataFlowCarryLookAheadAdd
#(  //--------------------------------------//---------------------------------
    // Parameters                           // Descriptions
    //--------------------------------------//---------------------------------
    parameter integer N     = 32            // Datapath width in bits
)  (//--------------------------------------//---------------------------------
    // Inputs                               // Descriptions
    //--------------------------------------//---------------------------------
    input  wire  [N-1:0] a,                 // Operand A
    input  wire  [N-1:0] b,                 // Operand B
    input  wire          ci,                // Carry in
    //--------------------------------------//---------------------------------
    // Outputs                              // Descriptions
    //--------------------------------------//---------------------------------
    output logic [N-1:0] c,                 // Result C
    output logic         co                 // Carry out
);
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    logic [N-1:0] cg;    
    logic [N-1:0] cp;
    logic [N-1:0] ck;
    logic [N-1:0] cgn;
    logic [N-1:0] cgn_and_cp;
    logic [N-1:0] ck_and_cgn;
    logic [N-1:0] ck_or_cgn;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    //                          cg[i]
    //               .-----.     |   .---.
    // a[i] --.------:  &  :-----'---| ! |----.    .-----.
    // b[i] --|--.---:     |         '---'    `----:  &  :---- cgn_and_cp[i]
    //        |  |   '-----'                  .----:     |
    //        |  |   .-----.                  |    '-----'
    //        |  `---:  |  :-----.------------'
    //        `------:     |     |
    //               '-----'     |
    //                          cp[i]
    assign cp         = a | b;
    assign cg         = a & b;
    assign cgn        = ~cg;
    assign cgn_and_cp = cgn & cp;

    //               .-----.
    // ck[i-1] ------:  &  :-----.
    // cp[i-1] ------:     |     |    .-----.
    //               '-----'     `----:  |  :------ ck[i]
    // cg[i-1] -----------------------:     |
    //                                '-----'
    assign {co, ck}   = ({cp, 1'b0} & {ck, ci}) | {cg, 1'b0};
    assign ck_and_cgn = ck & cgn_and_cp;
    assign ck_or_cgn  = ck | cgn_and_cp;
    assign c          = ~ck_and_cgn & ck_or_cgn;


    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------

endmodule : DataFlowCarryLookAheadAdd
`default_nettype wire
