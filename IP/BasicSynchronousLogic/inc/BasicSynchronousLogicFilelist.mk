
#---------------------------------------------------------------------------------------
# Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
#                  Creative Commons Attribution 4.0 International.
# Company:         It's All Digital To Me
# Engineer:        Kyle D. Gilsdorf
# Design Name:     Basic Synchronous Logic
#
# XXX_VERILOG_HDL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_HVL_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export BASICSYNCHRONOUSLOGIC_INC_CURRENT_MAKEFILE	:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export BASICSYNCHRONOUSLOGIC_INC_MAKEFILE_DIRECTORY := $(dir $(BASICSYNCHRONOUSLOGIC_INC_CURRENT_MAKEFILE))
export BASICSYNCHRONOUSLOGIC_INC_HDL_DIRECTORY      := $(abspath $(BASICSYNCHRONOUSLOGIC_INC_MAKEFILE_DIRECTORY)/../hdl)
export BASICSYNCHRONOUSLOGIC_INC_HVL_DIRECTORY      := $(abspath $(BASICSYNCHRONOUSLOGIC_INC_MAKEFILE_DIRECTORY)/../hvl)

include IP/BasicSynchronousLogic/units/DFF/inc/DFFFilelist.mk
# include IP/BasicSynchronousLogic/units/Counters/inc/CountersFilelist.mk
# include IP/BasicSynchronousLogic/units/EdgeDetect/inc/EdgeDetectFilelist.mk
# include IP/BasicSynchronousLogic/units/ToggleDFF/inc/ToggleDFFFilelist.mk

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export BASICSYNCHRONOUSLOGIC_VERILOG_HDL_FILES     := \
	$(DFF_VERILOG_HDL_FILES)

# $(COUNTERS_VERILOG_HDL_FILES) \
# $(EDGEDETECT_VERILOG_HDL_FILES) \
# $(TOGGLE_VERILOG_HDL_FILES)

export BASICSYNCHRONOUSLOGIC_VERILOG_HVL_FILES     := \
	$(DFF_VERILOG_HVL_FILES) \
	$(COUNTERS_VERILOG_HVL_FILES) \
	$(EDGEDETECT_VERILOG_HVL_FILES) \
	$(TOGGLE_VERILOG_HVL_FILES)
