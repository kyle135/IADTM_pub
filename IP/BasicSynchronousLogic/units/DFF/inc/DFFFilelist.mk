
#---------------------------------------------------------------------------------------
# Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
#                  Creative Commons Attribution 4.0 International.
# Company:         It's All Digital To Me
# Engineer:        Kyle D. Gilsdorf
# Design Name:     Basic Synchronous Logic
# Unit Name:       DFF
#
# XXX_VERILOG_HDL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_HVL_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export DFF_INC_CURRENT_MAKEFILE	  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export DFF_INC_MAKEFILE_DIRECTORY := $(dir $(DFF_INC_CURRENT_MAKEFILE))
export DFF_HDL_DIRECTORY      := $(abspath $(DFF_INC_MAKEFILE_DIRECTORY)/../hdl)
export DFF_HVL_DIRECTORY      := $(abspath $(DFF_INC_MAKEFILE_DIRECTORY)/../hvl)

export DFF_TOPS                   := \
	DFF

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export DFF_VERILOG_HDL_FILES     := \
	$(DFF_HDL_DIRECTORY)/BehavioralDFF.sv \
	$(DFF_HDL_DIRECTORY)/StructuralDFF.sv \
	$(DFF_HDL_DIRECTORY)/DFF.sv


export DFF_VERILOG_HVL_FILES     :=



