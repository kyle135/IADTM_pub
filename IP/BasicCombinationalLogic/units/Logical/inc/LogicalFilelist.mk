#########################################################################################
# XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export LOGICAL_INC_CURRENT_MAKEFILE   := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export LOGICAL_INC_MAKEFILE_DIRECTORY := $(dir $(LOGICAL_INC_CURRENT_MAKEFILE))
export LOGICAL_HDL_DIRECTORY          := $(abspath $(LOGICAL_INC_MAKEFILE_DIRECTORY)/../hdl)
export LOGICAL_HVL_DIRECTORY          := $(abspath $(LOGICAL_INC_MAKEFILE_DIRECTORY)/../hvl)

export LOGICAL_MODELING               := \
    Behvioral \
    DataFlow \
    Structural

export LOGICAL_TOPS                   := \
	LogicalAND \
	LogicalEQ \
	LogicalGT \
	LogicalGTEQ \
	LogicalLT \
	LogicalLTEQ \
    LogicalNEQ \
    LogicalNOT \
    LogicalOR

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export LOGICAL_VERILOG_HDL_FILES      := \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalAND.sv \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalGT.sv \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalGTEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalLT.sv \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalLTEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalNEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalNOT.sv \
    $(LOGICAL_HDL_DIRECTORY)/BehavioralLogicalOR.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalAND.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalGT.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalGTEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalLT.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalLTEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalNEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalNOT.sv \
    $(LOGICAL_HDL_DIRECTORY)/DataFlowLogicalOR.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalAND.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalGT.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalGTEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalLT.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalLTEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalNEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalNOT.sv \
    $(LOGICAL_HDL_DIRECTORY)/LogicalOR.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalAND.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalGT.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalGTEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalLT.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalLTEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalNEQ.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalNOT.sv \
    $(LOGICAL_HDL_DIRECTORY)/StructuralLogicalOR.sv
#----------------------------------------------------------------------------------------
# Specify Verilog Simulation Files
#----------------------------------------------------------------------------------------
export LOGICAL_VERILOG_HVL_FILES      := \
	$(LOGICAL_HVL_DIRECTORY)/Interface/src/LogicalInterface.sv \
	$(LOGICAL_HVL_DIRECTORY)/LogicalHVL_pkg.sv \
	$(LOGICAL_HVL_DIRECTORY)/Logical_tb.sv
