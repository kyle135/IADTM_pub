
#---------------------------------------------------------------------------------------
# Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
#                  Creative Commons Attribution 4.0 International.
# Company:         It's All Digital To Me
# Engineer:        Kyle D. Gilsdorf
# Design Name:     BasicSynchronousLogic
# Unit Name:       Counters
#
# Description:     
# XXX_VERILOG_HDL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_HVL_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export COUNTERS_INC_CURRENT_MAKEFILE   := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export COUNTERS_INC_MAKEFILE_DIRECTORY := $(dir $(COUNTERS_INC_CURRENT_MAKEFILE))
export COUNTERS_HDL_DIRECTORY          := $(abspath $(COUNTERS_INC_MAKEFILE_DIRECTORY)/../hdl)
export COUNTERS_HVL_DIRECTORY          := $(abspath $(COUNTERS_INC_MAKEFILE_DIRECTORY)/../hvl)

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export COUNTERS_VERILOG_HDL_FILES     := \
	$(COUNTERS_HDL_DIRECTORY)/BinaryBehavioralCounter.sv \
	$(COUNTERS_HDL_DIRECTORY)/BinaryStructuralCounter.sv \
	$(COUNTERS_HDL_DIRECTORY)/BinaryCounter.sv \
	$(COUNTERS_HDL_DIRECTORY)/GrayCodeCounter.sv

export COUNTERS_VERILOG_HVL_FILES     :=
