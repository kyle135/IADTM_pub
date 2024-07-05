


package LogicalHDL_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

	virtual LogicalInterface v_LogicalInterface;

	typedef enum int {
		BehavioralLogicalNOT,
		BehavioralLogicalNAND,
		BehavioralLogicalAND,
		BehavioralLogicalOR,
		BehavioralLogicalLT,
		BehavioralLogicalLTEQ,
		BehavioralLogicalGT,
		BehavioralLogicalGTEQ,
		BehavioralLogicalEQ,
		BehavioralLogicalNEQ,
		DataFlowLogicalNOT,
		DataFlowLogicalAND,
		DataFlowLogicalNAND,
		DataFlowLogicalOR,
		DataFlowLogicalLT,
		DataFlowLogicalLTEQ,
		DataFlowLogicalGT,
		DataFlowLogicalGTEQ,
		DataFlowLogicalEQ,
		DataFlowLogicalNEQ,
		StructuralLogicalNOT,
		StructuralLogicalAND,
		StructuralLogicalNAND,
		StructuralLogicalOR,
		StructuralLogicalLT,
		StructuralLogicalLTEQ,
		StructuralLogicalGT,
		StructuralLogicalGTEQ,
		StructuralLogicalEQ,
		StructuralLogicalNEQ
	} LogicalModule_t;


	`include "hvl/Config/src/LogicalConfig.svh"
	`include "hvl/SequenceItems/src/LogicalSequenceItem.svh"
	`include "hvl/Sequence/src/LogicalSequence.svh"
	`include "hvl/Sequencer/src/LogicalSequencer.svh"
	`include "hvl/Monitor/src/LogicalMonitor.svh"
	`include "hvl/Driver/src/LogicalDriver.svh"
	`include "hvl/Agent/src/LogicalAgent.svh"
	`include "hvl/ScoreBoard/src/LogicalScoreboard.svh"
    `include "hvl/Environment/src/LogicalEnvironment.svh"
	`include "hvl/Test/src/LogicalTest.svh"
endpackage
