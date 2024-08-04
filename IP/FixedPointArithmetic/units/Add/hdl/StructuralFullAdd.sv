//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   FullAdd
// Model:       Structural
// Description:
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralFullAdd
(   //--------------//---------------------------------------------------------
    // Inputs       // Descriptions
    //--------------//---------------------------------------------------------
    input  wire a,  // Operand A
    input  wire b,  // Operand B
    input  wire ci, // Carry In 
    //--------------//---------------------------------------------------------
    // Outputs      // Descriptions
    //--------------//---------------------------------------------------------
    output wire c,  // Result C
    output wire co  // Carry Out
);

    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire a_xor_b;
    wire a_or_b;
    wire a_and_b;
    wire a_or_b_and_ci;

    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    
    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    // SUM:
    //     Truth Table                      K-Map
    // .---.---.-----.---.  .------------.----------.---------.
    // | a | b | ci | c |  |          c | ci' (0) | ci (1) |
    // :---+---+-----+---:  :------------+----------+---------:
    // | 0 | 0 |  0  | 0 |  | a' b' (00) |     0    |    1    | 
    // | 0 | 0 |  1  | 1 |  :------------+----------+---------:   
    // | 0 | 1 |  0  | 1 |  | a' b  (01) |     1    |    0    |  
    // | 0 | 1 |  1  | 0 |  :------------+----------+---------:
    // | 1 | 0 |  0  | 1 |  | a  b  (11) |     0    |    1    | 
    // | 1 | 0 |  1  | 0 |  :------------+----------+---------:
    // | 1 | 1 |  0  | 0 |  | a  b' (10) |     1    |    0    |
    // | 1 | 1 |  1  | 1 |  '------------'----------'---------'
    // '---'---'-----'---'
    // SOP: c = (a'·b'·ci) + (a'·b·ci') + (a·b·ci) + (a·b'·ci') From the K-Map
    //        = a·(b·ci + b'·ci') + a'·(b·ci' + b'·ci)
    //        = a·~(b^c) + a'·(b^c)
    //        = a ^ (b ^ c)
    //        = a ^ b ^ c
    //-------------------------------------------------------------------------
    xor u_a_xor_b                 (a_xor_b,       a,             b );
    xor u_a_xor_b_xor_ci          (c,             a_xor_b,       ci); 
    //-------------------------------------------------------------------------
    // CARRY:
    //     Truth Table                      K-Map
    // .---.---.----.----.  .------------.---------.--------.
    // | a | b | ci | co |  |         co | ci' (0) | ci (1) |
    // :---+---+----+----:  :------------+---------+--------:
    // | 0 | 0 | 0  | 0  |  | a' b' (00) |    0    |   0    | 
    // | 0 | 0 | 1  | 0  |  :------------+---------+--------:   
    // | 0 | 1 | 0  | 0  |  | a' b  (01) |    0    |   1    |  
    // | 0 | 1 | 1  | 1  |  :------------+---------+--------:
    // | 1 | 0 | 0  | 0  |  | a  b  (11) |    1    |   1    | 
    // | 1 | 0 | 1  | 1  |  :------------+---------+--------:
    // | 1 | 1 | 0  | 1  |  | a  b' (10) |    0    |   1    |
    // | 1 | 1 | 1  | 1  |  '------------'---------'--------'
    // '---'---'----'----'
    // SOP: co = (b·ci) + (a·ci) + (a·b)
    //           = ci·(a + b) + (a·b)

    and u_a_and_b                 (a_and_b,       a,             b );
    or  u_a_or_b                  (a_or_b,        a,             b );
    and u_a_or_b_and_ci           (a_or_b_and_ci, a_or_b,        ci);
    or  u_a_or_b_and_ci_or_a_and_b(co,            a_or_b_and_ci, a_and_b);


endmodule : StructuralFullAdd
`default_nettype wire
