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
export SYNCHRONOUSSRAM_INC_CURRENT_MAKEFILE   := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export SYNCHRONOUSSRAM_INC_MAKEFILE_DIRECTORY := $(dir $(SYNCHRONOUSSRAM_INC_CURRENT_MAKEFILE))
export SYNCHRONOUSSRAM_HDL_DIRECTORY          := $(abspath $(SYNCHRONOUSSRAM_INC_MAKEFILE_DIRECTORY)/../hdl)
export SYNCHRONOUSSRAM_HVL_DIRECTORY          := $(abspath $(SYNCHRONOUSSRAM_INC_MAKEFILE_DIRECTORY)/../hvl)

export SYNCHRONOUSSRAM_TOPS                   := \
	MemorySimpleDualPort \
	MemoryTrueDualPort

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export SYNCHRONOUSSRAM_VERILOG_HDL_FILES := \
	$(SYNCHRONOUSSRAM_HDL_DIRECTORY)/MemorySimple.sv

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export SYNCHRONOUSSRAM_VERILOG_HVL_FILES :=

