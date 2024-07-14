//---------------------------------------------------------------------------------------
// Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
//                  Creative Commons Attribution 4.0 International 
//
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     GeneralPurposeRegisters
// Description:     Generaal Purpose Registers for MIPS 32-bit CPU (HDL)
//---------------------------------------------------------------------------------------
`default_nettype none
module GeneralPurposeRegisters
#(  //---------------------------------------//------------------------------------------
    // Parameters                            // Description(s)
    //---------------------------------------//------------------------------------------
    parameter integer  N = 32,               //
    parameter integer  R = 32,               // Register Count
    parameter integer  O = $clog2(R)         //
)  (//---------------------------------------//------------------------------------------
    // Global Signals                        // Description(s) 
    //---------------------------------------//------------------------------------------
    input  wire         clk,                 // Core Clock
    input  wire         rstn,                // Asynchronous Reset, Synchronous Set (Active-Low)
    //---------------------------------------//------------------------------------------
    // Inputs                                // Description(s)
    //---------------------------------------//------------------------------------------
    input  wire [O-1:0] GPR_a_adr,           //
    input  wire [N-1:0] GPR_a_dat,           //
    input  wire         GPR_a_val,           //
    input  wire [O-1:0] GPR_b_adr,           //
    input  wire [N-1:0] GPR_b_dat,           //
    input  wire         GPR_b_val,           //
    input  wire [O-1:0] GPR_c_adr,           //
    input  wire [N-1:0] GPR_c_dat,           //
    input  wire         GPR_c_val,           //
    input  wire         RegisterWrite,       //
    input  wire [  3:0] LoadByte,            // Byte Selects for register writes.
    input  wire         Stall,               //
    //---------------------------------------//------------------------------------------
    // Outputs                               // Description(s)
    //---------------------------------------//------------------------------------------
    output wire [N-1:0] GPR_a,               // First ALU operand
    output wire [N-1:0] GPR_b,               // Second ALU Operand
    output wire [N-1:0] GPR_c                // Data to be stored
);   
   import MIPS32_1_hdl_pkg::*;
   
    //-----------------------------------------------------------------------------------
    // Local net declarations
    //-----------------------------------------------------------------------------------
    reg [N-1:0] registers [R-1:0];

    //-----------------------------------------------------------------------------------
    // Synchronous Logic
    //-----------------------------------------------------------------------------------    
    always@(posedge clk, negedge rstn) begin : GPR_READ_BLOCK
        if (~rstn) begin
            GPR_a <= {N{1'b0}};
            GPR_b <= {N{1'b0}};
            GPR_c <= {N{1'b0}};
        end
        else if (~Stall) begin
            GPR_a <= registers[GPR_a_adr];
            GPR_b <= registers[GPR_b_adr];
            GPR_c <= registers[GPR_c_adr];
        end
    end : GPR_READ_BLOCK
   
    always@(posedge clk, negedge rstn) begin : GPR_WRITE_BLOCK
        if (~rstn) begin
            for (int i = 0; i < R; i = i + 1)
                registers[i] <= {N{1'b0}};
        end
        else begin
            if (GPR_a_val & ~Stall & (GPR_a_adr != {N{1'b0}})) begin
                if (LoadByte[0]) registers[GPR_a_adr][ 7: 0] <= GPR_a_dat[ 7: 0];
                if (LoadByte[1]) registers[GPR_a_adr][15: 8] <= GPR_a_dat[15: 8];
                if (LoadByte[2]) registers[GPR_a_adr][23:16] <= GPR_a_dat[23:16];
                if (LoadByte[3]) registers[GPR_a_adr][31:24] <= GPR_a_dat[31:24];
            end
            if (GPR_b_val & ~Stall & (GPR_b_adr != {N{1'b0}})) begin
                if (LoadByte[0]) registers[GPR_b_adr][ 7: 0] <= GPR_b_dat[ 7: 0];
                if (LoadByte[1]) registers[GPR_b_adr][15: 8] <= GPR_b_dat[15: 8];
                if (LoadByte[2]) registers[GPR_b_adr][23:16] <= GPR_b_dat[23:16];
                if (LoadByte[3]) registers[GPR_b_adr][31:24] <= GPR_b_dat[31:24];
            end
            if (GPR_c_val & ~Stall & (GPR_c_adr != {N{1'b0}})) begin
                if (LoadByte[0]) registers[GPR_c_adr][ 7: 0] <= GPR_c_dat[ 7: 0];
                if (LoadByte[1]) registers[GPR_c_adr][15: 8] <= GPR_c_dat[15: 8];
                if (LoadByte[2]) registers[GPR_c_adr][23:16] <= GPR_c_dat[23:16];
                if (LoadByte[3]) registers[GPR_c_adr][31:24] <= GPR_c_dat[31:24];
            end
        end
    end : GPR_WRITE_BLOCK

endmodule : GeneralPurposeRegisters
`default_nettype wire
