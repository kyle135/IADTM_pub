#------------------------------------------------------------------------------
# Licensing:    It's All Digital To Me (c) 2018 by Kyle D. Gilsdorf is licensed
#               under Creative Commons Attribution 4.0 International.
# Company:      It's All Digital To Me
# Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
# Description:
# - XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# - XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# - XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#------------------------------------------------------------------------------
# Locate our damn selves.
#------------------------------------------------------------------------------
export FIXEDPOINTARITHMETIC_INC_CURRENT_MAKEFILE	:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export FIXEDPOINTARITHMETIC_INC_MAKEFILE_DIRECTORY	:= $(dir $(FIXEDPOINTARITHMETIC_INC_CURRENT_MAKEFILE))
export FIXEDPOINTARITHMETIC_HDL_DIRECTORY			:= $(abspath $(FIXEDPOINTARITHMETIC_INC_MAKEFILE_DIRECTORY)/../hdl)
export FIXEDPOINTARITHMETIC_HVL_DIRECTORY			:= $(abspath $(FIXEDPOINTARITHMETIC_INC_MAKEFILE_DIRECTORY)/../hvl)

export FIXEDPOINTARITHMETIC_TOPS					:= \
	FixedPointSubtract

#------------------------------------------------------------------------------
# Specify Verilog RTL Files
#------------------------------------------------------------------------------
export FIXEDPOINTARITHMETIC_VERILOG_HDL_FILES		:= \
	$(FIXEDPOINTARITHMETIC_HDL_DIRECTORY)/FixedPointAdd.sv \
	$(FIXEDPOINTARITHMETIC_HDL_DIRECTORY)/FixedPointCompare.sv \
	$(FIXEDPOINTARITHMETIC_HDL_DIRECTORY)/FixedPointDivide.sv \
	$(FIXEDPOINTARITHMETIC_HDL_DIRECTORY)/FixedPointMultiply.sv \
	$(FIXEDPOINTARITHMETIC_HDL_DIRECTORY)/FixedPointArithmeticShift.sv \
	$(FIXEDPOINTARITHMETIC_HDL_DIRECTORY)/FixedPointSubtract.sv \
	$(FIXEDPOINTARITHMETIC_HDL_DIRECTORY)/FixedPointCountLeadingOnes.sv \
	$(FIXEDPOINTARITHMETIC_HDL_DIRECTORY)/FixedPointCountLeadingZeros.sv
#------------------------------------------------------------------------------
# Specify Verilog RTL Files
#------------------------------------------------------------------------------
export FIXEDPOINTARITHMETIC_VERILOG_HVL_FILES := \
	$(FIXEDPOINTARITHMETIC_HVL_DIRECTORY)/FixedPointSubtract_tb.sv
