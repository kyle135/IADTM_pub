//---------------------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  MIPS I 32-bit ALU
// Module Name:  ALU
// Description:  Top-Level ALU for MIPS 32-bit CPU (v1)
// The ALU computes the arithmetic and logic operations and performs rotation
// and shift operations. Moreover, it computes addresses for memory accesses of
// the memory access unit following next in the pipeline.
// Dependencies: 
// · ALUAddSubtract.sv
// · ALUAddLogical.sv
// · ALUMultiplyDivide.sv
// · ALUShift.sv
//---------------------------------------------------------------------------------------
`default_nettype none
module ALU
#(  //----------------------------------//-----------------------------------------------
    // Parameters                       // Description(s)
    //----------------------------------//-----------------------------------------------
    parameter integer N = 32,           // Data path bit-width
    parameter integer R = 32,           // Register Count
    parameter integer O = $clog2(R)     // Address width for GPR registers.
)  (//----------------------------------//-----------------------------------------------
    // Global Signals                   // Description(s)
    //----------------------------------//-----------------------------------------------
    input  wire        clk,             // Core Clock
    input  wire        rstn,            // Asynchronous Reset, Synchronous Set (Active-Low)
    //----------------------------------//-----------------------------------------------
    //                                  // Description(s)
    //----------------------------------//-----------------------------------------------
    input  wire [N-1:0] Instruction,    // 
    input  wire [N-1:0] ProgramCounter, //
    input  wire [N-1:0] GPR_a,          // GPR a register read data.
    input  wire [N-1:0] GPR_b,          // GPR b register read data.
    input  wire [N-1:0] GPR_c,          // GPR c register read data.
    input  wire [N-1:0] SPR_h,          // SPR h register read data.
    input  wire [N-1:0] SPR_l,          // SPR l register read data.
    //----------------------------------//-----------------------------------------------
    //                                  // Description(s)
    //----------------------------------//-----------------------------------------------
    output  reg [N-1:0] GPR_a_dat,      // GPR a register write back data.
    output  reg         GPR_a_val,      // GPR a register write back enable.
    output  reg [N-1:0] GPR_b_dat,      // GPR b register write back data.
    output  reg         GPR_b_val,      // GPR b register write back enable.
    output  reg [N-1:0] GPR_c_dat,      // GPR c register write back data.
    output  reg         GPR_c_val,      // GPR c register write back enable.
    output  reg [N-1:0] SPR_h_dat,      // SPR h register write back data.
    output  reg         SPR_h_val,      // SPR h register write back enable.
    output  reg [N-1:0] SPR_l_dat,      // SPR l register write back data
    output  reg         SPR_l_val,      // SPR l register write back enable
    output  reg         SPR_o_val,      // SPR OverFlow flag 
    output  reg         SPR_z_val       // SPR Zero flag
);

    //-----------------------------------------------------------------------------------
    // Wire and register declarations
    //-----------------------------------------------------------------------------------
    wire [N-1:0] MulDiv_GPR_a_dat, AddSub_GPR_a_dat, Logical_GPR_a_dat, Shift_GPR_a_dat;
    wire         MulDiv_GPR_a_val, AddSub_GPR_a_val, Logical_GPR_a_val, Shift_GPR_a_val;
    wire [N-1:0] MulDiv_GPR_b_dat, AddSub_GPR_b_dat, Logical_GPR_b_dat, Shift_GPR_b_dat;
    wire         MulDiv_GPR_b_val, AddSub_GPR_b_val, Logical_GPR_b_val, Shift_GPR_b_val;
    wire [N-1:0] MulDiv_GPR_c_dat, AddSub_GPR_c_dat, Logical_GPR_c_dat, Shift_GPR_c_dat;
    wire         MulDiv_GPR_c_val, AddSub_GPR_c_val, Logical_GPR_c_val, Shift_GPR_c_val;
    wire [N-1:0] MulDiv_SPR_h_dat, AddSub_SPR_h_dat, Logical_SPR_h_dat, Shift_SPR_h_dat;
    wire         MulDiv_SPR_h_val, AddSub_SPR_h_val, Logical_SPR_h_val, Shift_SPR_h_val;
    wire [N-1:0] MulDiv_SPR_l_dat, AddSub_SPR_l_dat, Logical_SPR_l_dat, Shift_SPR_l_dat;
    wire         MulDiv_SPR_l_val, AddSub_SPR_l_val, Logical_SPR_l_val, Shift_SPR_l_val;
    wire         MulDiv_SPR_o_val, AddSub_SPR_o_val, Logical_SPR_o_val, Shift_SPR_o_val;
    wire         MulDiv_SPR_z_val, AddSub_SPR_z_val, Logical_SPR_z_val, Shift_SPR_z_val;

    //-----------------------------------------------------------------------------------
    // Combinational Logic
    //-----------------------------------------------------------------------------------


    //-----------------------------------------------------------------------------------
    // Synchronous Logic
    //-----------------------------------------------------------------------------------
    always_ff @(posedge clk, negedge rstn) begin : GPR_A_BLOCK
        if (~rstn) begin
            {GPR_a_val, GPR_a_dat} <= {1'b0, {N{1'b0}}};
        end
        else if (Instruction != 0) begin
            case({MulDiv_GPR_a_val, AddSub_GPR_a_val, Logical_GPR_a_val, Shift_GPR_a_val})
                4'b1000: {GPR_a_val, GPR_a_dat} <= {1'b1, MulDiv_GPR_a_dat};
                4'b0100: {GPR_a_val, GPR_a_dat} <= {1'b1, AddSub_GPR_a_dat};
                4'b0010: {GPR_a_val, GPR_a_dat} <= {1'b1, Logical_GPR_a_dat};
                4'b0001: {GPR_a_val, GPR_a_dat} <= {1'b1, Shift_GPR_a_dat};
                4'b0000: {GPR_a_val, GPR_a_dat} <= {1'b0, GPR_a};
                default: {GPR_a_val, GPR_a_dat} <= {1'b0, {N{1'bx}}};
            endcase
        end
    end : GPR_A_BLOCK

    always_ff @(posedge clk, negedge rstn) begin : GPR_B_BLOCK
        if (~rstn) begin
            {GPR_b_val, GPR_b_dat} <= {1'b0, {N{1'b0}}};
        end
        else if (Instruction != 0) begin
            case({MulDiv_GPR_b_val, AddSub_GPR_b_val, Logical_GPR_b_val, Shift_GPR_b_val})
                4'b1000: {GPR_b_val, GPR_b_dat} <= {1'b1, MulDiv_GPR_b_dat};
                4'b0100: {GPR_b_val, GPR_b_dat} <= {1'b1, AddSub_GPR_b_dat};
                4'b0010: {GPR_b_val, GPR_b_dat} <= {1'b1, Logical_GPR_b_dat};
                4'b0001: {GPR_b_val, GPR_b_dat} <= {1'b1, Shift_GPR_b_dat};
                4'b0000: {GPR_b_val, GPR_b_dat} <= {1'b0, GPR_b};
                default: {GPR_b_val, GPR_b_dat} <= {1'b0, {N{1'bx}}};
            endcase
        end
    end : GPR_B_BLOCK

    always_ff @(posedge clk, negedge rstn) begin : GPR_C_BLOCK
        if (~rstn) begin
            {GPR_c_val, GPR_c_dat} <= {1'b0, {N{1'b0}}};
        end
        else if (Instruction != 0) begin
            case({MulDiv_GPR_c_val, AddSub_GPR_c_val, Logical_GPR_c_val, Shift_GPR_c_val})
                4'b1000: {GPR_c_val, GPR_c_dat} <= {1'b1, MulDiv_GPR_c_dat};
                4'b0100: {GPR_c_val, GPR_c_dat} <= {1'b1, AddSub_GPR_c_dat};
                4'b0010: {GPR_c_val, GPR_c_dat} <= {1'b1, Logical_GPR_c_dat};
                4'b0001: {GPR_c_val, GPR_c_dat} <= {1'b1, Shift_GPR_c_dat};
                4'b0000: {GPR_c_val, GPR_c_dat} <= {1'b0, GPR_c};
                default: {GPR_c_val, GPR_c_dat} <= {1'b0, {N{1'bx}}};
            endcase
        end
    end : GPR_C_BLOCK

    always_ff @(posedge clk, negedge rstn) begin : SPR_H_BLOCK
        if (~rstn) begin
            {SPR_h_val, SPR_h_dat} <= {1'b0, {N{1'b0}}};
        end
        else if (Instruction != 0) begin
            case({MulDiv_SPR_h_val, AddSub_SPR_h_val, Logical_SPR_h_val, Shift_SPR_h_val})
                4'b1000: {SPR_h_val, SPR_h_dat} <= {1'b1, MulDiv_SPR_h_dat};
                4'b0100: {SPR_h_val, SPR_h_dat} <= {1'b1, AddSub_SPR_h_dat};
                4'b0010: {SPR_h_val, SPR_h_dat} <= {1'b1, Logical_SPR_h_dat};
                4'b0001: {SPR_h_val, SPR_h_dat} <= {1'b1, Shift_SPR_h_dat};
                4'b0000: {SPR_h_val, SPR_h_dat} <= {1'b0, SPR_h};
                default: {SPR_h_val, SPR_h_dat} <= {1'b0, {N{1'bx}}};
            endcase
        end
    end : SPR_H_BLOCK

    always_ff @(posedge clk, negedge rstn) begin : SPR_L_BLOCK
        if (~rstn) begin
            {SPR_l_val, SPR_l_dat} <= {1'b0, {N{1'b0}}};
        end
        else if (Instruction != 0) begin
            case({MulDiv_SPR_l_val, AddSub_SPR_l_val, Logical_SPR_l_val, Shift_SPR_l_val})
                4'b1000: {SPR_l_val, SPR_l_dat} <= {1'b1, MulDiv_SPR_l_dat};
                4'b0100: {SPR_l_val, SPR_l_dat} <= {1'b1, AddSub_SPR_l_dat};
                4'b0010: {SPR_l_val, SPR_l_dat} <= {1'b1, Logical_SPR_l_dat};
                4'b0001: {SPR_l_val, SPR_l_dat} <= {1'b1, Shift_SPR_l_dat};
                4'b0000: {SPR_l_val, SPR_l_dat} <= {1'b0, SPR_l};
                default: {SPR_l_val, SPR_l_dat} <= {1'b0, {N{1'bx}}};
            endcase
        end
    end : SPR_L_BLOCK

    always_ff @(posedge clk, negedge rstn) begin : SPR_OFZ_BLOCK
        if (~rstn) begin
            SPR_o_val <= 1'b0;
            SPR_z_val <= 1'b0;
        end
        else if (Instruction != 0) begin
            SPR_o_val <= AddSub_SPR_o_val | MulDiv_SPR_o_val | Logical_SPR_o_val | Shift_SPR_o_val;
            SPR_z_val <= AddSub_SPR_z_val | MulDiv_SPR_z_val | Logical_SPR_z_val | Shift_SPR_z_val;
        end
    end : SPR_OFZ_BLOCK

    //-----------------------------------------------------------------------------------
    // Module Instances
    //-----------------------------------------------------------------------------------
    ALUAddSubtract
    #(  //------------------------------------//-----------------------------------------
        // Parameters                         // Description(s)
        //------------------------------------//-----------------------------------------
        .N              (  N              )   // Data Path width in bits.
    )                                         //
    u_ALUAddSubtract                          //
    (   //------------------------------------//-----------------------------------------
        // Inputs                             // Description(s)
        //------------------------------------//-----------------------------------------
        .Instruction    ( Instruction      ), // [I][N] Encoded ALU Operation Commands from ALU Decoder
        .ProgramCounter ( ProgramCounter   ), // [I][N] Current Program Counter
        .GPR_a          ( GPR_a            ), // [I][N] General Purpose Register index A's data.
        .GPR_b          ( GPR_b            ), // [I][N] General Purpose Register index B's data.
        .GPR_c          ( GPR_c            ), // [I][N] General Purpose Register index C's data.
        .SPR_h          ( SPR_h            ), // [I][N] Special Purpose Register Hi data.
        .SPR_l          ( SPR_l            ), // [I][N] Special Purpose Register Lo data.
        //------------------------------------//-----------------------------------------
        // Outputs                            // Description(s)
        //------------------------------------//-----------------------------------------
        .GPR_a_dat      ( AddSub_GPR_a_dat ), // [O][N] GPR a register write back data.
        .GPR_a_val      ( AddSub_GPR_a_val ), // [O][1] GPR a register write back enable.
        .GPR_b_dat      ( AddSub_GPR_b_dat ), // [O][N] GPR b register write back data.
        .GPR_b_val      ( AddSub_GPR_b_val ), // [O][1] GPR b register write back enable.
        .GPR_c_dat      ( AddSub_GPR_c_dat ), // [O][N] GPR c register write back data.
        .GPR_c_val      ( AddSub_GPR_c_val ), // [O][1] GPR c register write back enable.
        .SPR_h_dat      ( AddSub_SPR_h_dat ), // [O][N] SPR h register write back data.
        .SPR_h_val      ( AddSub_SPR_h_val ), // [O][1] SPR h register write back enable.
        .SPR_l_dat      ( AddSub_SPR_l_dat ), // [O][N] SPR l register write back data
        .SPR_l_val      ( AddSub_SPR_l_val ), // [O][1] SPR l register write back enable.
        .SPR_o_val      ( AddSub_SPR_o_val ), // [O][1] SPR OverFlow flag.
        .SPR_z_val      ( AddSub_SPR_z_val )  // [O][1] SPR Zero flag.
    );

    ALUMultiplyDivide
    #(  //------------------------------------//-----------------------------------------
        // Parameters                         // Description(s)
        //------------------------------------//-----------------------------------------
        .N              (  N              )   // Data Path width in bits.
    )                                         //
    u_ALUMultiplyDivide                       //
    (   //------------------------------------//-----------------------------------------
        // Inputs                             // Description(s)
        //------------------------------------//-----------------------------------------
        .Instruction    ( Instruction      ), // [I][N] Encoded ALU Operation Commands from ALU Decoder
        .ProgramCounter ( ProgramCounter   ), // [I][N] Current Program Counter
        .GPR_a          ( GPR_a            ), // [I][N] General Purpose Register index A's data.
        .GPR_b          ( GPR_b            ), // [I][N] General Purpose Register index B's data.
        .GPR_c          ( GPR_c            ), // [I][N] General Purpose Register index C's data.
        .SPR_h          ( SPR_h            ), // [I][N] Special Purpose Register Hi data.
        .SPR_l          ( SPR_l            ), // [I][N] Special Purpose Register Lo data.
        //------------------------------------//-----------------------------------------
        // Outputs                            // Description(s)
        //------------------------------------//-----------------------------------------
        .GPR_a_dat      ( MulDiv_GPR_a_dat ), // [O][N] GPR a register write back data.
        .GPR_a_val      ( MulDiv_GPR_a_val ), // [O][1] GPR a register write back enable.
        .GPR_b_dat      ( MulDiv_GPR_b_dat ), // [O][N] GPR b register write back data.
        .GPR_b_val      ( MulDiv_GPR_b_val ), // [O][1] GPR b register write back enable.
        .GPR_c_dat      ( MulDiv_GPR_c_dat ), // [O][N] GPR c register write back data.
        .GPR_c_val      ( MulDiv_GPR_c_val ), // [O][1] GPR c register write back enable.
        .SPR_h_dat      ( MulDiv_SPR_h_dat ), // [O][N] SPR h register write back data.
        .SPR_h_val      ( MulDiv_SPR_h_val ), // [O][1] SPR h register write back enable.
        .SPR_l_dat      ( MulDiv_SPR_l_dat ), // [O][N] SPR l register write back data
        .SPR_l_val      ( MulDiv_SPR_l_val ), // [O][1] SPR l register write back enable
        .SPR_o_val      ( MulDiv_SPR_o_val ), // [O][1] SPR OverFlow flag
        .SPR_z_val      ( MulDiv_SPR_z_val )  // [O][1] SPR Zero flag
    );

    ALUShift
    #(  //------------------------------------//-----------------------------------------
        // Parameters                         // Description(s)
        //------------------------------------//-----------------------------------------
        .N              (  N              )   // Data Path width in bits.
    )                                         //
    u_ALUShift                                //
    (   //------------------------------------//-----------------------------------------
        // Inputs                             // Description(s)
        //------------------------------------//-----------------------------------------
        .Instruction    ( Instruction      ), // [I][N] Encoded ALU Operation Commands from ALU Decoder
        .ProgramCounter ( ProgramCounter   ), // [I][N] Current Program Counter
        .GPR_a          ( GPR_a            ), // [I][N] General Purpose Register index A's data.
        .GPR_b          ( GPR_b            ), // [I][N] General Purpose Register index B's data.
        .GPR_c          ( GPR_c            ), // [I][N] General Purpose Register index C's data.
        .SPR_h          ( SPR_h            ), // [I][N] Special Purpose Register Hi data.
        .SPR_l          ( SPR_l            ), // [I][N] Special Purpose Register Lo data.
        //------------------------------------//-----------------------------------------
        // Outputs                            // Description(s)
        //------------------------------------//-----------------------------------------
        .GPR_a_dat      ( Shift_GPR_a_dat  ), // [O][N] GPR a register write back data.
        .GPR_a_val      ( Shift_GPR_a_val  ), // [O][1] GPR a register write back enable.
        .GPR_b_dat      ( Shift_GPR_b_dat  ), // [O][N] GPR b register write back data.
        .GPR_b_val      ( Shift_GPR_b_val  ), // [O][1] GPR b register write back enable.
        .GPR_c_dat      ( Shift_GPR_c_dat  ), // [O][N] GPR c register write back data.
        .GPR_c_val      ( Shift_GPR_c_val  ), // [O][1] GPR c register write back enable.
        .SPR_h_dat      ( Shift_SPR_h_dat  ), // [O][N] SPR h register write back data.
        .SPR_h_val      ( Shift_SPR_h_val  ), // [O][1] SPR h register write back enable.
        .SPR_l_dat      ( Shift_SPR_l_dat  ), // [O][N] SPR l register write back data
        .SPR_l_val      ( Shift_SPR_l_val  ), // [O][1] SPR l register write back enable
        .SPR_o_val      ( Shift_SPR_o_val  ), // [O][1] SPR OverFlow flag 
        .SPR_z_val      ( Shift_SPR_z_val  )  // [O][1] SPR Zero flag
    );

    ALULogical
    #(  //------------------------------------//-----------------------------------------
        // Parameters                         // Description(s)
        //------------------------------------//-----------------------------------------
        .N              (  N              )   // Data Path width in bits.
    )                                         //
    u_ALULogical                              //
    (   //------------------------------------//-----------------------------------------
        // Inputs                             // Description(s)
        //------------------------------------//-----------------------------------------
        .Instruction    ( Instruction      ), // [I][N] Encoded ALU Operation Commands from ALU Decoder
        .ProgramCounter ( ProgramCounter   ), // [I][N] Current Program Counter
        .GPR_a          ( GPR_a            ), // [I][N] General Purpose Register index A's data.
        .GPR_b          ( GPR_b            ), // [I][N] General Purpose Register index B's data.
        .GPR_c          ( GPR_c            ), // [I][N] General Purpose Register index C's data.
        .SPR_h          ( SPR_h            ), // [I][N] Special Purpose Register Hi data.
        .SPR_l          ( SPR_l            ), // [I][N] Special Purpose Register Lo data.
        //------------------------------------//-----------------------------------------
        // Outputs                            // Description(s)
        //------------------------------------//-----------------------------------------
        .GPR_a_dat      ( Logical_GPR_a_dat), // [O][N] GPR a register write back data.
        .GPR_a_val      ( Logical_GPR_a_val), // [O][1] GPR a register write back enable.
        .GPR_b_dat      ( Logical_GPR_b_dat), // [O][N] GPR b register write back data.
        .GPR_b_val      ( Logical_GPR_b_val), // [O][1] GPR b register write back enable.
        .GPR_c_dat      ( Logical_GPR_c_dat), // [O][N] GPR c register write back data.
        .GPR_c_val      ( Logical_GPR_c_val), // [O][1] GPR c register write back enable.
        .SPR_h_dat      ( Logical_SPR_h_dat), // [O][N] SPR h register write back data.
        .SPR_h_val      ( Logical_SPR_h_val), // [O][1] SPR h register write back enable.
        .SPR_l_dat      ( Logical_SPR_l_dat), // [O][N] SPR l register write back data.
        .SPR_l_val      ( Logical_SPR_l_val), // [O][1] SPR l register write back enable.
        .SPR_o_val      ( Logical_SPR_o_val), // [O][1] SPR OverFlow flag.
        .SPR_z_val      ( Logical_SPR_z_val)  // [O][1] SPR Zero flag.
    );

endmodule : ALU
`default_nettype wire
