#########################################################################################
# XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export UNARY_INC_CURRENT_MAKEFILE   := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export UNARY_INC_MAKEFILE_DIRECTORY := $(dir $(UNARY_INC_CURRENT_MAKEFILE))
export UNARY_HDL_DIRECTORY          := $(abspath $(UNARY_INC_MAKEFILE_DIRECTORY)/../hdl)
export UNARY_HVL_DIRECTORY          := $(abspath $(UNARY_INC_MAKEFILE_DIRECTORY)/../hvl)

export UNARY_MODELING               := \
    DataFlow \
    Structural \
    Behvioral

export UNARY_TOPS                   := \
    UnaryAND \
    UnaryNAND \
    UnaryNOR \
    UnaryNXOR \
    UnaryOR \
    UnaryXNOR \
    UnaryXOR

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
# • &  ~&  |  ~|  ^  ~^  ^~
export UNARY_VERILOG_HDL_FILES      := \
    $(UNARY_HDL_DIRECTORY)/BehavioralUnaryAND.sv \
    $(UNARY_HDL_DIRECTORY)/BehavioralUnaryNAND.sv \
    $(UNARY_HDL_DIRECTORY)/BehavioralUnaryNOR.sv \
    $(UNARY_HDL_DIRECTORY)/BehavioralUnaryNXOR.sv \
    $(UNARY_HDL_DIRECTORY)/BehavioralUnaryOR.sv \
    $(UNARY_HDL_DIRECTORY)/BehavioralUnaryXNOR.sv \
    $(UNARY_HDL_DIRECTORY)/BehavioralUnaryXOR.sv \
    $(UNARY_HDL_DIRECTORY)/DataFlowUnaryAND.sv \
    $(UNARY_HDL_DIRECTORY)/DataFlowUnaryNAND.sv \
    $(UNARY_HDL_DIRECTORY)/DataFlowUnaryNOR.sv \
    $(UNARY_HDL_DIRECTORY)/DataFlowUnaryNXOR.sv \
    $(UNARY_HDL_DIRECTORY)/DataFlowUnaryOR.sv \
    $(UNARY_HDL_DIRECTORY)/DataFlowUnaryXNOR.sv \
    $(UNARY_HDL_DIRECTORY)/DataFlowUnaryXOR.sv \
    $(UNARY_HDL_DIRECTORY)/StructuralUnaryAND.sv \
    $(UNARY_HDL_DIRECTORY)/StructuralUnaryNAND.sv \
    $(UNARY_HDL_DIRECTORY)/StructuralUnaryNOR.sv \
    $(UNARY_HDL_DIRECTORY)/StructuralUnaryNXOR.sv \
    $(UNARY_HDL_DIRECTORY)/StructuralUnaryOR.sv \
    $(UNARY_HDL_DIRECTORY)/StructuralUnaryXNOR.sv \
    $(UNARY_HDL_DIRECTORY)/StructuralUnaryXOR.sv \
    $(UNARY_HDL_DIRECTORY)/UnaryAND.sv \
    $(UNARY_HDL_DIRECTORY)/UnaryNAND.sv \
    $(UNARY_HDL_DIRECTORY)/UnaryNOR.sv \
    $(UNARY_HDL_DIRECTORY)/UnaryNXOR.sv \
    $(UNARY_HDL_DIRECTORY)/UnaryOR.sv \
    $(UNARY_HDL_DIRECTORY)/UnaryXNOR.sv \
    $(UNARY_HDL_DIRECTORY)/UnaryXOR.sv

#----------------------------------------------------------------------------------------
# Specify Verilog Simulation Files
#----------------------------------------------------------------------------------------
export UNARY_VERILOG_HVL_FILES      := \
	$(UNARY_HVL_DIRECTORY)/Interface/src/UnaryInterface.sv \
	$(UNARY_HVL_DIRECTORY)/UnaryHVL_pkg.sv \
	$(UNARY_HVL_DIRECTORY)/Unary_tb.sv
