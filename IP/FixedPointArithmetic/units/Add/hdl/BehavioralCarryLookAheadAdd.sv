//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   CarryLookAheadAdd
// Model:       Behavioral
// Description:
//-----------------------------------------------------------------------------
`default_nettype none
module BehavioralCarryLookAheadAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry in
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output logic [N-1:0] c,     // Result C
    output logic         co     // Carry out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    logic [N-1:0] g;    
    logic [N-1:0] p;
    logic [N-1:0] gn;
    logic [N-1:0] gn_and_p;
    logic [N-1:0] cx;
    logic [N-1:0] cx_and_gn_and_p;
    logic [N-1:0] cx_xor_gn_and_p;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    genvar i;
    generate for(i = 0; i < N; i = i + 1) begin : BEHAVIORAL_GENERATION
        //                       g[i]
        //               .-----.  |  .---.
        // a[i] --.------:  &  :--'--| ! |--.   .-----.
        // b[i] --|--.---:     |     '---'  `---:  &  :---- gn_and_g[i]
        //        |  |   '-----'            .---:     |
        //        |  |   .-----.            |   '-----'
        //        |  `---:  |  :--.---------'
        //        `------:     |  |
        //               '-----'  |
        //                       p[i]
        always @* g[i]        = a[i] & b[i];
        always @* p[i]        = a[i] | b[i];
        always @* gn[i]       = ~g[i];
        always @* gn_and_p[i] = gn[i] & p[i];

        //---------------------------------------------------------------------
        // Carry Chain
        // c[i] = g[i-1] | (cx[i-1] · p[i-1])
        //               .-----.
        // cx[i-1] ------:  &  :-----.
        // p[i-1]  ------:     |     |    .-----.
        //               '-----'     `----:  |  :------ x[i]
        // g[i-1]  -----------------------:     |
        //                                '-----'
        if (i == 0) begin
            always @* cx[i] = ci;
        end
        else begin
            always @* cx[i] = (p[i-1] & cx[i-1]) | g[i-1];
        end

        //---------------------------------------------------------------------
        //
        //                      .-----.  .---.
        // gn_and_gp[i] ---.---:  &  :--| ! |--.    .-----.
        // x[i] --------.--|---:     |  '---'  `----:  &  :---- c[i]
        //               |  |   '-----'         .---:     |
        //               |  |   .-----.         |   '-----'
        //               |   `--:  |  :---------'
        //                `-----:     |     
        //                      '-----'     
        //                          
        always @* cx_and_gn_and_p[i] = cx[i] & gn_and_p[i];
        always @* cx_xor_gn_and_p[i] = cx[i] | gn_and_p[i];
        always @* c[i]               = ~cx_and_gn_and_p[i] & cx_xor_gn_and_p[i];
    end : BEHAVIORAL_GENERATION
    endgenerate


    always @* co    = (p[N-1] & cx[N-1]) | g[N-1];
    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------


endmodule : BehavioralCarryLookAheadAdd
`default_nettype wire
