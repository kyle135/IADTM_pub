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
export BITWISE_INC_HDL_DIRECTORY      := $(abspath $(BITWISE_INC_MAKEFILE_DIRECTORY)/../hdl)
export BITWISE_INC_HVL_DIRECTORY      := $(abspath $(BITWISE_INC_MAKEFILE_DIRECTORY)/../hvl)

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
	hdl/BehavioralBitWiseAND.sv \
	hdl/BehavioralBitWiseNAND.sv \
	hdl/BehavioralBitWiseNOR.sv \
	hdl/BehavioralBitWiseNOT.sv \
	hdl/BehavioralBitWiseOR.sv \
	hdl/BehavioralBitWiseShiftLeft.sv \
	hdl/BehavioralBitWiseShiftRight.sv \
	hdl/BehavioralBitWiseXNOR.sv \
	hdl/BehavioralBitWiseXOR.sv \
	hdl/BitWiseAND.sv \
	hdl/BitWiseShiftMux.sv \
	hdl/BitWiseNAND.sv \
	hdl/BitWiseNOR.sv \
	hdl/BitWiseNOT.sv \
	hdl/BitWiseOR.sv \
	hdl/BitWiseShiftLeft.sv \
	hdl/BitWiseShiftRight.sv \
	hdl/BitWiseXNOR.sv \
	hdl/BitWiseXOR.sv \
	hdl/DataFlowBitWiseAND.sv \
	hdl/DataFlowBitWiseNAND.sv \
	hdl/DataFlowBitWiseNOR.sv \
	hdl/DataFlowBitWiseNOT.sv \
	hdl/DataFlowBitWiseOR.sv \
	hdl/DataFlowBitWiseShiftLeft.sv \
	hdl/DataFlowBitWiseShifRight.sv \
	hdl/DataFlowBitWiseXNOR.sv \
	hdl/DataFlowBitWiseXOR.sv \
	hdl/StructuralBitWiseAND.sv \
	hdl/StructuralBitWiseNAND.sv \
	hdl/StructuralBitWiseNOR.sv \
	hdl/StructuralBitWiseNOT.sv \
	hdl/StructuralBitWiseOR.sv \
	hdl/StructuralBitWiseShiftLeft.sv \
	hdl/StructuralBitWiseShiftRight.sv \
	hdl/StructuralBitWiseXNOR.sv \
	hdl/StructuralBitWiseXOR.sv
#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export BITWISE_VERILOG_HVL_FILES := \
	hvl/Interface/src/BitWiseInterface.sv \
	hvl/BitWiseHDL_pkg.sv \
	hvl/BitWise_tb.sv

