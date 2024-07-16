#########################################################################################
# XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export BITWISE_INC_CURRENT_MAKEFILE	  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export BITWISE_INC_MAKEFILE_DIRECTORY := $(dir $(BITWISE_INC_CURRENT_MAKEFILE))
export BITWISE_HDL_DIRECTORY      := $(abspath $(BITWISE_INC_MAKEFILE_DIRECTORY)/../hdl)
export BITWISE_HVL_DIRECTORY      := $(abspath $(BITWISE_INC_MAKEFILE_DIRECTORY)/../hvl)

export BITWISE_MODELING               := \
    Behavioral \
    DataFlow \
    Structural

export BITWISE_TOPS                   := \
	BitWiseAND \
	BitWiseNAND \
	BitWiseNOR \
	BitWiseNOT \
	BitWiseShiftLeft \
	BitWiseShiftRight \
	BitWiseOR \
	BitWiseXNOR \
	BitWiseXOR

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export BITWISE_VERILOG_HDL_FILES := \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseAND.sv \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseNAND.sv \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseNOR.sv \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseNOT.sv \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseOR.sv \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseShiftLeft.sv \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseShiftRight.sv \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseXNOR.sv \
	$(BITWISE_HDL_DIRECTORY)/BehavioralBitWiseXOR.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseAND.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseShiftMux.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseNAND.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseNOR.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseNOT.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseOR.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseShiftLeft.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseShiftRight.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseXNOR.sv \
	$(BITWISE_HDL_DIRECTORY)/BitWiseXOR.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseAND.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseNAND.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseNOR.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseNOT.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseOR.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseShiftLeft.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseShifRight.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseXNOR.sv \
	$(BITWISE_HDL_DIRECTORY)/DataFlowBitWiseXOR.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseAND.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseNAND.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseNOR.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseNOT.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseOR.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseShiftLeft.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseShiftRight.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseXNOR.sv \
	$(BITWISE_HDL_DIRECTORY)/StructuralBitWiseXOR.sv
#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export BITWISE_VERILOG_HVL_FILES := \
	$(BITWISE_HVL_DIRECTORY)/Interface/src/BitWiseInterface.sv \
	$(BITWISE_HVL_DIRECTORY)/BitWiseHVL_pkg.sv \
	$(BITWISE_HVL_DIRECTORY)/BitWise_tb.sv

