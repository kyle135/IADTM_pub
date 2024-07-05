// Company: It's All Digital To Me
// Engineer: Kyle D. Gilsdorf
// Description:

`ifndef __ASYNCHRONOUSFIFOINTERFACE__SV
`define __ASYNCHRONOUSFIFOINTERFACE__SV

`include "uvm_macros.svh"
import    uvm_pkg::*;
import transactions_pkg::*;

interface AsynchronousFIFOWriteInterface;
    //-------------------------------------//--------------------------------------------
    // Parameter(s)                        // Description(s)
    //-------------------------------------//--------------------------------------------
    parameter int        BitWidth    = 32; //
    //-------------------------------------//--------------------------------------------
    // Global(s)                           // Description(s)
    //-------------------------------------//--------------------------------------------
    input  wire          clk;              // Core Clock
    input  wire          rst;              // Active-High Reset
    //-------------------------------------//--------------------------------------------
    // Internal Signals                    //
    //-------------------------------------//--------------------------------------------
    logic [BitWidth-1:0] data;             //
    logic                push;             //
    logic                full;             //
    logic                overflow;         //


    initial begin
        push = FALSE;
    end

    task write_fifo;                       //
    input logic [BitWidth-1:0] write_data; //
    begin                                  //
        push        = FALSE;               //
        while (full) @(posedge clk);       //
        push        = TRUE;                //
        data        = write_data;          //
        @(posedge clk);                    //
        push        = FALSE;               //
    end                                    //
    endtask : write_fifo                   //

endinterface : AsynchronousFIFOWriteInterface

interface AsynchronousFIFOReadInterface;
    //-------------------------------------//--------------------------------------------
    // Parameter(s)                        // Description(s)
    //-------------------------------------//--------------------------------------------
    parameter int        BitWidth    = 32; //
    //-------------------------------------//--------------------------------------------
    // Global(s)                           // Description(s)
    //-------------------------------------//--------------------------------------------
    input  wire          clk;              // Core Clock
    input  wire          rst;              // Active-High Reset
    //-------------------------------------//--------------------------------------------
    // Internal Signals                    //
    //-------------------------------------//--------------------------------------------
    logic [BitWidth-1:0] data;             //
    logic                pop;              //
    logic                empty;            //
    logic                underflow;        //

    initial begin
        pop = FALSE;
    end

    task read_fifo;
    output logic [BitWidth-1:0] read_data;  //
    begin                                   //
        pop       = FALSE;                  //
        while (empty) @(posedge clk);       //
        pop       = TRUE;                   //
        read_data = data;                   //
        @(posedge clk);                     //
        pop       = FALSE;                  //
    end                                     //
    endtask: read_fifo

endinterface : AsynchronousFIFOReadInterface
`endif // __ASYNCHRONOUSFIFOINTERFACE__SV
