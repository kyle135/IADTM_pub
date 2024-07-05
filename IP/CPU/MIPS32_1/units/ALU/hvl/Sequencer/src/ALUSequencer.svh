//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     ALUSequencer
// Description:
// · The sequencer receives handles to transactions from one or more sequences, and routes them
//   to a driver.
// · Arbitrates transactions from multiple sequences.
// · Almost never extended.
//-------------------------------------------------------------------------------------------------
`ifndef __ALUSEQUENCER__SVH
    `define __ALUSEQUENCER__SVH
typedef uvm_sequencer #( ALUSequenceItem) ALUSequencer;
`endif // __ALUSEQUENCER__SVH