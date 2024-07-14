


module ProcessorStatus(


);




    typedef union packed {
        logic [31:0] ProcessorStatus_w;
        struct packed {
            logic        S;    // [   31] Set to 1 when shifting of the PC Chain is enabled.
            logic        s;    // [   30]
            logic        I;    // [   29]
            logic        i;    // [   28]
            logic        M;    // [   27] When set to 1, the processor will not recognize interrupts.
            lgoic        m;    // [   26]
            logic        V;    // [   25]
            logic        v;    // [   24]
            logic        e;    // [   23]
            logic [ 3:0] E;    // [22:19]
            logic [14:0] R;    // [18: 4] Reserved
            logic        o;    // [    3] The o bit contains the previous value of the O
            logic        O;    // [    2] When a trap on overflow occurs, the O bit is set to 1 as seen by the exception handler.
            logic        u;    // [    1]
            logic        U;    // [    0]
        } ProcessorStatus_s;
    } ProcessorStatus_t;


endmodule : ProcessorStatus