
#---------------------------------------------------------------------------------------
# Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
#                  Creative Commons Attribution 4.0 International.
# Company:         It's All Digital To Me
# Engineer:        Kyle D. Gilsdorf
# Module Name:     APBSlaveMemoryFilelist.mk
# Description:     
# XXX_VERILOG_HDL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_HVL_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export APB_INC_CURRENT_MAKEFILE	  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export APB_INC_MAKEFILE_DIRECTORY := $(dir $(APB_INC_CURRENT_MAKEFILE))
export APB_INC_HDL_DIRECTORY      := $(abspath $(APB_INC_MAKEFILE_DIRECTORY)/../hdl)
export APB_INC_HVL_DIRECTORY      := $(abspath $(APB_INC_MAKEFILE_DIRECTORY)/../hvl)


export APB_TOPS                   := \
	APB


#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export APB_VERILOG_HDL_FILES     :=



export APB_VERILOG_HVL_FILES     := \
	hvl/Interface/src/APBInterface.sv
	

