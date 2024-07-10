//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//-------------------------------------------------------------------------------------------------
package SynchronousFIFO_hvl_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    parameter integer N   = 32; // Data path bit width   

    const logic FAILURE = 1'b0;
    const logic SUCCESS = 1'b1;

    `include "hvl/Test/src/SynchronousFIFOTest.svh"
    
endpackage : SynchronousFIFO_hvl_pkg
