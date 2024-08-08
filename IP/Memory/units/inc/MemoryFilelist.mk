# XXX_VERILOG_HDL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_HVL_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export MEMORY_INC_CURRENT_MAKEFILE  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export MEMORY_INC_MAKEFILE_DIRECTORY:= $(dir $(MEMORY_INC_CURRENT_MAKEFILE))
export MEMORY_DIRECTORY             := $(abspath $(MEMORY_INC_MAKEFILE_DIRECTORY)/..)
export MEMORY_HDL_DIRECTORY	        := $(abspath $(MEMORY_DIRECTORY)/hdl)
export MEMORY_HVL_DIRECTORY	        := $(abspath $(MEMORY_DIRECTORY)/hvl)

include $(MEMORY_DIRECTORY)/units/AsynchronousSRAM/inc/AsynchronousSRAMFilelist.mk
include $(MEMORY_DIRECTORY)/units/SynchronousSRAM/inc/SynchronousSRAMFilelist.mk.mk

export MEMORY_VERILOG_HDL_FILES := \
	$(ASYNCHRONOUSSRAM_VERILOG_HDL_FILES) \
	$(SYNCHRONOUSSRAM_VERILOG_HDL_FILES)

