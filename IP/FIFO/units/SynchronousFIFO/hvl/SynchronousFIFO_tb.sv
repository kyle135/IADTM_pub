//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
//-------------------------------------------------------------------------------------------------
`timescale 1ns / 1ps
module SynchronousFIFO_tb
#(  //---------------------------------------------------------------------------------------------
    // Parameter(s)
    //---------------------------------------------------------------------------------------------
    parameter integer N     = 32,
    parameter integer O     = $clog2(N)
);
    import uvm_pkg::*;
    import SynchronousFIFO_hvl_pkg::*;
    
    //---------------------------------------------------------------------------------------------
    // Local Parameters
    //---------------------------------------------------------------------------------------------
    localparam MAX_DELAY=150;
    
    //---------------------------------------------------------------------------------------------
    // Local TestBench Signals
    //---------------------------------------------------------------------------------------------
    bit clk  = 1'b1;
    
    //-----------------------------------------------------------------------------------------
    // Module Instantiation
    //-----------------------------------------------------------------------------------------
    SynchronousFIFO
    #(  //-------------------------------------//----------------------------------------------
        // Parameters                          // Description(s)
        //-------------------------------------//----------------------------------------------
        .N        ( N                       )  // Data path bit-width
    )                                          //
    u_SynchronousFIFO                          //
    (   //-------------------------------------//----------------------------------------------
        // Global Signals                      // Direction, Size & Description(s) 
        //-------------------------------------//----------------------------------------------
        .clk      ( sync_fifo_intf.clk      ), // [I][1] Core Clock
        .rstn     ( sync_fifo_intf.rstn     ), // [I][1] Asynchronous Reset, Synchronous Set (Active-Low)
        //-------------------------------------//----------------------------------------------
        // FIFO Write Interface                // Direction, Size & Description(s) 
        //-------------------------------------//----------------------------------------------
        .push     ( sync_fifo_intf.push     ), // Push data into FIFO
        .pushData ( sync_fifo_intf.pushData ), // Data to be pushed into FIFO
        .full     ( sync_fifo_intf.full     ), // FIFO is full
        //-------------------------------------//----------------------------------------------
        // FIFO Read Interface                 // Direction, Size & Description(s) 
        //-------------------------------------//----------------------------------------------
        .pop      (sync_fifo_intf.pop       ), // [I][1] Pop data from FIFO
        .popData  (sync_fifo_intf.popData   ), // [O][N] Data popped from FIFO
        .empty    (sync_fifo_intf.empty     )  // [O][1] FIFO is empty
    );
    
    //---------------------------------------------------------------------------------------------
    // UVM Test Bench Components
    //---------------------------------------------------------------------------------------------
    SynchronousFIFOConfig    sync_fifo_cfg;               // The ALU Confgiuration Object.
    SynchronousFIFOInterface sync_fifo_intf(clk);         // Interface to connect DUT to UVM test
    
    //---------------------------------------------------------------------------------------------
    // UVM Test Start
    //---------------------------------------------------------------------------------------------
    initial begin
        sync_fifo_intf.rstn = 1'b0;
        sync_fifo_cfg = new("SynchronousFIFOConfig");   // Create the configuration object
    
        uvm_config_db#(virtual SynchronousFIFOInterface)::set(uvm_root::get( ), "*", "sync_fifo_intf", sync_fifo_intf);
        uvm_config_db#(SynchronousFIFOConfig)::set(uvm_root::get( ), "*", "sync_fifo_cfg", sync_fifo_cfg);
    
        fork
            forever  #5ns clk <= ~clk;
                    #21ns sync_fifo_intf.rstn = 1'b1;
            run_test("ALUTest");
        join
    end
    
endmodule : SynchronousFIFO_tb
