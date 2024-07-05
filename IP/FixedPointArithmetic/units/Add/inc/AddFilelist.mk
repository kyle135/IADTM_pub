#########################################################################################
# XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export ADD_INC_CURRENT_MAKEFILE   := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export ADD_INC_MAKEFILE_DIRECTORY := $(dir $(ADD_INC_CURRENT_MAKEFILE))
export ADD_INC_HDL_DIRECTORY	  := $(abspath $(ADD_INC_MAKEFILE_DIRECTORY)/../hdl)
export ADD_INC_HVL_DIRECTORY	  := $(abspath $(ADD_INC_MAKEFILE_DIRECTORY)/../hvl)

export ADD_MODELS                 := \
    Behvioral \
    DataFlow \
    Structural

export ADD_TOPS                   := \
	Add

export ADD_ALGORITHMS             := \
    RippleCarry \
    CarryLookAhead \
    CarrySave \
    CarrySelect

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ADD_VERILOG_HDL_FILES      := \
    hdl/BehavioralAddRippleCarry.sv \
    hdl/DataFlowAddRippleCarry.sv \
    hdl/StructuralAddRippleCarry.sv \
    hdl/AddRippleCarry.sv \
    hdl/AddCarryLookAhead.sv \
    hdl/AddCarrySave.sv \
    hdl/AddCarrySelect.sv \
    hdl/Add.sv

#----------------------------------------------------------------------------------------
# Specify Verilog Simulation Files
#----------------------------------------------------------------------------------------
export ADD_VERILOG_HVL_FILES      := \
	hvl/Interface/src/AddInterface.sv \
	hvl/AddHDL_pkg.sv \
	hvl/Add_tb.sv
