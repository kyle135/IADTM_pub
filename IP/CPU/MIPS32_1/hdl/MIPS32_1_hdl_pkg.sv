//---------------------------------------------------------------------------------------
// Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
//                  Creative Commons Attribution 4.0 International 
//
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     MIPS32_1_hdl_pkg
// Description:
// Dependencies:
// References:
// - MIPS32™ Architecture For Programmers VolumeI, Revision 0.95
// - MIPS32™ Architecture For Programmers VolumeII, Revision 0.95
//---------------------------------------------------------------------------------------
package MIPS32_1_hdl_pkg;
    //-----------------------------------------------------------------------------------
    // Register Addresses
    //-----------------------------------------------------------------------------------
    // o Registers $at (1), $k0 (26), and $k1 (27) are reserved for the assembler and operating system
    //   and should not be used by user programs or compilers.
    // o Registers $a0-$a3 (4-7) are used to pass the first four arguments to routines (renaming
    //   arguments are passed on the stack). Registers $v0 and $v1 (2, 3) are used to return values from
    //   functions.
    // o Registers  $t0-$t9 (8-15, 24, 25) are caller-saved registers that are used to hold temporary
    //   quantities that need not be preserved across calls.
    // o
    typedef enum bit [4:0] {
        //          // .---------------.--------.-------------------------------------------------.
        //          // | Register Name | Number |                     Usage                       |
        //          // :---------------+--------+-------------------------------------------------:
        R00 = 5'd0, // |     $zero     |    0   | constant 0                                      |
        R01 = 5'd1, // |      $at      |    1   | reserved for assembler                          |
        R02 = 5'd2, // |      $v0      |    2   | expression evaluation and results of a function |
        R03 = 5'd3, // |      $v1      |    3   | expression evaluation and results of a function |
        R04 = 5'd4, // |      $a0      |    4   | argument 1                                      |
        R05 = 5'd5, // |      $a1      |    5   | argument 2                                      |
        R06 = 5'd6, // |      $a2      |    6   | argument 3                                      |
        R07 = 5'd7, // |      $a3      |    7   | argument 4                                      |
        R08 = 5'd8, // |      $t0      |    8   | temporary (not preserved across call)           |
        R09 = 5'd9, // |      $t1      |    9   | temporary (not preserved across call)           |
        R10 = 5'd10,// |      $t2      |   10   | temporary (not preserved across call)           |
        R11 = 5'd11,// |      $t3      |   11   | temporary (not preserved across call)           |
        R12 = 5'd12,// |      $t4      |   12   | temporary (not preserved across call)           |
        R13 = 5'd13,// |      $t5      |   13   | temporary (not preserved across call)           |
        R14 = 5'd14,// |      $t6      |   14   | temporary (not preserved across call)           |
        R15 = 5'd15,// |      $t7      |   15   | temporary (not preserved across call)           |
        R16 = 5'd16,// |      $s0      |   16   | saved temporary (preserved across call)         |
        R17 = 5'd17,// |      $s1      |   17   | saved temporary (preserved across call)         |
        R18 = 5'd18,// |      $s2      |   18   | saved temporary (preserved across call)         |
        R19 = 5'd19,// |      $s3      |   19   | saved temporary (preserved across call)         |
        R20 = 5'd20,// |      $s4      |   20   | saved temporary (preserved across call)         |
        R21 = 5'd21,// |      $s5      |   21   | saved temporary (preserved across call)         |
        R22 = 5'd22,// |      $s6      |   22   | saved temporary (preserved across call)         |
        R23 = 5'd23,// |      $s7      |   23   | saved temporary (preserved across call)         |
        R24 = 5'd24,// |      $t8      |   24   | temporary (not preserved across call)           |
        R25 = 5'd25,// |      $t9      |   25   | temporary (not preserved across call)           |
        R26 = 5'd26,// |      $k0      |   26   | reserved for OS kernel                          |
        R27 = 5'd27,// |      $k1      |   27   | reserved for OS kernel                          |
        R28 = 5'd28,// |      $gp      |   28   | pointer to global area                          |
        R29 = 5'd29,// |      $sp      |   29   | stack pointer                                   |
        R30 = 5'd30,// |      $fp      |   30   | frame pointer                                   |
        R31 = 5'd31 // |      $ra      |   31   | return address (used by function call)          |
    //                 '---------------'--------'-------------------------------------------------'
    } MIPSRegisterAddress_t;

    //-------------------------------------------------------------------------
    // Instructions
    //-------------------------------------------------------------------------
    // RANDOM DATA WEIGHTS 
    `define DATA_ALL_ZERO 10
    `define DATA_SIGNED_POSITIVE 40
	`define DATA_SIGNED_NEGATIVE 40

    `define INSTR_SZ_LOC  31:00
    `define PC_SZ_LOC     31:00
    
    `define BGE_LOC       20:16
    // R-Type Instructions
    // .---------.-------.-------.-------.-------.----------.
    // |Opcode(6)|   a   |   b   |   c   | shamt | funct(6) |
    // | [31-26] |[25-21]|[20-16]|[15:11]|[10: 6]| [ 5: 0]  |
    // '---------'-------'-------'-------'-------'----------'
    `define OP_LOC        31:26
    `define A_LOC         25:21
    `define B_LOC         20:16
    `define C_LOC         15:11
    `define SHAMT_LOC     10: 6
    `define FUNC_LOC       5: 0
    // I-Type Instructions (Transfer, branch, immediate)
    // .---------.-------.-------.--------------------------.
    // |Opcode(6)| R1(5) | R2(5) |       Immediate          |
    // | [31-26] |[25-21]|[20-16]|        [15:00]           |
    // '---------'-------'-------'--------------------------'
    `define IMMEDIATE_LOC 15: 0
    // J-Type Instructions (Jump)
    // .---------.------------------------------------------.
    // |Opcode(6)|                 Target                   |
    // | [31-26] |                 [25-00]                  |
    // '---------'------------------------------------------'
    `define TARGET_LOC    25: 0

    parameter SPECIAL_OP  = 6'b000000;
    parameter SPECIAL2_OP = 6'b011100;

    //--------------------------------------------------------------------------------*/---------------------------------//-.---.-----------------------.
    // CPU Arithmetic Instructions Op Codes                                           */ Functions                       // | T |    Assembly Code      |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    parameter ADD_OP    = SPECIAL_OP; /* Add Word (overflow)                          */ parameter ADD_FUNC     = 6'h20; // | R | add   c, a, b         |
    parameter ADDI_OP   = 6'h08;      /* Add Immediate Word                           */                                 // | I | addi  c, a, immediate |
    parameter ADDIU_OP  = 6'h09;      /* Add Immediate Unsigned Word                  */                                 // | I | addiu b, a, immediate |
    parameter ADDU_OP   = SPECIAL_OP; /* Add Unsigned Word                            */ parameter ADDU_FUNC    = 6'h21; // | R | addu  c, a, b         |
    parameter CLO_OP    = SPECIAL2_OP;/* Count Leading Ones in Word                   */ parameter CLO_FUNC     = 6'h21; // | R | clo   c, a            |
    parameter CLZ_OP    = SPECIAL2_OP;/* Count Leading Zeros in Word                  */ parameter CLZ_FUNC     = 6'h20; // | R | clz   c, a            |
    parameter DIV_OP    = SPECIAL_OP; /* Divide (with overflow)                       */ parameter DIV_FUNC     = 6'h1A; // | R | div   a, b            |   
    parameter DIVU_OP   = SPECIAL_OP; /* Divide Unsigned Word                         */ parameter DIVU_FUNC    = 6'h1B; // | R | divu  a, b            |
    parameter MADD_OP   = SPECIAL2_OP;/* Multiply and Add Word to Hi, Lo              */ parameter MADD_FUNC    = 6'h00; // | R | madd  a, b            |
    parameter MADDU_OP  = SPECIAL2_OP;/* Multiply and Add Unsigned Word to Hi, Lo     */ parameter MADDU_FUNC   = 6'h01; // | R | maddu a, b            |
    parameter MSUB_OP   = SPECIAL2_OP;/* Multiply and Subtract Word to Hi, Lo         */ parameter MSUB_FUNC    = 6'h04; // | R | msub  a, b            |
    parameter MSUBU_OP  = SPECIAL2_OP;/* Multiply and Subtract Unsigned Word to Hi, Lo*/ parameter MSUBU_FUNC   = 6'h05; // | R | msubu a, b            |
    parameter MUL_OP    = SPECIAL2_OP;/* Multiply Word to GPR                         */ parameter MUL_FUNC     = 6'h02; // | R | mul   c, a, b         |
    parameter MULT_OP   = SPECIAL_OP; /* Multiply Word                                */ parameter MULT_FUNC    = 6'h18; // | R | mult  a, b            |
    parameter MULTU_OP  = SPECIAL_OP; /* Multiply Unsigned Word                       */ parameter MULTU_FUNC   = 6'h19; // | R | multu a, b            |
    // parameter SEB_OP    = ;
    // parameter SEH_OP    = ;
    parameter SLT_OP    = SPECIAL_OP; /* Set less than                                */ parameter SLT_FUNC     = 6'h2A; // | R | slt                   |
    parameter SLTI_OP   = 6'h0A;      /* Set On Less Than Immediate                   */                                 // | I | slti                  |
    parameter SLTIU_OP  = 6'h0B;      /* Set On Less Than Immediate Unsigned          */                                 // | I | sltiu                 |
    parameter SLTU_OP   = SPECIAL_OP; /* Set On Less Than Unsigned                    */ parameter SLTU_FUNC    = 6'h2B; // | R | sltu                  |
    parameter SUB_OP    = SPECIAL_OP; /* Subtract (with overflow)                     */ parameter SUB_FUNC     = 6'h22; // | R | sub                   |
    parameter SUBU_OP   = SPECIAL_OP; /* Subtract Unsigned Word                       */ parameter SUBU_FUNC    = 6'h23; // | R | subu                  |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    // CPU Branch and Jump Instruction Op Codes                                       */ Functions                       // | T |    Assembly Code      |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    parameter B_OP      = 6'h04;      /* Unconditional Branch                         */                                 // | I | b     immediate       |
    parameter BAL_OP    = 6'h01;      /* Branch and Link                              */                                 // | I | bal   a, immediate    |
    parameter BEQ_OP    = 6'h04;      /* Branch on Equal                              */                                 // | I | beq   a, b, immediate |
    parameter BGEZ_OP   = 6'h01;      /* Branch on greater than or equal to zero      */ parameter BGEZ_FUNC    = 6'h01; // | I | bgez  a, immediate    |
    parameter BGEZAL_OP = 6'h01;      /* Branch on greater than equal zero and link   */ parameter BGEZAL_FUNC  = 6'h11; // |   |                       |
    parameter BGTZ_OP   = 6'h07;      /* Branch on greater than zero                  */ parameter BGTZ_FUNC    = 6'h00; // |   |                       |
    parameter BLEZ_OP   = 6'h06;      /* Branch on less than equal zero               */ parameter BLEZ_FUNC    = 6'h00; // |   |                       |
    parameter BLTZ_OP   = 6'h01;      /*                                              */ parameter BLTZ_FUNC    = 6'h00; // |   |                       |
    parameter BLTZAL_OP = 6'h01;      /*                                              */ parameter BLTZAL_FUNC  = 6'h10; // |   |                       |
    parameter BNE_OP    = 6'h05;      /* Branch on not equal                          */                                 // | I | bne                   |
    parameter J_OP      = 6'h02;      /* Jump                                         */                                 // | J | j                     |
    parameter JAL_OP    = 6'h03;      /* Jump and Link                                */                                 // | J | jal                   |
    parameter JALR_OP   = 6'h00;      /* Jump and Link register                       */ parameter JALR_FUNC    = 6'h09; // |   |                       |
    parameter JR_OP     = 6'h00;      /* Jump Register                                */ parameter JR_FUNC      = 6'h00; // | R | jr                    |
    //---------------------------------------------------------------------------------/---------------------------------//-+---+-----------------------:
    // CPU Instruction Control Instruction Op Codes                                    / Functions                       // | T |    Assembly Code      |
    //---------------------------------------------------------------------------------/---------------------------------//-+---+-----------------------:
    parameter NOP       = 6'h??;      /* No Operation                                 */                                 // |   |                       |
    parameter SSNOP     = 6'h??;      /* Superscalar No Operation                     */                                 // |   |                       |
    //---------------------------------------------------------------------------------/---------------------------------//-+---+-----------------------:
    // CPU Load, Store, and Memory Control Instruction Op Codes                        / Functions                       // | T |    Assembly Code      |
    //---------------------------------------------------------------------------------/---------------------------------//-+---+-----------------------:
    parameter LB_OP     = 6'h20;      /* Load Byte                                    */                                 // |   |                       |
    parameter LBU_OP    = 6'h24;      /* Load unsigned byte                           */                                 // | I | lbu                   |
    parameter LH_OP     = 6'h21;      /* Load Halfword                                */                                 // |   |                       |
    parameter LHU_OP    = 6'h25;      /* Load unsigned halfword                       */                                 // | I | lhu                   |
    parameter LL_OP     = 6'h30;      /* Load Linked                                  */                                 // | I | ll                    |
    parameter LW_OP     = 6'h23;      /* Load Word                                    */                                 // | I | lw                    |
    parameter LWL_OP    = 6'h22;      /* Load word left                               */                                 // |   | lwl                   |
    parameter LWR_OP    = 6'h26;      /* Load Word Right                              */                                 // |   |                       |
    parameter SB_OP     = 6'h28;      /* Store Byte                                   */                                 // | I | sb
    parameter SC_OP     = 6'h38;      /* Store Conditional Word                       */                                 // | I | sc 
    parameter SD_OP     = 6'h00;      /* Stroe Double Word                            */                                 // |   | sd
    parameter SH_OP     = 6'h29;      /* Store Halfword                               */                                 // | I | sh
    parameter SW_OP     = 6'h2b;      /* Store Word                                   */                                 // | I | sw
    parameter SWL_OP    = 6'h2A;      /* Store Word Left                              */                                 // |   | 
    parameter SWR_OP    = 6'h2E;      /* Store Word Right                             */                                 // |   | 
    parameter SYNC      = 6'h??;      /* Synchronize Shared Memory                    */                                 // |   | 
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    // CPU Logical Instruction Op Codes                                               */ Functions                       // | T |    Assembly Code      |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    parameter AND_OP    = SPECIAL_OP; /* AND                                          */ parameter AND_FUNC     = 6'h24; // | R | and
    parameter ANDI_OP   = 6'h0C;      /* AND Immediate                                */                                 // | I | andi
    parameter LUI_OP    = 6'h0F;      /* Load Upper Immediate                         */                                 // | I | lui
    parameter NOR_OP    = 6'h00;      /* Not OR                                       */ parameter NOR_FUNC     = 6'h27; // | R | nor
    parameter OR_OP     = 6'h00;      /* OR                                           */ parameter OR_FUNC      = 6'h25; // | R | or
    parameter ORI_OP    = 6'h0D;      /* OR immediate                                 */ parameter ORI_FUNC     = 6'h00; // | I | ori
    parameter XOR_OP    = 6'h00;      /* Exclusive OR                                 */ parameter XOR_FUNC     = 6'h26; // |   |
    parameter XORI_OP   = 6'h0E;      /* Exclusive OR immediate                       */                                 // |   |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    // CPU Move Instruction Op Codes                                                  */ Functions                       // | T |    Assembly Code      |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    parameter MFHI_OP   = 6'h00;      /* Move From HI Register                        */ parameter MFHI_FUNC    = 6'h10; // |   |
    parameter MFLO_OP   = 6'h00;      /* Move From LO Register                        */ parameter MFLO_FUNC    = 6'h12; // |   |
    parameter MOVF_OP   = 6'h00;      /* Move Conditional on Floating Point False     */ parameter MOVF_FUNC    = 6'h01; // |   | movf c, a, cc         |
    parameter MOVN_OP   = 6'h00;      /* Move Conditional on Not Zero                 */ parameter MOVN_FUNC    = 6'h03; // |   | movn
    parameter MOVT_OP   = 6'h00;      /* Move Conditional on Floating Point True      */ parameter MOVT_FUNC    = 6'h01; // |   | movt c, a, cc
    parameter MOVZ_OP   = 6'h00;      /* Move Conditional on Zero                     */ parameter MOVZ_FUNC    = 6'h0A; // |   | movz c, a, b          |
    parameter MTHI_OP   = 6'h00;      /* Move To HI Register                          */ parameter MTHI_FUNC    = 6'h11; // |   |                       |
    parameter MTLO_OP   = 6'h00;      /* Move To LO Register                          */ parameter MTLO_FUNC    = 6'h13; // |   |                       |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    // CPU Shift Instruction Op Codes                                                 */ Functions                       // | T |    Assembly Code      |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    parameter SLL_OP    = 6'h00;      /* Shift Word Left Logical                      */ parameter SLL_FUNC     = 6'h00; // | R | 
    parameter SLLV_OP   = 6'h00;      /* Shift Word Left Logical Variable             */ parameter SLLV_FUNC    = 6'h04; // |   |
    parameter SRA_OP    = 6'h00;      /* Shift Word Right Arithmetic                  */ parameter SRA_FUNC     = 6'h03; // |   |
    parameter SRAV_OP   = 6'h00;      /* Shift Word Right Arithmetic Variable         */ parameter SRAV_FUNC    = 6'h07; // |   |
    parameter SRL_OP    = 6'h00;      /* Shift Word Right Logical                     */ parameter SRL_FUNC     = 6'h02; // | R | srl
    parameter SRLV_OP   = 6'h00;      /* Shift Word Right Logical Variable            */ parameter SRLV_FUNC    = 6'h06; // |   |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:
    // CPU Trap Instruction Op Codes                                                  */ Functions                       // | T |    Assembly Code      |
    //--------------------------------------------------------------------------------*/---------------------------------//-+---+-----------------------:   
    parameter BREAK_OP  = 6'h00;      /*                                              */ parameter BREAK_FUNC   = 6'h0B; // |   |
    parameter SYSCALL_OP= 6'h00;      /* System Call                                  */ parameter SYSCALL_FUNC = 6'h0C; // |   |
    parameter NOP_OP    = 6'h00;      /*                                              */ parameter NOP_FUNC     = 6'h00; // | R |

    // parameter CFC0_OP    = 6'h10; /* Move Control From Coprocessor 0            */ parameter CFC0_FUNC    = 0;
    // parameter CFC1_OP    = 6'h11; /* Move Control From Coprocessor 1            */ parameter CFC1_FUNC    = 0;
    // parameter CFC2_OP    = 6'h12; /* Move Control From Coprocessor 2            */ parameter CFC2_FUNC    = 0;
    // parameter CFC3_OP    = 6'h13; /* Move Control From Coprocessor 3            */ parameter CFC3_FUNC    = 0;
    // parameter COP0_OP    = 6'h10; /* Coprocessor 0 Operation                    */ parameter COP0_FUNC    = 0;
    // parameter COP1_OP    = 6'h11; /* Coprocessor 1 Operation                    */ parameter COP1_FUNC    = 0;
    // parameter COP2_OP    = 6'h12; /* Coprocessor 2 Operation                    */ parameter COP2_FUNC    = 0;
    // parameter COP3_OP    = 6'h13; /* Coprocessor 3 Operation                    */ parameter COP3_FUNC    = 0;
    // parameter CTC0_OP    = 6'h10; /* Move Control to Coprocessor 0              */ parameter CTC0_FUNC    = 0;
    // parameter CTC1_OP    = 6'h11; /* Move Control to Coprocessor 1              */ parameter CTC1_FUNC    = 0;
    // parameter CTC2_OP    = 6'h12; /* Move Control to Coprocessor 2              */ parameter CTC2_FUNC    = 0;
    // parameter CTC3_OP    = 6'h13; /* Move Control to Coprocessor 3              */ parameter CTC3_FUNC    = 0;
    // parameter MTC0_OP    = 6'h10; /* Move to Coprocessor 0             p. A-48  */ parameter MTC0_FUNC    = 6'h04; /* ( 4) Move To Coprocessor 0             */
    // parameter MTC1_OP    = 6'h11; /* Move to Coprocessor 1             p. A-48  */ parameter MTC1_FUNC    = 6'h04; /* ( 4) Move To Coprocessor 1             */
    // parameter MTC2_OP    = 6'h12; /* Move to Coprocessor 2             p. A-48  */ parameter MTC2_FUNC    = 6'h04; /* ( 4) Move To Coprocessor 2             */
    // parameter MTC3_OP    = 6'h13; /* Move to Coprocessor 3             p. A-48  */ parameter MTC3_FUNC    = 6'h04; /* ( 4) Move To Coprocessor 3             */
    // parameter SWC0_OP    = 6'h38; /* Store Word From Coprocessor                */                                 //
    // parameter SWC1_OP    = 6'h39; /* Store Word From Coprocessor                */                                 //
    // parameter SWC2_OP    = 6'h3A; /* Store Word From Coprocessor                */                                 //
    // parameter SWC3_OP    = 6'h3B; /* Store Word From Coprocessor                */


    typedef enum logic {
        A_REGISTER = 1'b0,
        PC_COUNTER = 1'b1
    } ALUSrcA_t;
    
    typedef enum logic [1:0] {
        B_REGISTER             = 2'b00,
        CONSTANT_4             = 2'b01,
        SIGNEXTEND_IMMED       = 2'b10,
        SIGNEXTEND_IMMED_SHIFT = 2'b11
    } ALUSrcB_t;
    
    typedef enum logic [1:0] {
        PC_PLUS_4  = 2'b00,     //Output
        ALU_OUT    = 2'b01,
        JUMP       = 2'b10,
        RESERVED   = 2'b11
    } PCSource_t;    
    
    typedef enum logic [1:0] {
        ALU_ADD_OPERATION  = 2'b00,
        ALU_SUB_OPERATION  = 2'b01,
        ALU_FUNC_OPERATION = 2'b10,
        ALU_FUNC_RESERVED  = 2'b11
    } ALUOp_t;


endpackage : MIPS32_1_hdl_pkg
