

# XXX_VERILOG_HDL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_HVL_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export BASICCOMBINATIONALLOGIC_INC_CURRENT_MAKEFILE  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export BASICCOMBINATIONALLOGIC_INC_MAKEFILE_DIRECTORY:= $(dir $(BASICCOMBINATIONALLOGIC_INC_CURRENT_MAKEFILE))
export BASICCOMBINATIONALLOGIC_DIRECTORY             := $(abspath $(BASICCOMBINATIONALLOGIC_INC_MAKEFILE_DIRECTORY)/..)
export BASICCOMBINATIONALLOGIC_HDL_DIRECTORY	     := $(abspath $(BASICCOMBINATIONALLOGIC_DIRECTORY)/hdl)
export BASICCOMBINATIONALLOGIC_HVL_DIRECTORY	     := $(abspath $(BASICCOMBINATIONALLOGIC_DIRECTORY)/hvl)


include $(BASICCOMBINATIONALLOGIC_DIRECTORY)/units/BitWise/inc/BitWiseFilelist.mk
include $(BASICCOMBINATIONALLOGIC_DIRECTORY)/units/Logical/inc/LogicalFilelist.mk
include $(BASICCOMBINATIONALLOGIC_DIRECTORY)/units/Unary/inc/UnaryFilelist.mk

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export BASICCOMBINATIONALLOGIC_VERILOG_HDL_FILES := \
	$(BITWISE_VERILOG_HDL_FILES) \
	$(LOGICAL_VERILOG_HDL_FILES) \
	$(UNARY_VERILOG_HDL_FILES)
