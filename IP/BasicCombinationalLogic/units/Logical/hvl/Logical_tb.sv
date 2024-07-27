//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is 
//               licensed under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// IP Name:      BasicCombinationalLogic
// Unit Name:    Logical
// Module Name:  Logical Test Bench
// Dependencies: The design...
//-----------------------------------------------------------------------------
`ifndef __LOGICAL_TB__SV
    `define __LOGICAL_TB__SV 
//---------------------------------------------------------------------------------

//---------------------------------------------------------------------------------
module Logical_tb 
#(  //-------------------------------------------------------------------------
    // Parameter(s)
    //-------------------------------------------------------------------------
    parameter string  DUT   = "LogicalAND",
    parameter string  MODEL = "Behavioral",
    parameter integer N     = 32
);
    import uvm_pkg::*;
    import LogicalHVL_pkg::*;

    //-------------------------------------------------------------------------
    // Local TestBench Signals
    //-------------------------------------------------------------------------
    wire LogicalAND_c;
    wire LogicalEQ_c;
    wire LogicalGT_c;
    wire LogicalGTEQ_c;
    wire LogicalLT_c;
    wire LogicalLTEQ_c;
    wire LogicalNEQ_c;
    wire LogicalNOT_c;
    wire LogicalOR_c;
    
    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    LogicalAND  #(MODEL, N) u_LogicalAND  (intf.a, intf.b, LogicalAND_c);  // &&
    LogicalEQ   #(MODEL, N) u_LogicalEQ   (intf.a, intf.b, LogicalEQ_c);   // ==
    LogicalGT   #(MODEL, N) u_LogicalGT   (intf.a, intf.b, LogicalGT_c);   // >
    LogicalGTEQ #(MODEL, N) u_LogicalGTEQ (intf.a, intf.b, LogicalGTEQ_c); // >=
    LogicalLT   #(MODEL, N) u_LogicalLT   (intf.a, intf.b, LogicalLT_c);   // <
    LogicalLTEQ #(MODEL, N) u_LogicalLTEQ (intf.a, intf.b, LogicalLTEQ_c); // <=
    LogicalNEQ  #(MODEL, N) u_LogicalNEQ  (intf.a, intf.b, LogicalNEQ_c);  // !=
    LogicalNOT  #(MODEL, N) u_LogicalNOT  (intf.a,         LogicalNOT_c);  // !
    LogicalOR   #(MODEL, N) u_LogicalOR   (intf.a, intf.b, LogicalOR_c);   // ||

    //-------------------------------------------------------------------------
    // UVM Test Bench Components
    //-------------------------------------------------------------------------    
    LogicalConfig    cfg;    //
    LogicalInterface intf(); // Interface to connect DUT to UVM test

    //-------------------------------------------------------------------------
    // UVM Test Start
    //-------------------------------------------------------------------------    
    initial begin
        // Create and Populate the Logical Configuration object
        cfg = new ("cfg");
        cfg.DUT = DUT;
        cfg.N = N;

        uvm_config_db#(virtual LogicalInterface)::set(uvm_root::get ( ), "*", "intf", intf );
        uvm_config_db#(LogicalConfig)::set(uvm_root::get( ), "*", "cfg", cfg );
        
        run_test ( "LogicalTest" );
    end

    //-------------------------------------------------------------------------
    // Interface Connections
    //-------------------------------------------------------------------------   
    assign intf.c = (DUT == "LogicalAND")  ? LogicalAND_c  : // = a && b
                    (DUT == "LogicalEQ")   ? LogicalEQ_c   : // = a == b
                    (DUT == "LogicalGT")   ? LogicalGT_c   : // = a >  b
                    (DUT == "LogicalGTEQ") ? LogicalGTEQ_c : // = a >= b
                    (DUT == "LogicalLT")   ? LogicalLT_c   : // = a <  b
                    (DUT == "LogicalLTEQ") ? LogicalLTEQ_c : // = a <= b
                    (DUT == "LogicalNEQ")  ? LogicalNEQ_c  : // = a != a
                    (DUT == "LogicalNOT")  ? LogicalNOT_c  : // = ! a
                    (DUT == "LogicalOR")   ? LogicalOR_c   : // = a || b
                    1'b0;

endmodule : Logical_tb
`endif //  __LOGICAL_TB__SV
