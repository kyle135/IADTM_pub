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
export UNARY_INC_HDL_DIRECTORY      := $(abspath $(UNARY_INC_MAKEFILE_DIRECTORY)/../hdl)
export UNARY_INC_HVL_DIRECTORY      := $(abspath $(UNARY_INC_MAKEFILE_DIRECTORY)/../hvl)

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
    hdl/BehavioralUnaryAND.sv \
    hdl/BehavioralUnaryNAND.sv \
    hdl/BehavioralUnaryNOR.sv \
    hdl/BehavioralUnaryNXOR.sv \
    hdl/BehavioralUnaryOR.sv \
    hdl/BehavioralUnaryXNOR.sv \
    hdl/BehavioralUnaryXOR.sv \
    hdl/DataFlowUnaryAND.sv \
    hdl/DataFlowUnaryNAND.sv \
    hdl/DataFlowUnaryNOR.sv \
    hdl/DataFlowUnaryNXOR.sv \
    hdl/DataFlowUnaryOR.sv \
    hdl/DataFlowUnaryXNOR.sv \
    hdl/DataFlowUnaryXOR.sv \
    hdl/StructuralUnaryAND.sv \
    hdl/StructuralUnaryNAND.sv \
    hdl/StructuralUnaryNOR.sv \
    hdl/StructuralUnaryNXOR.sv \
    hdl/StructuralUnaryOR.sv \
    hdl/StructuralUnaryXNOR.sv \
    hdl/StructuralUnaryXOR.sv \
    hdl/UnaryAND.sv \
    hdl/UnaryNAND.sv \
    hdl/UnaryNOR.sv \
    hdl/UnaryNXOR.sv \
    hdl/UnaryOR.sv \
    hdl/UnaryXNOR.sv \
    hdl/UnaryXOR.sv

#----------------------------------------------------------------------------------------
# Specify Verilog Simulation Files
#----------------------------------------------------------------------------------------
export UNARY_VERILOG_HVL_FILES      := \
	hvl/Interface/src/UnaryInterface.sv \
	hvl/UnaryHDL_pkg.sv \
	hvl/Unary_tb.sv
