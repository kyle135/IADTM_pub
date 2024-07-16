//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  BitWiseHDL_pkg
// Module Name:  SystemVerilog package for testing bitwise designs.
// Dependencies:
//-----------------------------------------------------------------------------
package BitWiseHVL_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

	`include "hvl/Config/src/BitWiseConfig.svh"
	`include "hvl/SequenceItems/src/BitWiseSequenceItem.svh"
	`include "hvl/Sequence/src/BitWiseSequence.svh"
	`include "hvl/Sequencer/src/BitWiseSequencer.svh"
	`include "hvl/Monitor/src/BitWiseMonitor.svh"
	`include "hvl/Driver/src/BitWiseDriver.svh"
	`include "hvl/Agent/src/BitWiseAgent.svh"
	`include "hvl/ScoreBoard/src/BitWiseScoreboard.svh"
    `include "hvl/Environment/src/BitWiseEnvironment.svh"
	`include "hvl/Test/src/BitWiseTest.svh"
endpackage : BitWiseHVL_pkg
