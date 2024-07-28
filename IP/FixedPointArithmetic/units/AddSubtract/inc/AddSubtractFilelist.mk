#########################################################################################
# XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export ADDSUBTRACTINC_CURRENT_MAKEFILE   := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export ADDSUBTRACTINC_MAKEFILE_DIRECTORY := $(dir $(ADDSUBTRACTINC_CURRENT_MAKEFILE))
export ADDSUBTRACT_DIRECTORY             := $(abspath $(ADDSUBTRACTINC_MAKEFILE_DIRECTORY)/..)
export ADDSUBTRACT_HDL_DIRECTORY	     := $(abspath $(ADDSUBTRACT_DIRECTORY)/hdl)
export ADDSUBTRACT_HVL_DIRECTORY	     := $(abspath $(ADDSUBTRACT_DIRECTORY)/hvl)

export ADDSUBTRACT_MODELS                := \
    Structural

# Behvioral \
# DataFlow \

export ADDSUBTRACT_TOPS                := \
    RippleCarryAddSubtract \
    CarryLookAheadAddSubtract \
    BlockCarryLookAheadAddSubtract \
    CarrySkipAddSubtract \
    CarrySelectAddSubtract

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ADDSUBTRACT_VERILOG_HDL_FILES      := \
	$(ADDSUBTRACT_HDL_DIRECTORY)/StructuralHalfAdder.sv \
	$(ADDSUBTRACT_HDL_DIRECTORY)/StructuralFullAdder.sv \
	$(ADDSUBTRACT_HDL_DIRECTORY)/StructuralRippleCarryAdder.sv \
	$(ADDSUBTRACT_HDL_DIRECTORY)/StructuralReducedFullAdder.sv \
	$(ADDSUBTRACT_HDL_DIRECTORY)/StructuralCarryLookAheadGenerator.sv \
	$(ADDSUBTRACT_HDL_DIRECTORY)/StructuralCarryLookAheadAddSubtract.sv \
    $(ADDSUBTRACT_HDL_DIRECTORY)/StructuralBlockCarryLookAheadAddSubtract.sv \
    $(ADDSUBTRACT_HDL_DIRECTORY)/StructuralCarrySkipAddSubtract.sv \
    $(ADDSUBTRACT_HDL_DIRECTORY)/StructuralCarrySelectAddSubtract.sv \
    $(ADDSUBTRACT_HDL_DIRECTORY)/RippleCarryAddSubtract.sv \
    $(ADDSUBTRACT_HDL_DIRECTORY)/CarryLookAheadAddSubtract.sv \
	$(ADDSUBTRACT_HDL_DIRECTORY)/BlockCarryLookAheadAddSubtract.sv \
    $(ADDSUBTRACT_HDL_DIRECTORY)/CarrySkipAddSubtract.sv \
    $(ADDSUBTRACT_HDL_DIRECTORY)/CarrySelectAddSubtract.sv

#----------------------------------------------------------------------------------------
# Specify Verilog Simulation Files
#----------------------------------------------------------------------------------------
export ADDSUBTRACT_VERILOG_HVL_FILES      := \
	$(ADDSUBTRACT_HDL_DIRECTORY)/Interface/src/AddSubtractInterface.sv \
	$(ADDSUBTRACT_HDL_DIRECTORY)/AddSubtractHDL_pkg.sv \
	$(ADDSUBTRACT_HDL_DIRECTORY)/AddSubtract_tb.sv
