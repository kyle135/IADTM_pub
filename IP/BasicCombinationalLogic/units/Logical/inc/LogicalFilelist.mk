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
export LOGICAL_INC_HDL_DIRECTORY	  := $(abspath $(LOGICAL_INC_MAKEFILE_DIRECTORY)/../hdl)
export LOGICAL_INC_HVL_DIRECTORY	  := $(abspath $(LOGICAL_INC_MAKEFILE_DIRECTORY)/../hvl)

export BITWISE_MODELING               := \
    Behvioral \
    DataFlow \
    Structural

export BITWISE_TOPS                   := \
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
    hdl/BehavioralLogicalAND.sv \
    hdl/BehavioralLogicalEQ.sv \
    hdl/BehavioralLogicalGT.sv \
    hdl/BehavioralLogicalGTEQ.sv \
    hdl/BehavioralLogicalLT.sv \
    hdl/BehavioralLogicalLTEQ.sv \
    hdl/BehavioralLogicalNEQ.sv \
    hdl/BehavioralLogicalNOT.sv \
    hdl/BehavioralLogicalOR.sv \
    hdl/DataFlowLogicalAND.sv \
    hdl/DataFlowLogicalEQ.sv \
    hdl/DataFlowLogicalGT.sv \
    hdl/DataFlowLogicalGTEQ.sv \
    hdl/DataFlowLogicalLT.sv \
    hdl/DataFlowLogicalLTEQ.sv \
    hdl/DataFlowLogicalNEQ.sv \
    hdl/DataFlowLogicalNOT.sv \
    hdl/DataFlowLogicalOR.sv \
    hdl/LogicalAND.sv \
    hdl/LogicalEQ.sv \
    hdl/LogicalGT.sv \
    hdl/LogicalGTEQ.sv \
    hdl/LogicalLT.sv \
    hdl/LogicalLTEQ.sv \
    hdl/LogicalNEQ.sv \
    hdl/LogicalNOT.sv \
    hdl/LogicalOR.sv \
    hdl/StructuralLogicalAND.sv \
    hdl/StructuralLogicalEQ.sv \
    hdl/StructuralLogicalGT.sv \
    hdl/StructuralLogicalGTEQ.sv \
    hdl/StructuralLogicalLT.sv \
    hdl/StructuralLogicalLTEQ.sv \
    hdl/StructuralLogicalNEQ.sv \
    hdl/StructuralLogicalNOT.sv \
    hdl/StructuralLogicalOR.sv
#----------------------------------------------------------------------------------------
# Specify Verilog Simulation Files
#----------------------------------------------------------------------------------------
export LOGICAL_VERILOG_HVL_FILES      := \
	hvl/Interface/src/LogicalInterface.sv \
	hvl/LogicalHDL_pkg.sv \
	hvl/Logical_tb.sv
