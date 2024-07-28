#########################################################################################
# XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export ADDINC_CURRENT_MAKEFILE   := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export ADDINC_MAKEFILE_DIRECTORY := $(dir $(ADDINC_CURRENT_MAKEFILE))
export ADD_DIRECTORY             := $(abspath $(ADDINC_MAKEFILE_DIRECTORY)/..)
export ADD_HDL_DIRECTORY	     := $(abspath $(ADD_DIRECTORY)/hdl)
export ADD_HVL_DIRECTORY	     := $(abspath $(ADD_DIRECTORY)/hvl)

export ADD_MODELS                := \
    Behvioral \
    DataFlow \
    Structural

export ADD_TOPS                  := \
    RippleCarryAdd \
    CarryLookAheadAdd \
    BlockCarryLookAhead \
    CarrySkipAdd \
    CarrySaveAdd \
    CarrySelectAdd

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ADD_VERILOG_HDL_FILES      := \
	$(ADD_HDL_DIRECTORY)/BehavioralHalfAdd.sv \
	$(ADD_HDL_DIRECTORY)/BehavioralFullAdd.sv \
	$(ADD_HDL_DIRECTORY)/BehavioralRippleCarryAdd.sv \
	$(ADD_HDL_DIRECTORY)/BehavioralReducedFullAdd.sv \
	$(ADD_HDL_DIRECTORY)/BehavioralCarryLookAheadGenerator.sv \
	$(ADD_HDL_DIRECTORY)/BehavioralCarryLookAheadAdd.sv \
    $(ADD_HDL_DIRECTORY)/BehavioralBlockCarryLookAheadAdd.sv \
    $(ADD_HDL_DIRECTORY)/BehavioralCarrySkipAdd.sv \
    $(ADD_HDL_DIRECTORY)/BehavioralCarrySaveAdd.sv \
    $(ADD_HDL_DIRECTORY)/BehavioralCarrySelectAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowHalfAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowFullAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowRippleCarryAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowReducedFullAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowCarryLookAheadGenerator.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowCarryLookAheadAdd.sv \
    $(ADD_HDL_DIRECTORY)/DataFlowBlockCarryLookAheadAdd.sv \
    $(ADD_HDL_DIRECTORY)/DataFlowCarrySkipAdd.sv \
    $(ADD_HDL_DIRECTORY)/DataFlowCarrySaveAdd.sv \
    $(ADD_HDL_DIRECTORY)/DataFlowCarrySelectAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowHalfAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowFullAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowRippleCarryAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowReducedFullAdd.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowCarryLookAheadGenerator.sv \
	$(ADD_HDL_DIRECTORY)/DataFlowCarryLookAheadAdd.sv \
    $(ADD_HDL_DIRECTORY)/DataFlowBlockCarryLookAheadAdd.sv \
    $(ADD_HDL_DIRECTORY)/DataFlowCarrySkipAdd.sv \
    $(ADD_HDL_DIRECTORY)/DataFlowCarrySaveAdd.sv \
    $(ADD_HDL_DIRECTORY)/DataFlowCarrySelectAdd.sv \
    $(ADD_HDL_DIRECTORY)/RippleCarryAdd.sv \
    $(ADD_HDL_DIRECTORY)/CarryLookAheadAdd.sv \
	$(ADD_HDL_DIRECTORY)/BlockCarryLookAheadAdd.sv \
    $(ADD_HDL_DIRECTORY)/CarrySkipAdd.sv \
    $(ADD_HDL_DIRECTORY)/CarrySaveAdd.sv \
    $(ADD_HDL_DIRECTORY)/CarrySelectAdd.sv

#----------------------------------------------------------------------------------------
# Specify Verilog Simulation Files
#----------------------------------------------------------------------------------------
export ADD_VERILOG_HVL_FILES      := \
	$(ADD_HDL_DIRECTORY)/Interface/src/AddInterface.sv \
	$(ADD_HDL_DIRECTORY)/AddHDL_pkg.sv \
	$(ADD_HDL_DIRECTORY)/Add_tb.sv
