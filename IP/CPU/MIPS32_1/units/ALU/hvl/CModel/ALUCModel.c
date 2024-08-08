#include "svdpi.h"
#include "stdio.h"


// Global Variables because....
int OpCode;         // OpCode
int ra;         // Register A Location
int rb;         // Register C Location
int rc;         // Register C Location
int offset;     // Offset
int immediate;  // Immediate Value
int funct;      // Function Code
int GPR_a_dat;  //
int GPR_a_val;  //
int GPR_b_dat;  //
int GPR_b_val;  //
int GPR_c_dat;  //
int GPR_c_val;  //
int SPR_h_dat;  //
int SPR_h_val;  //
int SPR_l_dat;  //
int SPR_l_val;  //
int SPR_o_val;  // SpeGPR_cal Purpose Register Overflow Flag
int SPR_z_val;  // SpeGPR_cal Purpose Register Zero Flag


//-----------------------------------------------------------------------------
// Op Codes
//-----------------------------------------------------------------------------
#define SPECIAL_OP  0x00
#define SPECIAL2_OP 0x1C
#define ADDI_OP     0x08
#define ADDIU_OP    0x09
#define SLTI_OP     0x0A
#define SLTIU_OP    0x0B
//-----------------------------------------------------------------------------
// Functions
//-----------------------------------------------------------------------------
#define ADD_FUNC    0x20
#define ADDU_FUNC   0x21
#define CLO_FUNC    0x21
#define CLZ_FUNC    0x20
#define DIV_FUNC    0x1A
#define DIVU_FUNC   0x1B
#define MADD_FUNC   0x00
#define MADDU_FUNC  0x01
#define MSUB_FUNC   0x04
#define MSUBU_FUNC  0x05
#define MUL_FUNC    0x02
#define MULT_FUNC   0x18
#define MULTU_FUNC  0x19
#define SLT_FUNC    0x2A
#define SLTU_FUNC   0x2B
#define SUB_FUNC    0x22
#define SUBU_FUNC   0x23


int ovfAdd(int * result, int x, int y) { 
    * result = x + y;
  
    if (x > 0 && y > 0 && * result < 0)
        return -1;
    if (x < 0 && y < 0 && * result > 0)
        return -1;

    return 0;
}

void instruction_partition(int instruction) {
    OpCode    = (instruction >> 26) & ((1 <<  6) - 1); /* 6 most significant GPR_bts  */
    funct     = (instruction      ) & ((1 <<  6) - 1); /* 6 least significant GPR_bts */
    ra        = (instruction >> 21) & ((1 <<  5) - 1);
    rb        = (instruction >> 16) & ((1 <<  5) - 1);
    rc        = (instruction >> 11) & ((1 <<  5) - 1);
    offset    = (instruction >>  6) & ((1 <<  5) - 1);
    immediate = (instruction      ) & ((1 << 16) - 1);
}

