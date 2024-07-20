




    typde enum logic [4:0] 
        Int     = 0,  // Interrupt
        Mod     = 1,  //
        TLBL    = 2,
        TLBS    = 3,
        AdEL    = 4,  // Address error (on load/l-fetch or store, respectively):
        AdES    = 5,  // attempt to get outside kuseg when in user mode or an attempt to read a doubleword, word, or halfword at a misaligned address.
        IBE     = 6,  // Bus error (instruction fetch or data read, respectively): External
        DBE     = 7,  // hardware has signalled an error of some kind; what you have to do about it is system dependent. A bus error on a store can only come about indirectly, as a result ofa cache read to obtain the cache line to be written.
        Syscall = 8,  // Generated unconditionally by a syscall instruction.
        Bp      = 9,  // Breakpoint: This is a break instruction.
        RI      = 10, // Reserved instruction: This is an instruction code undefined in this CPU.
        CpU     = 11, // Coprocessor unusable: This is a special kind of undefined instruction exception, where the instruction is in a coprocessor or load/store coprocessor format. In particular, this is the exception you get from a floating-point operation if the FPA usable bit, SR (CUI), is not set; hence it is where floating point emulation starts.
        Ov      = 12, // Arithmetic overflow: Note that unsigned versions of instructions (e.g., addu) never cause the exception.
        TRAP    = 13, // This comes from one of the conditional trap instructions added with MIPS II.
        VCEI    = 14, // Virtual coherency error in the I-cache: This is only relevant to R4000 and above CPUs that have a secondary cache and that use the secondary cache tag bits to check for cache aliases.
        FPE     = 15, // Floating-point exception: This occurs only in MIPS II and higher CPUs. In MIPS I CPUs, floating-point exceptions are signalled as interrupts.
        C2E     = 16, // Exception from coprocessor 2
        Watch   = 23, // Physical address of load/store matched enabled value in WatchLo/WatchHi registers.
        VCED    = 31  // Virtual coherency error on data: This is the same as for VCEI.
    } ExcCode_t;


    typedef struct {
        logic              BD;        // [   31]
        logic              B30;       // [   30] Unused
        logic       [ 1:0] CE;        // [29:28]
        logic       [11:0] B27_B16;   // [27:16] Unused
        logic       [ 7:0] IP;        // [15: 8]
        logic              B07;       // [    7] Unused
        ExcCode_t          ExcCode;   // [ 6: 2] This is a 5-bit code that tells you what kind of exception happened, as detailed in Table 3.3.
        logic       [ 1:0] B01_B00;   // Unused
    } CauseRegister_t;

