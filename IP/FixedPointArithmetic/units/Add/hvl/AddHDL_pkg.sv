


package AddHDL_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

	virtual AddInterface v_AddInterface;

	`include "hvl/Config/src/AddConfig.svh"
	`include "hvl/SequenceItems/src/AddSequenceItem.svh"
	`include "hvl/Sequence/src/AddSequence.svh"
	`include "hvl/Sequencer/src/AddSequencer.svh"
	`include "hvl/Monitor/src/AddMonitor.svh"
	`include "hvl/Driver/src/AddDriver.svh"
	`include "hvl/Agent/src/AddAgent.svh"
	`include "hvl/ScoreBoard/src/AddScoreBoard.svh"
    `include "hvl/Environment/src/AddEnvironment.svh"
	`include "hvl/Test/src/AddTest.svh"

endpackage
