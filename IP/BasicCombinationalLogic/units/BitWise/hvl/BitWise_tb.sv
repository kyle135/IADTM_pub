//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  BitWise_tb
// Module Name:  UVM Test Bench for testing bitwise designs.
// Dependencies:
//-----------------------------------------------------------------------------
`ifndef __BITWISE_TB__SV
    `define __BITWISE_TB__SV 
module BitWise_tb
#(  //-------------------------------------------------------------------------
    // Parameter(s)
    //-------------------------------------------------------------------------
    parameter string  DUT   = "UnaryAND",
    parameter string  MODEL = "Behavioral",
    parameter integer N     = 32,
    parameter integer O     = $clog2(N)
);
    import uvm_pkg::*;
    import BitWiseHVL_pkg::*;

    //-------------------------------------------------------------------------
    // Local TestBench Signals
    //-------------------------------------------------------------------------
    logic [N-1:0] BitWiseAND_c;
    logic [N-1:0] BitWiseNAND_c;
    logic [N-1:0] BitWiseOR_c;
    logic [N-1:0] BitWiseNOR_c;
    logic [N-1:0] BitWiseXOR_c;
    logic [N-1:0] BitWiseXNOR_c;
    logic [N-1:0] BitWiseNOT_c;
    logic [N-1:0] BitWiseShiftLeft_c;
    logic [N-1:0] BitWiseShiftRight_c;

    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    BitWiseAND        #(N, MODEL) u_BitWiseAND        (intf.a, intf.b, BitWiseAND_c);       //  &
    BitWiseNAND       #(N, MODEL) u_BitWiseNAND       (intf.a, intf.b, BitWiseNAND_c);      // ~&
    BitWiseOR         #(N, MODEL) u_BitWiseOR         (intf.a, intf.b, BitWiseOR_c);        //  |
    BitWiseNOR        #(N, MODEL) u_BitWiseNOR        (intf.a, intf.b, BitWiseNOR_c);       // ~|
    BitWiseXOR        #(N, MODEL) u_BitWiseXOR        (intf.a, intf.b, BitWiseXOR_c);       //  ^
    BitWiseXNOR       #(N, MODEL) u_BitWiseXNOR       (intf.a, intf.b, BitWiseXNOR_c);      // ~^
    BitWiseNOT        #(N, MODEL) u_BitWiseNOT        (intf.a,         BitWiseNOT_c);       // ~
    BitWiseShiftLeft  #(N, MODEL) u_BitWiseShiftLeft  (intf.a, intf.b[O-1:0], BitWiseShiftLeft_c); // <<
    BitWiseShiftRight #(N, MODEL) u_BitWiseShiftRight (intf.a, intf.b[O-1:0], BitWiseShiftRight_c);// >>

    //-------------------------------------------------------------------------
    // UVM Test Bench Components
    //-------------------------------------------------------------------------   
    BitWiseConfig     cfg;    //
    BitWiseInterface  intf(); // Interface to connect DUT to UVM test

    //-------------------------------------------------------------------------
    // UVM Test Start
    //-------------------------------------------------------------------------     
    initial begin
        cfg = new ("cfg");
        cfg.DUT = DUT;
        cfg.N = N;
        uvm_config_db#(virtual BitWiseInterface)::set(uvm_root::get ( ), "*", "intf", intf );
        uvm_config_db#(BitWiseConfig)::set(uvm_root::get( ), "*", "cfg", cfg );
        
        run_test ( "BitWiseTest" );
    end

    //-------------------------------------------------------------------------
    // Interface Connections
    //-------------------------------------------------------------------------    
    assign intf.c = (DUT == "BitWiseAND")        ? BitWiseAND_c        :
                    (DUT == "BitWiseNAND")       ? BitWiseNAND_c       :
                    (DUT == "BitWiseOR")         ? BitWiseOR_c         :
                    (DUT == "BitWiseNOR")        ? BitWiseNOR_c        :
                    (DUT == "BitWiseXOR")        ? BitWiseXOR_c        :
                    (DUT == "BitWiseXNOR")       ? BitWiseXNOR_c       :
                    (DUT == "BitWiseNOT")        ? BitWiseNOT_c        :
                    (DUT == "BitWiseShiftLeft")  ? BitWiseShiftLeft_c  :
                    (DUT == "BitWiseShiftRight") ? BitWiseShiftRight_c :
                    {N{1'b0}};

endmodule : BitWise_tb
`endif //  __BITWISE_TB__SV
