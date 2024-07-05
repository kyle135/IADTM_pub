//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
//-------------------------------------------------------------------------------------------------
package SynchronousFIFO_hvl_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    parameter integer N   = 32; // Data path bit width   

    const logic FAILURE = 1'b0;
    const logic SUCCESS = 1'b1;

    `include "hvl/Test/src/SynchronousFIFOTest.svh"
    
endpackage : SynchronousFIFO_hvl_pkg