void compute_results(
    int instruction, 
    int program_counter, 
    int GPR_a, 
    int GPR_b, 
    int GPR_c, 
    int SPR_h, 
    int SPR_l
) {
    int *res = malloc(sizeof(int));

    uint64_t a;
    uint64_t b;
    uint64_t c;
    instruction_partition(instruction);

    switch(OpCode) {
        case SPECIAL_OP:
            switch(funct) {
                case ADD_FUNC: 
                    //--------------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 0 0 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|
                    // [Name]         Add Word (overflow)
                    // [Assembly]     ADD c, a, b
                    // [Operation]    {OF, GPR[c]} <- GPR[a] + GPR[b]
                    // [Description]  The 32-GPR_bt word value in GPR[a] is added to the 32-GPR_bt
                    // value in GPR[b] to produce a 32-GPR_bt result.
                    GPR_a_dat = GPR_a;
                    GPR_a_val = 0;
                    GPR_b_dat = GPR_b;                    
                    GPR_b_val = 0;
                    a = (uint64_t) GPR_a & 0x00000000FFFFFFFF;
                    b = (uint64_t) GPR_b & 0x00000000FFFFFFFF;
                    c = (uint64_t) (a + b);
                    if ((c >> 32) != 0) {
                        // • If the addition results in 32-GPR_bt 2’s complement arithmetic
                        //   overflow, the destination register is not modified and an Integer
                        //   Overflow exception occurs.
                        GPR_c_dat = GPR_c;
                        GPR_c_val = 0;
                        SPR_o_val = 1;
                    }
                    else {
                        // • If the addition does not overflow, the 32-GPR_bt result is placed into 
                        //   GPR[c].
                        GPR_c_dat = (uint32_t) c;
                        GPR_c_val = 1;
                        SPR_o_val = 0;
                    }
                    SPR_h_dat = SPR_h;
                    SPR_h_val = 0;
                    SPR_l_dat = SPR_l;
                    SPR_l_val = 0;
                    SPR_z_val = c == 0;
                    break;
                case ADDU_FUNC:
                    //-----------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 0 1 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|
                    // [Name]        Add Unsigned Word
                    // [Assembly]    ADDU   c, a, b
                    // [Operation]   GPR[c] = GPR[a] + GPR[b]
                    // [Description] The 32-GPR_bt word value in GPR[b] is added to the 32-GPR_bt
                    // value in GPR[a] and the 32-GPR_bt arithmetic result is placed into GPR[c].
                    // No Integer Overflow exception occurs under any GPR_crcumstances.
                    GPR_a_dat = GPR_a;
                    GPR_a_val = 0;
                    GPR_b_dat = GPR_b;                    
                    GPR_b_val = 0;
                    a = (uint64_t) GPR_a & 0x00000000FFFFFFFF;
                    b = (uint64_t) GPR_b & 0x00000000FFFFFFFF;
                    c = (uint64_t) (a + b);
                    GPR_c_dat = (uint32_t) c;
                    GPR_c_val = 1;
                    SPR_h_dat = SPR_h;
                    SPR_h_val = 0;
                    SPR_l_dat = SPR_l;
                    SPR_l_val = 0;
                    SPR_o_val = 0;
                    SPR_z_val = (GPR_c_dat) == 0;
                    break;
                case DIV_FUNC:
                    GPR_a_dat = GPR_a;
                    GPR_b_dat = GPR_b;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Divide (with overflow)
                case DIVU_FUNC: 
                    GPR_a_dat = GPR_a;
                    GPR_b_dat = GPR_b;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Divide Unsigned Word
                case MULT_FUNC: 
                    GPR_a_dat = GPR_a;
                    GPR_b_dat = GPR_b;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Multiply Word
                case MULTU_FUNC:
                    GPR_a_dat = GPR_a;
                    GPR_b_dat = GPR_b;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Multiply Unsigned Word
                case SLT_FUNC:
                    GPR_a_dat = GPR_a;
                    GPR_b_dat = GPR_b;
                    GPR_c_dat = 0;  //
                    SPR_h_dat = 0;  //
                    SPR_l_dat = 0;  //
                    SPR_o_val = 0;  //
                    SPR_z_val = 0;  //
                    break;      //
                case SLTU_FUNC:
                    GPR_a_dat = GPR_a;
                    GPR_b_dat = GPR_b;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break;
                case SUB_FUNC:
                    //-----------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 1 0 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|
                    // [Name]        Subtraction with overflow
                    // [Assembly]    SUB  c, a, b
                    // [Operation]   GPR[c] = GPR[a] - GPR[b]
                    // [Description] The 32-GPR_bt word value in GPR[b] is subtracted from the 32-GPR_bt 
                    // in GPR[a] to produce a 32-GPR_bt reuslt. If the subtraction results in 32-GPR_bt 
                    // 2's complement arithmetic overflow, then the destination register is not 
                    // modified and an Integer Overflow exception occurs. If it does not overflow, 
                    // the 32-GPR_bt result is placed into GPR[c]
                    GPR_a_dat = GPR_a;
                    GPR_b_dat = GPR_b;
                    a = (uint64_t) GPR_a & 0x00000000FFFFFFFF;
                    b = (uint64_t) GPR_b & 0x00000000FFFFFFFF;
                    c = (uint64_t) (a - b);
                    if ((uint64_t) (c & 0xFFFFFFFF00000000) != (uint64_t) 0x0000000000000000) {
                        GPR_c_val = 0;
                        GPR_c_dat = GPR_c;
                        SPR_o_val = 1;
                    } else {
                        GPR_c_val = 1;
                        GPR_c_dat = (uint32_t) c;
                        SPR_o_val = 0;
                    }
                    SPR_h_dat = SPR_h;
                    SPR_h_val = 0;
                    SPR_l_dat = SPR_l;
                    SPR_l_val = 0;
                    SPR_z_val = (uint32_t) c == 0;
                    break;
                case SUBU_FUNC:
                    //-----------------------------------------------------------------------------
                    //    31         26 25       21 20       16 15       11 10       6  5           0
                    //   .-------------.-----------.-----------.-----------.-----------.-------------.
                    // R | 0 0 0 0 0 0 | a a a a a | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 0 0 1 1 |
                    //   '-------------'-----------'-----------'-----------'-----------'-------------'
                    //         |6|          |5|         |5|         |5|         |5|          |6|
                    // [Name]        Subtraction Unsigned Word
                    // [Assembly]    SUBU c, a, b
                    // [Operation]   GPR[c] = GPR[a] - GPR[b]
                    GPR_a_dat = GPR_a;
                    GPR_a_val = 0;
                    GPR_b_dat = GPR_b;
                    GPR_b_val = 0;
                    a = (uint64_t) GPR_a & 0x00000000FFFFFFFF;
                    b = (uint64_t) GPR_b & 0x00000000FFFFFFFF;
                    GPR_c_dat = (uint32_t) (a - b);
                    GPR_c_val = 1;
                    GPR_c_val = 1;
                    SPR_h_dat = SPR_h;
                    SPR_h_val = 0;
                    SPR_l_dat = SPR_l;
                    SPR_l_val = 0;
                    // No integer overflow exception occurs under any GPR_crcumstance.
                    SPR_o_val = 0;
                    SPR_z_val = GPR_c_dat == 0;
                    break;
                default: 
                    GPR_a_dat = GPR_a;
                    GPR_a_val = 0;
                    GPR_b_dat = GPR_b;
                    GPR_b_val = 0;
                    GPR_c_dat = GPR_c;
                    GPR_c_val = 0;
                    SPR_h_dat = SPR_h;
                    SPR_h_val = 0;
                    SPR_l_dat = SPR_l;
                    SPR_l_val = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    printf("[SPECIAL_OP] Error: Unrecognized function code %02x [0x%08x].", funct, instruction);
            }
            break;
        case SPECIAL2_OP:
            switch(funct) {
                case CLO_FUNC:   
                    break; // Count Leading Ones.
                case CLZ_FUNC:   
                    GPR_a_dat = 0;
                    GPR_b_dat = 0;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Count Leading Zeroes.
                case MADD_FUNC:  
                    GPR_a_dat = 0;
                    GPR_b_dat = 0;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Multiply and Add Word to SPR_h, Lo  
                case MADDU_FUNC: 
                    break; // Multiply and Add Unsigned Word to SPR_h, Lo
                case MSUB_FUNC:
                    GPR_a_dat = 0;
                    GPR_b_dat = 0;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Multiply and Subtract Word to SPR_h, Lo 
                case MSUBU_FUNC:
                    GPR_a_dat = 0;
                    GPR_b_dat = 0;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Multiply and Subtract Unsigned Word to SPR_h, Lo
                case MUL_FUNC:                   
                    GPR_a_dat = 0;
                    GPR_b_dat = 0;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    break; // Multiply Word to GPR
                default:        
                    GPR_a_dat = 0;
                    GPR_b_dat = 0;
                    GPR_c_dat = 0;
                    SPR_h_dat = 0;
                    SPR_l_dat = 0;
                    SPR_o_val = 0;
                    SPR_z_val = 0;
                    printf("[SPECIAL2_OP] Error: Unrecognized function code %02x.", funct);
            }
            break;
        case ADDI_OP:
            //--------------------------------------------------------------------------------
            //    31         26 25       21 20       16 15                            0
            //   .-------------.-----------.-----------.---------------------------------.
            // I | 0 0 1 0 0 0 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
            //   '-------------'-----------'-----------'---------------------------------'
            //         |6|          |5|         |5|                     |16|
            // [Name]        Add Immediate Signed Word
            // [Assembly]    ADDI b, a, Imm16
            // [Operation]   GPR[b] <- GPR[a] + {16{Imm16[15]}, Imm16[15:0]}
            // [Description] The 16-GPR_bt immediate is sign-extended and added to the contents of
            // general register GPR[a] to form a 32-GPR_bt result. The result is placed in general
            // register GPR[b]. An overflow exception occurs if the two SPR_hghest order carry-out
            // GPR_bts differ (2’s-complement overflow). The destination register GPR[b] is not 
            // modified when an integer overflow exception occurs.
            GPR_a_dat = 0;
            GPR_b_dat = 0;
            GPR_c_dat = 0;
            SPR_h_dat = 0;
            SPR_l_dat = 0;
            SPR_o_val = 0;
            SPR_z_val = 0;
            break;              
        case ADDIU_OP:
            //--------------------------------------------------------------------------------
            //    31         26 25       21 20       16 15                            0
            //   .-------------.-----------.-----------.---------------------------------.
            // I | 0 0 1 0 0 1 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
            //   '-------------'-----------'-----------'---------------------------------'
            //         |6|          |5|         |5|                     |16|
            // [Name]        Add Immediate Unsigned Word
            // [Assembly]    ADDIU 
            // [Operation]   GPR[b] <- GPR[a] + {16{Imm16[15]}, Imm16[15:0]}
            // [Description] The 16-GPR_bt signed immediate is added to the 32-GPR_bt value 
            // in GPR[a] and the 32-GPR_bt arithmetic result is placed into GPR[b].
            // No Integer Overflow exception occurs under any GPR_crcumstances.
            GPR_a_dat = 0;
            GPR_b_dat = 0;
            GPR_c_dat = 0;
            SPR_h_dat = 0;
            SPR_l_dat = 0;
            SPR_o_val = 0;
            SPR_z_val = 0;
            break;
        case SLTI_OP:
            GPR_a_dat = 0;
            GPR_b_dat = 0;
            GPR_c_dat = 0;
            SPR_h_dat = 0;
            SPR_l_dat = 0;
            SPR_o_val = 0;
            SPR_z_val = 0;
            break;
        case SLTIU_OP:
            GPR_a_dat = 0;
            GPR_b_dat = 0;
            GPR_c_dat = 0;
            SPR_h_dat = 0;
            SPR_l_dat = 0;
            SPR_o_val = 0;
            SPR_z_val = 0;
            break;
    }
}

int c_alu_gpr_a_dat(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return GPR_a_dat;
}

int c_alu_gpr_a_val(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return GPR_a_val;
}

int c_alu_gpr_b_dat(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return GPR_b_dat;
}

int c_alu_gpr_b_val(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return GPR_b_val;
}

int c_alu_gpr_c_dat(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return GPR_c_dat;
}

int c_alu_gpr_c_val(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return GPR_c_val;
}

int c_alu_spr_h_dat(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return SPR_h_dat;
}

int c_alu_spr_h_val(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return SPR_h_val;
}

int c_alu_spr_l_dat(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return SPR_l_dat;
}

int c_alu_spr_l_val(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return SPR_l_val;
}

int c_alu_spr_o_val(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return SPR_o_val;
}

int c_alu_spr_z_val(int instruction, int program_counter, int a, int b, int c, int h, int l) {
    compute_results(instruction, program_counter, a, b, c, h, l);
    return SPR_z_val;
}

