
#---------------------------------------------------------------------------------------
# Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
#                  Creative Commons Attribution 4.0 International.
# Company:         It's All Digital To Me
# Engineer:        Kyle D. Gilsdorf
# Design Name:     BasicSynchronousLogic
# Unit Name:       TOGGLEDFF
# XXX_VERILOG_HDL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_HVL_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export TOGGLEDFF_INC_CURRENT_MAKEFILE	:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export TOGGLEDFF_INC_MAKEFILE_DIRECTORY := $(dir $(TOGGLEDFF_INC_CURRENT_MAKEFILE))
export TOGGLEDFF_HDL_DIRECTORY      := $(abspath $(TOGGLEDFF_INC_MAKEFILE_DIRECTORY)/../hdl)
export TOGGLEDFF_HVL_DIRECTORY      := $(abspath $(TOGGLEDFF_INC_MAKEFILE_DIRECTORY)/../hvl)
export TOGGLEDFF_IP_DIRECTORY           := $(TOGGLEDFF_INC_HDL_DIRECTORY)/../..

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export TOGGLEDFF_VERILOG_HDL_FILES     := \
	$(TOGGLEDFF_HDL_DIRECTORY)/BehavioralToggleDFF.sv \
	$(TOGGLEDFF_HDL_DIRECTORY)/StructuralToggleDFF.sv \
	$(TOGGLEDFF_HDL_DIRECTORY)/ToggleFlipFlop.sv

export TOGGLEDFF_VERILOG_HVL_FILES     :=
	

