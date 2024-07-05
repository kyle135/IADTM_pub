#---------------------------------------------------------------------------------------
# Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
#                  Creative Commons Attribution 4.0 International 
#
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
export APBSLAVEMEMORY_INC_CURRENT_MAKEFILE	 := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export APBSLAVEMEMORY_INC_MAKEFILE_DIRECTORY := $(dir $(APBSLAVEMEMORY_INC_CURRENT_MAKEFILE))
export APBSLAVEMEMORY_HDL_DIRECTORY          := $(abspath $(APBSLAVEMEMORY_INC_MAKEFILE_DIRECTORY)/../hdl)
export APBSLAVEMEMORY_HVL_DIRECTORY          := $(abspath $(APBSLAVEMEMORY_INC_MAKEFILE_DIRECTORY)/../hvl)


export APBSLAVEMEMORYTOPS                   := \
	APBSlaveMemory

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export APBSLAVEMEMORYVERILOG_HDL_FILES     := \
	../../../../IP/Memory/units/SynchronousSRAM/hdl/MemorySimple.sv \
	$(APBSLAVEMEMORY_HDL_DIRECTORY)/../../../hdl/APB_hdl_pkg.sv \
	$(APBSLAVEMEMORY_HDL_DIRECTORY)/APBSlaveMemory.sv

export APBSLAVEMEMORYVERILOG_HVL_FILES     := \
	$(APBSLAVEMEMORY_HVL_DIRECTORY)/../../../hvl/APB_hvl_pkg.sv \
	$(APBSLAVEMEMORY_HVL_DIRECTORY)/../../../hvl/Interface/src/APBInterface.sv \
	$(APBSLAVEMEMORY_HDL_DIRECTORY)/APBSlaveMemory_hdl_top.sv \
	$(APBSLAVEMEMORY_HVL_DIRECTORY)/APBSlaveMemory_hvl_top.sv
