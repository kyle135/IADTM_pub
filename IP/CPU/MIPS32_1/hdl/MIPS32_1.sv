//---------------------------------------------------------------------------------------
// Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
//                  Creative Commons Attribution 4.0 International 
//
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     MIPS3MIPS32_12_1_hdl_pkg
// Description:     Top-Level for MIPS 32-bit CPU
// Dependencies:
// References:
// - MIPS32™ Architecture For Programmers VolumeI, Revision 0.95
// - MIPS32™ Architecture For Programmers VolumeII, Revision 0.95
//---------------------------------------------------------------------------------------
`default_nettype none 
module MIPS32_1
#(  //-------------------------------------//--------------------------------------------
    // Parameter(s)                        // Description(s)
    //-------------------------------------//--------------------------------------------
    parameter integer   N = 32,            // Bit-Width of Address/Data busses
    parameter integer   R = 32,            // General Purpose Register Count (removable param)
    parameter integer   O = $clog2(R)      //
)  (//-------------------------------------//--------------------------------------------
    // Global Signals                      // Description(s)
    //-------------------------------------//--------------------------------------------
    input  wire         clk,               // Core Clock
    input  wire         rstn,              // Asynchronous Reset, Synchronous Set (Active-Low)
    //-------------------------------------//--------------------------------------------
    //                                     // Description(s0
    //-------------------------------------//--------------------------------------------
    input  wire         Interrupt,         //
    output wire         Exception,         //
    output wire         WBen,              // Write-back Enable 
    // Cache Stuffs                        //--------------------------------------------
    input  wire         Miss,              //
    output wire         Bypass,            // Bypass External Cache 
    // Floating Point Stuffs               //--------------------------------------------
    output wire         Cop,               // Co-Processor Cycle
    output wire [  3:0] FPReg,             // Floating-Point Register pointer
    // Memory Interfacr                    //--------------------------------------------
    output wire         MemoryAccess,      // Memory Access 
    output wire         MemoryWrite,       // Memory Write
    output wire [N-1:0] MemoryWriteData,   //
    output wire         MemoryRead,        //
    input  wire [N-1:0] MemoryReadData,    //
    output wire         MemoryCacheDisable,//
    output wire [N-1:0] MemoryAddress      //
);
    import MIPS32_1_hdl_pkg::*;

    //-----------------------------------------------------------------------------------
    // Parameters
    //-----------------------------------------------------------------------------------

    
    //-----------------------------------------------------------------------------------
    // Local net declarations
    //-----------------------------------------------------------------------------------
    // Instruction Interface
    wire [N-1:0] Instruction;
    wire [N-1:0] PC;
    wire [N-1:0] nextPC;
    // Control Logic
    wire         Jump_ctrl;
    wire         Branch_ctrl;
    wire         Immediate_ctrl;
    wire         MemoryRead_ctrl;
    wire         MemoryWrite_ctrl;
    wire         MemoryToRegister_ctrl;
    wire         RegisterWrite_ctrl;
    wire         IorD_ctrl;
    wire         IRWrite_ctrl;
    wire         PCWrite_ctrl;
    wire         PCWriteCond_ctrl;
    ALUOp_t      ALUOp_ctrl;
    ALUSrcA_t    ALUSrcA_ctrl;
    ALUSrcB_t    ALUSrcB_ctrl;
    PCSource_t   PCSource_ctrl;
    wire         SignExtend_ctrl;
    wire [  3:0] LoadByte_ctrl;
    wire         Stall_ctrl;
    // Flags
    wire         Signed_ctrl;
    wire         Unsigned_ctrl;
    wire         Zero_ctrl;
    // Registers
    wire [N-1:0] GPR_a;
    wire [O-1:0] GPR_a_adr;
    wire [N-1:0] GPR_a_dat;    
    wire         GPR_a_val;    
    wire [N-1:0] GPR_b;
    wire [O-1:0] GPR_b_adr;
    wire [N-1:0] GPR_b_dat;    
    wire         GPR_b_val;    
    wire [N-1:0] GPR_c;    
    wire [O-1:0] GPR_c_adr;
    wire [N-1:0] GPR_c_dat;    
    wire         GPR_c_val;    
    wire [N-1:0] SPR_h;    
    wire [N-1:0] SPR_h_dat;    
    wire         SPR_h_val;    
    wire [N-1:0] SPR_l;    
    wire [N-1:0] SPR_l_dat;    
    wire         SPR_l_val;    
    wire         SPR_o;
    wire         SPR_o_val;    
    wire         SPR_z;
    wire         SPR_z_val;    
    
    //-----------------------------------------------------------------------------------
    // Continuous Assignments and Combintational Logic
    //-----------------------------------------------------------------------------------
    // General Purpose Register Signals
    assign GPR_a_adr          = Instruction[25:21];
    assign GPR_b_adr          = Instruction[20:16];
    assign GPR_c_adr          = Instruction[15:11];
    // External Memory Interface Signals
    assign Stall_ctrl         = 1'b0;
    assign MemoryAccess       = MemoryRead | MemoryWrite;
    assign MemoryAddress      = 32'd0;
    assign MemoryWriteData    = GPR_b;
    assign MemoryCacheDisable = 1'b0;
    assign FPReg              = 1'b0;
    assign WBen               = 1'b0;
    assign Bypass             = 1'b0;
    assign Exception          = 1'b0;
    
    //---------------------------------------------------------------------------------------------
    // Synchronous Logic
    //---------------------------------------------------------------------------------------------

    //---------------------------------------------------------------------------------------------
    // Module Instances
    //---------------------------------------------------------------------------------------------
    ALU
    #(  //----------------------------------------------//-----------------------------------------
        // Parameters                                   // Description(s)
        //------ ---------------------------------------//-----------------------------------------
        .N                    ( 32                   ), // Bit-Width of Address/Data
        .R                    ( 32                   )  // GPR Register Count
    )                                                   //
    u_ALU                                               //
    (   //----------------------------------------------//-----------------------------------------
        // Global Signals                               // Direction, Size & Description(s) 
        //----------------------------------------------//-----------------------------------------
        .clk                  ( clk                  ), // [I][1] Core Clock
        .rstn                 ( rstn                 ), // [I][1] Asynchronous Reset, Synchronous Set (Active-Low)
        //----------------------------------------------//-----------------------------------------
        // Read Interface for GPR and SPR               // Direction, Size & Description(s) 
        //----------------------------------------------//-----------------------------------------
        .Instruction          ( Instruction          ), // [I][N] Encoded ALU Operation Commands from ALU Decoder
        .ProgramCounter       ( PC                   ), // [I][N]
        .GPR_a                ( GPR_a                ), // [I][N] Source register data
        .GPR_b                ( GPR_b                ), // [I][N]  
        .GPR_c                ( GPR_c                ), // [I][N] Destination register data
        .SPR_h                ( SPR_h                ), // [I][N]
        .SPR_l                ( SPR_l                ), // [I][N]
        //----------------------------------------------//-----------------------------------------
        // Write Interface for GPR and SPR              // Direction, Size & Description(s) 
        //----------------------------------------------//-----------------------------------------
        .GPR_a_dat            ( GPR_a_dat            ), // [O][N] Register write back data for GPR a
        .GPR_a_val            ( GPR_a_val            ), // [O][1] Register write back data for GPR a is valid.
        .GPR_b_dat            ( GPR_b_dat            ), // [O][N] Register write back data for GPR b
        .GPR_b_val            ( GPR_b_val            ), // [O][1] Register write back data of GPR b is valid.
        .GPR_c_dat            ( GPR_c_dat            ), // [O][N] Register write back data for GPR c
        .GPR_c_val            ( GPR_c_val            ), // [O][1] Register write back data of GPR c is valid.
        .SPR_h_dat            ( SPR_h_dat            ), // [O][N] 
        .SPR_h_val            ( SPR_h_val            ), // [O][1] 
        .SPR_l_dat            ( SPR_l_dat            ), // [O][N] 
        .SPR_l_val            ( SPR_l_val            ), // [O][1] 
        .SPR_o_val            ( SPR_o_val            ), // [O][1] OverFlow
        .SPR_z_val            ( SPR_z_val            )  // [O][1] Zero
    );

    InstructionDecoder
    #(  //----------------------------------------------//-----------------------------------------
        // Parameters                                   // Description(s)
        //----------------------------------------------//-----------------------------------------
        .N                    ( N                    )  // Bit-Width of Address/Data busses
    )                                                   //
    u_InstructionDecoder                                //
    (   //----------------------------------------------//-----------------------------------------
        // Global Signals                               // Direction, Size & Description(s) 
        //----------------------------------------------//-----------------------------------------
        .clk                  ( clk                  ), // [I][1] Core Clock
        .rstn                 ( rstn                 ), // [I][1] Asynchronous Reset, Synchronous Set (Active-Low)
        //----------------------------------------------//-----------------------------------------
        // Internal Instruction Interface               // Direction, Size & Description(s) 
        //----------------------------------------------//-----------------------------------------
        .Instruction          ( Instruction          ), // [I][N] The current Instruction to decode.
        //----------------------------------------------//-----------------------------------------
        // Decoded Instruction Outputs                  // Direction, Size & Description(s) 
        //----------------------------------------------//-----------------------------------------
        .Jump_ctrl            ( Jump_ctrl            ), // [O][1]
        .Branch_ctrl          ( Branch_ctrl          ), // [O][1]
        .Immediate_ctrl       ( Immediate_ctrl       ), // [O][1]
        .SignExtend_ctrl      ( SignExtend_ctrl      ), // [O][1]
        .Unsigned_ctrl        ( Unsigned_ctrl        ), // [O][1]
        .RegisterWrite_ctrl   ( RegisterWrite_ctrl   ), // [O][1]
        .ALUSrcA_ctrl         ( ALUSrcA_ctrl         ), // [O][1] Control for first ALU input
        .MemoryRead_ctrl      ( MemoryRead_ctrl      ), // [O][1] Memory Read
        .MemoryWrite_ctrl     ( MemoryWrite_ctrl     ), // [O][1] Memory Write        
        .MemoryToRegister_ctrl( MemoryToRegister_ctrl), // [O][1] Memory to Register
        .IorD_ctrl            ( IorD_ctrl            ), // [O][1]
        .IRWrite_ctrl         ( IRWrite_ctrl         ), // [O][1] Write Instruction Register
        .PCWrite_ctrl         ( PCWrite_ctrl         ), // [O][1] The PC is written; the  source is controlled by PCSource.
        .PCWriteCond_ctrl     ( PCWriteCond_ctrl     ), // [O][1] The PC is written if the Zero output from the ALU is also active.
        .ALUOp_ctrl           ( ALUOp_ctrl           ), // [O][2] The operation being performed by the ALU (Unecessary)
        .ALUSrcB_ctrl         ( ALUSrcB_ctrl         ), // [O][2] Control for second ALU input
        .PCSource_ctrl        ( PCSource_ctrl        )  // [O][2] 
    );

    InstructionMemory 
    #(  //----------------------------------------------//-----------------------------------------
        // Parameters                                   // Dscription(s)
        //----------------------------------------------//-----------------------------------------
        .DC                   ( 1024                 ), // Number of elements in Memory
        .DW                   ( N                    )  // Data width in bits.
    )                                                   //
    u_InstructionMemory                                 //
    (   //----------------------------------------------//-----------------------------------------
        //                                              // Direction, Size & Description(s)
        //----------------------------------------------//-----------------------------------------
        .ReadAddress          ( nextPC               ), // [I][AW]
        .ReadData             ( Instruction          )  // [O][DW]
    );

    ProgramCounter
    #(  //----------------------------------------------//-----------------------------------------
        // Parameters                                   // Description(s)
        //----------------------------------------------//-----------------------------------------
        .N                    ( N                    )  // Bit-Width of Address/Data busses
    )                                                   //
    u_ProgramCounter                                    //
    (   //----------------------------------------------//-----------------------------------------
        // Global Signals                               // Direction, Size & Description(s)
        //----------------------------------------------//-----------------------------------------
        .clk                  ( clk                  ), // [I][1] Core Clock
        .rstn                 ( rstn                 ), // [I][1] Asynchronous Reset, Synchronous Set (Active-Low)
        //----------------------------------------------//-----------------------------------------
        // Instruction Memory Interface                 // Direction, Size & Description(s)
        //----------------------------------------------//-----------------------------------------
        .Instruction          ( Instruction          ), // [I][N] Current Instruction
        .PC                   ( PC                   ), // [I][N] Current Instruction Pointer
        .nextPC               ( nextPC               ), // [O][N] Next Instruction Pointer
        //----------------------------------------------//-----------------------------------------
        // Instruction Decoder Interface                // Direction, Size & Description(s)
        //----------------------------------------------//-----------------------------------------
        .Zero                 ( Zero_ctrl            ), // [I][1]
        .Jump                 ( Jump_ctrl            ), // [I][1]
        .Branch               ( Branch_ctrl          )  // [I][1]
    );

    GeneralPurposeRegisters
    #(  //----------------------------------------------//-----------------------------------------
        // Parameters                                   // Description(s)
        //----------------------------------------------//-----------------------------------------
        .N                    ( N                    ), // Bit-Width of Address/Data busses
        .R                    ( 32                   ), // Number of Registers
        .O                    ( $clog2(R)            )  // Address, in bits, for the regsters.
    )                                                   //
    u_GeneralPurposeRegisters                           //
    (   //----------------------------------------------//-----------------------------------------
        // Global Signals                               // Direction, Size & Description(s)
        //----------------------------------------------//-----------------------------------------
        .clk                  ( clk                  ), // [I][ 1] Core Clock
        .rstn                 ( rstn                 ), // [I][ 1] Asynchronous Reset, Synchronous Set (Active-Low)
        //----------------------------------------------//-----------------------------------------
        // Inputs                                       // Direction, Size & Description(s)
        //----------------------------------------------//-----------------------------------------
        .GPR_a_adr            ( GPR_a_adr            ), // [I][5]
        .GPR_a_dat            ( GPR_a_dat            ), // [I][N]
        .GPR_a_val            ( GPR_a_val            ), // [I][1]
        .GPR_b_adr            ( GPR_b_adr            ), // [I][5]
        .GPR_b_dat            ( GPR_b_dat            ), // [I][N]
        .GPR_b_val            ( GPR_b_val            ), // [I][1]
        .GPR_c_adr            ( GPR_c_adr            ), // [I][5]
        .GPR_c_dat            ( GPR_c_dat            ), // [I][N]
        .GPR_c_val            ( GPR_c_val            ), // [I][1]
        .LoadByte             ( LoadByte_ctrl        ), // [I][4]
        .Stall                ( Stall_ctrl           ), // [I][1]
        //----------------------------------------------//-----------------------------------------
        // Outputs                                      // Direction, Size & Description(s)
        //----------------------------------------------//-----------------------------------------
        .GPR_a                ( GPR_a                ), // [O][N]
        .GPR_b                ( GPR_b                ), // [O][N]
        .GPR_c                ( GPR_c                )  // [O][N]
    );

    SpecialPurposeRegisters
    #(  //----------------------------------------------//-----------------------------------------
        // Parameters                                   // Description(s)
        //----------------------------------------------//-----------------------------------------
        .N                    ( N                    )  // Bit-Width of Address/Data busses
    )                                                   //
    u_SpecialPurposeRegisters                           //
    (   //----------------------------------------------//---------------------------------
        // Global Signals                               // Direction, Size & Description(s)
        //----------------------------------------------//---------------------------------
        .clk                  ( clk                  ), // [I][1] Core Clock
        .rstn                 ( rstn                 ), // [I][1] Asynchronous Reset, Synchronous Set (Active-Low)
        //----------------------------------------------//---------------------------------
        // Inputs                                       // Direction, Size & Description(s)
        //----------------------------------------------//---------------------------------        
        .SPR_h_dat            ( SPR_h_dat            ), // [I][N]
        .SPR_h_val            ( SPR_h_val            ), // [I][1]
        .SPR_l_dat            ( SPR_l_dat            ), // [I][N]
        .SPR_l_val            ( SPR_l_val            ), // [I][1]
        .SPR_o_val            ( SPR_o_val            ), // [I][1] OverFlow flag from ALU
        .SPR_z_val            ( SPR_z_val            ), // [I][1] Zero flag from ALU
        .nextPC               ( nextPC               ), // [I][N]
        //----------------------------------------------//---------------------------------
        // Outputs                                      // Direction, Size & Description(s)
        //----------------------------------------------//---------------------------------
        .SPR_h                ( SPR_h                ), // [O][N]
        .SPR_l                ( SPR_l                ), // [O][N]
        .SPR_o                ( SPR_o                ), // [O][1]
        .SPR_z                ( SPR_z                ), // [O][1]
        .PC                   (                      )  // [O][N]
    );
endmodule : MIPS32_1
`default_nettype wire

