


always @(posedge clk) begin
    // Case Z definition
    // In the casez the don't-care value can represented by the question mark (?)
    // while the High-Impedence value is represented by the letter z (z).
    casez(Instruction)

        {SEB_OP, 5'b?????, 5'b?????, 5'b?????, 5'b10000, SEB_FUNC}: begin : SEB_INSTRUCTION
            //--------------------------------------------------------------------------------
            //    31         26 25       21 20       16 15       11 10       6  5           0
            //   .-------------.-----------.-----------.-----------.-----------.-------------.
            // R | 0 1 1 1 1 1 | 0 0 0 0 0 | b b b b b | c c c c c | 1 0 0 0 0 | 1 0 0 0 0 0 |
            //   '-------------'-----------'-----------'-----------'-----------'-------------'
            //         |6|          |5|         |5|         |5|         |5|          |6|
            // [Name]         Sign Extend Byte
            // [Assembly]     SEB     c, a
            // [Operation]    GPR[c] = sign_extend (GPR[a] & 0x000000ff)
            // [Description]  
            ALUOut <= {{24{a[7]}},a[7:0]};
        end : SEB_INSTRUCTION          
        {SEH_OP, 5'b?????, 5'b?????, 5'b?????, 5'b10000, SEH_FUNC}: begin : SEH_INSTRUCTION			
            //--------------------------------------------------------------------------------
            //    31         26 25       21 20       16 15       11 10       6  5           0
            //   .-------------.-----------.-----------.-----------.-----------.-------------.
            // R | 0 1 1 1 1 1 | 0 0 0 0 0 | b b b b b | c c c c c | 1 1 0 0 0 | 1 0 0 0 0 0 |
            //   '-------------'-----------'-----------'-----------'-----------'-------------'
            //         |6|          |5|         |5|         |5|         |5|          |6|
            // [Name]         Sign Extend Halfword   
            // [Assembly]     SEH     c, a
            // [Operation]    GPR[c] = sign_extend (GPR[a] & 0x0000ffff)
            // [Description]  
            ALUOut <= {{16{a[15]}},a[15:0]};
        end : SEH_INSTRUCTION


        {SLT_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, SLT_FUNC}: begin : SLT_INSTRUCTION
            //////////////////////////////////////////////////////////////////////////////////////////
            // SLT                                                                 Set on Less Than //
            //--------------------------------------------------------------------------------------//
            //                  31 26 25 21 20 16 15 11 10 06 05  00                                //
            //                 .-----.-----.-----.-----.-----.------.                               //
            // slt  rd, rs, rt | 0x0 | a | rt  | rd  | 0x0 | 0x2A |                               //
            //                 '-----'-----'-----'-----'-----'------'                               //
            //                    6     5     5     5     5     6                                   //
            // Format: SLT  rd, rs rt                                                               //
            // Purpose: To record the ALUOut of a less-than comparison                              //
            // Description: rd <- (rs < rt)                                                         //
            // Comparee the contents of GPR rs and GPR rt as signed integers and record the         //
            // Boolean ALUOut of the comparison in GPR rd. If GPR rs is less than GPR rt the ALUOut //
            // is 1 (true), otherwise 0 (false).                                                    //
            ALUOut <= {N{1'b0}};
        end : SLT_INSTRUCTION
        {SLT_OP,   5'b?????, 5'b?????, 5'b?????, 5'b00000, SLT_FUNC}: begin : SET_ON_LESS_THAN_INSTRUCTION
            //--------------------------------------------------------------------------------
            //    31         26 25       21 20       16 15       11 10       6  5           0
            //   .-------------.-----------.-----------.-----------.-----------.-------------.
            // R | 0 0 0 0 0 0 | 0 0 0 0 0 | b b b b b | c c c c c | 0 0 0 0 0 | 1 0 1 0 1 0 |
            //   '-------------'-----------'-----------'-----------'-----------'-------------'
            //         |6|          |5|         |5|         |5|         |5|          |6|
            // [Name]        Set on less than
            // [Assembly]    SRA    c, a, s
            // [Operation]   GPR[c] = GPR[a] < GPR[b]			
            // [Description] 
            ALUOut <= {N{1'b0}};
        end : SET_ON_LESS_THAN_INSTRUCTION
        {SLTI_OP, 5'b?????, 5'b?????, 16'b????????????????}: begin : SET_ON_LESS_THAN_IMMEDIATE_INSTRUCTION
            //--------------------------------------------------------------------------------
            //    31         26 25       21 20       16 15                            0
            //   .-------------.-----------.-----------.---------------------------------.
            // I | 0 0 1 0 1 0 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
            //   '-------------'-----------'-----------'---------------------------------'
            //         |6|          |5|         |5|                     |16|
            //
            //
            // [Name]        Set on less than immediate
            // [Assembly]    SLTI    b, a, Imm16
            // [Operation]   
            // [Description] 

            ALUOut <= {N{1'b0}};
        end : SET_ON_LESS_THAN_IMMEDIATE_INSTRUCTION
        {SLTIU_OP, 5'b?????, 5'b?????, 16'b????????????????}: begin : SET_ON_LESS_THAN_IMMEDIATE_UNSIGNED_INSTRUCTION
            //--------------------------------------------------------------------------------
            //    31         26 25       21 20       16 15                            0
            //   .-------------.-----------.-----------.---------------------------------.
            // I | 0 0 1 0 1 1 | a a a a a | b b b b b | i i i i i i i i i i i i i i i i |
            //   '-------------'-----------'-----------'---------------------------------'
            //         |6|          |5|         |5|                     |16|
            // [Name]        Set on less than immediate Unsigned
            // [Assembly]    
            // [Operation]   
            // [Description] 
            ALUOut <= {N{1'b0}};
        end : SET_ON_LESS_THAN_IMMEDIATE_UNSIGNED_INSTRUCTION
        {SLTU_OP, 5'b??????, 5'b?????, 5'b?????, 5'n00000, SLTU_FUNC}: begin : SET_ON_LESS_THAN_UNSIGNED_INSTRUCTION
            //--------------------------------------------------------------------------------
            //    31         26 25       21 20       16 15       11 10       6  5           0
            //   .-------------.-----------.-----------.-----------.-----------.-------------.
            // R | 0 0 0 0 0 0 | 0 0 0 0 0 | b b b b b | c c c c c | s s s s s | 1 0 1 0 1 1 |
            //   '-------------'-----------'-----------'-----------'-----------'-------------'
            //         |6|          |5|         |5|         |5|         |5|          |6|
            // [Name]       Set on Less than (unsigned)
            // [Assembly]    
            // [Operation]   
            // [Description] 
            ALUOut <= {N{1'b0}};
        end : SET_ON_LESS_THAN_UNSIGNED_INSTRUCTION


        {LW_OP,    5'b00000, 5'b?????, 16'b????????????????}: begin : LOAD_WORD_INSTRUCTION
            //-----------------------------------------------------------------------
            //    31 26 25 21 20 16 15              00
            //   .-----.-----.-----.------------------.
            // I | x23 |  a  |  b  |    offset     | LW (Load Word)
            //   '-----'-----'-----'------------------'
            //     |6|   |5|   |5|         |16|
            // • [Format] LW b, offset(a)
            // • [Description] The 16-bit offset is sign-extended and added to the
            //   contents of general register base to form a virtual address. The
            //   contents of the word at the memory location specified by the
            //   effective address are loaded into general register b.
            ALUOut              <= {{16{immediate[15]}}, {16{immediate[15]}}} + a;
        end : LOAD_WORD_INSTRUCTION
        {SW_OP,    5'b?????, 5'b?????, 16'b????????????????}: begin : STORE_WORD_INSTRUCTION
            //  31 26 25 21 20 16 15               0
            // .-----.-----.-----.------------------.
            // | x23 | a | rt  |    immediate     | SW (Store Word)
            // '-----'-----'-----'------------------'
            //   |6|   |5|   |5|         |16|
            // Format: I
            // Purpose:
            // Description: MEM[$s + offset] = $t
            ALUOut              <= {N{1'b0}};
        end : STORE_WORD_INSTRUCTION
        {LUI_OP,   5'b00000, 5'b?????, 16'b????????????????}: begin : LOAD_UPPER_IMMEDIATE_INSTRUCTION
            //////////////////////////////////////////////////////////////////////////////////////////
            // LUI Load upper immediate
            //--------------------------------------------------------------------------------------//
            //
            //                31  26 25 21 20 16 15              00
            //                +-----+-----+-----+------------------+
            // LUI RT, IMM    | 0xF |  0  | R3  |    IMMEDIATE     |
            //                '-----'-----'-----'-----'-----'------'
            //                   6     5     5          16
            ALUOut <= {N{1'b0}};
        end : LOAD_UPPER_IMMEDIATE_INSTRUCTION


        //-------------------------------------------------------------------------//
        // Conditional branch                                                      //
        //-------------------------------------------------------------------------//
        {BEQ_OP,   5'b?????, 5'b?????, 16'b????????????????}: begin : BRANCH_ON_EQUAL_INSTRUCTION
            //-----------------------------------------------------------------------
            //    31 26 25 21 20 16 15              00
            //   .-----.-----.-----.------------------.
            // I | x04 | a | rt  |    immediate     | BEQ (Branch on Equal)
            //   '-----'-----'-----'------------------'
            //     |6|   |5|   |5|          |16|
            //
            // [Format] BEQ rs, rt, offset
            // [Description] A branch target address is computed from the sum of the
            // address of the instruction in the delay slot and the 16-bit offset,
            // shifted left two bits and sign-extended to 32 bits. The contents of
            // general register rs and the contents of general register rt are
            // compared. If the two registers are equal, then the program branches
            // to the target address, with a delay of one instruction.
            ALUOut <= a == b ? ProgramCounter + {{14{immediate[15]}}, immediate, {2{1'b0}}} : ProgramCounter;
        end : BRANCH_ON_EQUAL_INSTRUCTION
        {BNE_OP,   5'b?????, 5'b?????, 16'b????????????????}: begin : BNE_INSTRUCTION
            // BNE:     BRANCH ON NOT EQUAL_INSTRUCTION
            // BNE                                                               Branch on Not Equal//
            //--------------------------------------------------------------------------------------//
            //  31 26 25 21 20 16 15              00                                                //
            // .-----.-----.-----.------------------.                                               //
            // | 0xF |  R1 | R2  |    IMMEDIATE     |                                               //
            // '-----'-----'-----'------------------'                                               //
            //    6     5     5          16                                                         //
            // Format: BNE  rs, rt, offset                                                          //
            // Purpose: To compare GPRs then do a PC-relative conditional branch                    //
            // Description: if (rs != rt) then branch                                               //
            // An 18-bit signed offset (the 16-bit offset field shifted left 2-bits) is added to the//
            // address of the instruction following the branch (not the branch itself), in the      //
            // branch delay slot, to form a PC-relative effective target address.                   //
            //                                                                                      //
            // If the contents of GPR rs and GPR rt are not equal, branch to the effect target      //
            // address after the instruction in the delay slot is executed.                         //
            ALUOut <= {N{1'b0}};
        end : BNE_INSTRUCTION
        {BGTZ_OP,  5'b?????, 5'b00000, 16'b????????????????}: begin : BGTZ_INSTRUCTION
            //                   31 26 25 21 20 16 15              00
            //                  .-----.-----.-----.------------------.
            // bgtz  rs, offset | 0x7 |  rs |  0  |    IMMEDIATE     | BGTZ (Branch on Greater than Zero)
            //                  '-----'-----'-----'------------------'
            //                     6     5     5          16
            ALUOut <= {N{1'b0}};
        end : BGTZ_INSTRUCTION
        //-------------------------------------------------------------------------//
        // Unconditional Jump
        //-------------------------------------------------------------------------//
        {J_OP,     26'b?????????????????????????? /* DONE */}: begin : JUMP_INSTRUCTION
            //-----------------------------------------------------------------------
            //    31 26 25                           0
            //   .-----.------------------------------.
            // J | x02 |          address             | J (Jump)
            //   '-----'------------------------------'
            //     |6|              |26|
            // [Format] J address
            // [Description] The 26-bit target address is shifted left two bits and
            // combined with the high order four bits of the address of the
            // instruction in the delay slot. The program unconditionally jumps to
            // this calculated address with a delay of one instruction.
            ALUOut <= {Instruction[31:28], immediate, {2{1'b0}}};
        end : JUMP_INSTRUCTION
        {JAL_OP,   26'b?????????????????????????? /* DONE */}: begin : JUMP_AND_LINK_INSTRUCTION
            //-----------------------------------------------------------------------
            //    31 26 25                           0
            //   .-----.------------------------------.
            // J | x03 |          address             | JAL (Jump and Link)
            //   '-----'------------------------------'
            //     |6|             |26|
            // • [Format] J address
            // • [Description] The 26-bit target address is shifted left two bits and
            // combined with the high order four bits of the address of the
            // instruction in the delay slot.  The program unconditionally jumps to
            // this calculated address with a delay of one instruction.  The address
            // of the instruction after the delay slot is placed in the link register,
            // r31.
            ALUOut <= {Instruction[31:28], immediate, {2{1'b0}}};
        end : JUMP_AND_LINK_INSTRUCTION
        {JR_OP,    5'b?????, 5'b00000, 5'b00000, 5'b00000, JR_FUNC /* DONE */}: begin : JUMP_REGISTER_INSTRUCTION
            //-----------------------------------------------------------------------
            //    31 26 25  21 20 16 15 11 10    6 5    0
            //   .-----.------.-----.-----.-------.------.
            // R | x08 |  a | rt  | rd  | shamt | func | JR (Jump Register)
            //   '-----'------'-----'-----'-------'------'
            //     |6|    |5|   |5|   |5|    |5|      6
            // • [Format] JR rs
            // • [Description] The program unconditionally jumps to the address
            //   contained in general register rs, with a delay of one instruction.
            //   This instruction is only valid when rd = 0. The low-order two bits
            //   of the target address in register rs must be zeros because
            //   instructions must be word-aligned.
            ALUOut <= ProgramCounter + a;
        end : JUMP_REGISTER_INSTRUCTION

        // BLEZ     BRANCH_ON_LESS THAN OR EQUAL TO ZERO_INSTRUCTION
        // BGTZ     BRANCH_ON_GREATER THAN ZERO_INSTRUCTION
        // BLTZ     BRANCH_ON_LESS THAN ZERO_INSTRUCTION
        // BGEZ     BRANCH_ON_GREATER THAN OR EQUAL TO ZERO_INSTRUCTION
        // BLTZAL   BRANCH_ON_LESS THAN ZERO AND LINK_INSTRUCTION
        // BGEZAL   BRANCH_ON_GREATER THAN OR EQUAL TO ZERO AND LINK_INSTRUCTION

        default: ALUOut <= {N{1'b0}};
    endcase
end