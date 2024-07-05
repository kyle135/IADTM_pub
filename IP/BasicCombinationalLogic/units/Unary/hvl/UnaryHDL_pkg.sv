


package UnaryHDL_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

	virtual UnaryInterface v_UnaryInterface;

	`include "hvl/Config/src/UnaryConfig.svh"
	`include "hvl/SequenceItems/src/UnarySequenceItem.svh"
	`include "hvl/Sequence/src/UnarySequence.svh"
	`include "hvl/Sequencer/src/UnarySequencer.svh"
	`include "hvl/Monitor/src/UnaryMonitor.svh"
	`include "hvl/Driver/src/UnaryDriver.svh"
	`include "hvl/Agent/src/UnaryAgent.svh"
	`include "hvl/ScoreBoard/src/UnaryScoreboard.svh"
    `include "hvl/Environment/src/UnaryEnvironment.svh"
	`include "hvl/Test/src/UnaryTest.svh"

endpackage
