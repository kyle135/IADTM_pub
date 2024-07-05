//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf
// Module Name: APBSequencer
// Description:
// · The sequencer receives handles to transactions from one or more sequences, and routes them
//   to a driver.
// · Arbitrates transactions from multiple sequences.
// · Almost never extended.
//-----------------------------------------------------------------------------
`ifndef __APBSEQUENCER__SVH
    `define __APBSEQUENCER__SVH
typedef uvm_sequencer #(APBSequenceItem) APBSequencer;
`endif // __APBSEQUENCER__SVH