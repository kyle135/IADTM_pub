#------------------------------------------------------------------------------
# Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
#               under Creative Commons Attribution 4.0 International.
# Company:      It's All Digital To Me
# Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
# Description:
# - XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# - XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# - XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#------------------------------------------------------------------------------
#-----------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export ASYNCHRONOUSSRAM_INC_CURRENT_MAKEFILE    := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export ASYNCHRONOUSSRAM_INC_MAKEFILE_DIRECTORY := $(dir $(ASYNCHRONOUSSRAM_INC_CURRENT_MAKEFILE))
export ASYNCHRONOUSSRAM_HDL_DIRECTORY          := $(abspath $(ASYNCHRONOUSSRAM_INC_MAKEFILE_DIRECTORY)/../hdl)
export ASYNCHRONOUSSRAM_HVL_DIRECTORY          := $(abspath $(ASYNCHRONOUSSRAM_INC_MAKEFILE_DIRECTORY)/../hvl)

export ASYNCHRONOUSSRAM_TOPS                   := \
	MemorySimpleDualPort \
	MemoryTrueDualPort

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ASYNCHRONOUSSRAM_VERILOG_HDL_FILES := \
	$(ASYNCHRONOUSSRAM_HDL_DIRECTORY)/MemorySimpleDualPort.sv \
	$(ASYNCHRONOUSSRAM_HDL_DIRECTORY)/MemoryTrueDualPort.sv

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ASYNCHRONOUSSRAM_VERILOG_HVL_FILES :=

