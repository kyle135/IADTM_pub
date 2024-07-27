//-----------------------------------------------------------------------------
// Test-Bench
//-----------------------------------------------------------------------------
module Unary_tb
#(  //-------------------------------------------------------------------------
    // Parameter(s)
    //-------------------------------------------------------------------------
    parameter string  DUT   = "UnaryAND",
    parameter string  MODEL = "Behavioral",
    parameter integer N     = 32
);
    import uvm_pkg::*;
    import UnaryHVL_pkg::*;

    //-------------------------------------------------------------------------
    // Local TestBench Signals
    //-------------------------------------------------------------------------    
    wire UnaryAND_c;
    wire UnaryNAND_c;
    wire UnaryNOR_c;
    wire UnaryNXOR_c;
    wire UnaryOR_c;
    wire UnaryXNOR_c;
    wire UnaryXOR_c;

    //-------------------------------------------------------------------------
    // UVM Test Bench Components
    //-------------------------------------------------------------------------
    UnaryConfig    cfg;    
    UnaryInterface intf(); 
    
    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    UnaryAND  #(MODEL, N) u_UnaryAND  (intf.a, UnaryAND_c);
    UnaryNAND #(MODEL, N) u_UnaryNAND (intf.a, UnaryNAND_c);
    UnaryNOR  #(MODEL, N) u_UnaryNOR  (intf.a, UnaryNOR_c);
    UnaryNXOR #(MODEL, N) u_UnaryNXOR (intf.a, UnaryNXOR_c);
    UnaryOR   #(MODEL, N) u_UnaryOR   (intf.a, UnaryOR_c);
    UnaryXNOR #(MODEL, N) u_UnaryXNOR (intf.a, UnaryXNOR_c);
    UnaryXOR  #(MODEL, N) u_UnaryXOR  (intf.a, UnaryXOR_c);

    //-------------------------------------------------------------------------
    // UVM Test Start
    //-------------------------------------------------------------------------
    initial begin
        cfg = new ("cfg");
        cfg.DUT = DUT;
        cfg.N = N;
        uvm_config_db#(virtual UnaryInterface)::set(uvm_root::get ( ), "*", "intf", intf );
        uvm_config_db#(UnaryConfig)::set(uvm_root::get( ), "*", "cfg", cfg );
        
        run_test ( "UnaryTest" );
    end

    //-------------------------------------------------------------------------
    // Interface Connections
    //-------------------------------------------------------------------------    
    assign intf.c = (DUT == "UnaryAND")  ? UnaryAND_c  : // =  & a
                    (DUT == "UnaryNAND") ? UnaryNAND_c : // = ~& a 
                    (DUT == "UnaryNOR")  ? UnaryNOR_c  : // = ~| a
                    (DUT == "UnaryNXOR") ? UnaryNXOR_c : // = ^~ a
                    (DUT == "UnaryOR")   ? UnaryOR_c   : // =  | a
                    (DUT == "UnaryXNOR") ? UnaryXNOR_c : // = ~^ a
                    (DUT == "UnaryNOR")  ? UnaryNOR_c  : // = ~| a
                    (DUT == "UnaryXOR")  ? UnaryXOR_c  : // =  ^ a
                    1'b0;


endmodule : Unary_tb
