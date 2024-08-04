`ifndef __ADD_TB__SV
    `define __ADD_TB__SV 
//-----------------------------------------------------------------------------
// Test-Bench
//-----------------------------------------------------------------------------
module Add_tb
#(  //-------------------------------------------------------------------------
    // Parameter(s)
    //-------------------------------------------------------------------------
    parameter string  DUT   = "Add",
    parameter integer N     = 32,
    parameter string  MODEL = "Strucutural",
    parameter string  TOP   = "RippleCarry"
);
    import uvm_pkg::*;
    import AddHDL_pkg::*;

    //-------------------------------------------------------------------------
    // Local TestBench Signals
    //-------------------------------------------------------------------------    

    //-------------------------------------------------------------------------
    // UVM Test Bench Components
    //-------------------------------------------------------------------------
    AddConfig    cfg;    
    AddInterface intf(); 
    
    //-------------------------------------------------------------------------
    // Module Instantiation
    //-------------------------------------------------------------------------
    Add  #(N, MODEL, TOP) u_Add  (intf.a, intf.b, intf.carry_in,  intf.c, intf.carry_out);

    //-------------------------------------------------------------------------
    // UVM Test Start
    //-------------------------------------------------------------------------
    initial begin
        cfg = new ("cfg");
        cfg.DUT = DUT;
        cfg.N = N;
        uvm_config_db#(virtual AddInterface)::set(uvm_root::get ( ), "*", "intf", intf );
        uvm_config_db#(AddConfig)::set(uvm_root::get( ), "*", "cfg", cfg );
        
        run_test ( "AddTest" );
    end

    //-------------------------------------------------------------------------
    // Interface Connections
    //-------------------------------------------------------------------------    



endmodule : Add_tb
`endif //  __ADD_TB__SV
