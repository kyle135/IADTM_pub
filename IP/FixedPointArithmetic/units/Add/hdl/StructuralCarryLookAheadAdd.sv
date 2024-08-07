//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:     FixedPointArithmetic
// Unit Name:   Add
// Algorithm:   CarryLookAheadAdd
// Model:       Structural
// Description: 
// make optimize_simulation_model && \
// /tools/QuestaSim2021.2_1/questasim/linux_x86_64/vsim -classdebug -work Add_work +UVM_VERBOSITY=UVM_LOW -gTOP="CarryLookAheadAdd"  -gMODEL="Structural" -gN=32  -do "quietly set StdArithNoWarnings 1; log -recursive /* -optcells; run -all;" Add_tb 
//-----------------------------------------------------------------------------
`default_nettype none
module StructuralCarryLookAheadAdd
#(  //--------------------------//---------------------------------------------
    // Parameters               // Descriptions
    //--------------------------//---------------------------------------------
    parameter integer   N = 32  // Datapath width in bits.
)  (//--------------------------//---------------------------------------------
    // Inputs                   // Descriptions
    //--------------------------//---------------------------------------------
    input  wire [N-1:0] a,      // Operand A
    input  wire [N-1:0] b,      // Operand B
    input  wire         ci,     // Carry In
    //--------------------------//---------------------------------------------
    // Outputs                  // Descriptions
    //--------------------------//---------------------------------------------
    output wire [N-1:0] c,      // Result C
    output wire         co      // Carry Out
);
    
    //-------------------------------------------------------------------------
    // Local Nets
    //-------------------------------------------------------------------------
    wire [N-1:0] cg;
    wire [N-1:0] cp;
    wire [N-1:0] ck;
    
    //-------------------------------------------------------------------------
    // Continuous Assignments and Combinational Logic
    //-------------------------------------------------------------------------
    assign co    = ck[N-1];

    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------        
    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin : STRUCTURAL_GENERATION
        // c[i] = (a[i]·b[i]) + ((a[i]^b[i])·ci[i-1])
        //      =    cg[i]    +    (cp[i]·ci[i-1])
        //
        // c[0] = cg[0] | (cp[0] & ci   )
        // c[1] = cg[1] | (cp[1] & c[0])
        // c[2] = cg[2] | (cp[2] & c[1])
        // c[3] = cg[3] | (cp[3] & c[2])
        if (i == 0) begin : FIRST_BIT_GENERATION
            StructuralReducedFullAdd u_StructuralReducedFullAdd
            (   //--------------//---------------------------------------------
                // Inputs       // Descriptions
                //--------------//---------------------------------------------
                .a  ( a[i]   ), // [I][1] Operand A
                .b  ( b[i]   ), // [I][1] Operand B
                .ci ( ci     ), // [I][1] Carry In
                //--------------//---------------------------------------------
                // Outputs      // Descriptions
                //--------------//---------------------------------------------
                .c  ( c[i]   ), // [O][1] Result C
                .cp ( cp[i]  ), // [O][1] Carry Propagate
                .cg ( cg[i]  )  // [O][1] Carry Generate
            );

            StructuralCarryLookAheadGenerator
            #(  //--------------//---------------------------------------------
                // Parameters   // Descriptions
                //--------------//---------------------------------------------
                .N  ( 1      )  // Datapath width in bits.
            )
            u_StructuralCarryLookAheadGenerator
            (   //--------------//---------------------------------------------
                // Inputs       // Descriptions
                //--------------//---------------------------------------------
                .a  ( a[i]   ), // [I][1] Operand A
                .b  ( b[i]   ), // [I][1] Operand B
                .cp ( cp[i]  ), // [I][1] Carry Propagate
                .cg ( cg[i]  ), // [I][1] Carry Generate
                .ci ( ci     ), // [I][1] Carry In
                //--------------//---------------------------------------------
                // Outputs      // Descriptions
                //--------------//---------------------------------------------
                .co ( ck[i]  )  // [O][1] Carry Out
            );
        end : FIRST_BIT_GENERATION
        else begin : REMAINING_BIT_GENERATION
            StructuralReducedFullAdd u_StructuralReducedFullAdd
            (   //--------------//---------------------------------------------
                // Inputs       // Descriptions
                //--------------//---------------------------------------------
                .a  ( a[i]   ), // [I][1] Operand A
                .b  ( b[i]   ), // [I][1] Operand B
                .ci ( ck[i-1]), // [I][1] Carry In
                //--------------//---------------------------------------------
                // Outputs      // Descriptions
                //--------------//---------------------------------------------
                .c  ( c[i]   ), // [O][1] Result C
                .cp ( cp[i]  ), // [O][1] Carry Propagate
                .cg ( cg[i]  )  // [O][1] Carry Generate
            );        

            StructuralCarryLookAheadGenerator 
            #(  //--------------//---------------------------------------------
                // Parameters   // Descriptions
                //--------------//---------------------------------------------
                .N  ( 1      )  // Datapath width in bits.
            )
            u_StructuralCarryLookAheadGenerator
            (   //--------------//---------------------------------------------
                // Inputs       // Descriptions
                //--------------//---------------------------------------------
                .a  ( a[i]   ), // [I][1] Operand A
                .b  ( b[i]   ), // [I][1] Operand B
                .cp ( cp[i]  ), // [I][1] Carry Propagate
                .cg ( cg[i]  ), // [I][1] Carry Generate
                .ci ( ck[i-1]), // [I][1] Carry In
                //--------------//-------------------------------------------------
                // Outputs    // Descriptions
                //--------------//-------------------------------------------------
                .co ( ck[i])    // Carry Out
            );
        end : REMAINING_BIT_GENERATION
    end : STRUCTURAL_GENERATION
    endgenerate

endmodule : StructuralCarryLookAheadAdd
`default_nettype wire
