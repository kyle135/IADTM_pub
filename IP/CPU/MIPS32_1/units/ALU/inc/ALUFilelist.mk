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
export ALU_INC_CURRENT_MAKEFILE	  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export ALU_INC_MAKEFILE_DIRECTORY := $(dir $(ALU_INC_CURRENT_MAKEFILE))
export ALU_HDL_DIRECTORY      := $(abspath $(ALU_INC_MAKEFILE_DIRECTORY)/../hdl)
export ALU_HVL_DIRECTORY      := $(abspath $(ALU_INC_MAKEFILE_DIRECTORY)/../hvl)
export ALU_IP_DIRECTORY       := $(abspath $(ALU_INC_MAKEFILE_DIRECTORY)../../../../../)

export ALU_MODELING               := \
    Behavioral \
	DataFlow \
	Structural

export ALU_TOPS                   := \
	ALU

export ALU_DPI_FILES              := \
	hvl/CModel/ALUCModel.c

include $(ALU_IP_DIRECTORY)/BasicCombinationalLogic/inc/BasicCombinationalLogicFilelist.mk
include $(ALU_IP_DIRECTORY)/FixedPointArithmetic/inc/FixedPointArithmeticFilelist.mk

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ALU_VERILOG_HDL_FILES := \
	../../hdl/MIPS32_1_hdl_pkg.sv \
	hdl/ALU_hdl_pkg.sv \
	$(BASICCOMBINATIONALLOGIC_VERILOG_HDL_FILES) \
	$(FIXEDPOINTARITHMETIC_VERILOG_HDL_FILES) \
	hdl/ALUAddSubtract.sv \
	hdl/ALUShift.sv \
	hdl/ALUMultiplyDivide.sv \
	hdl/ALULogical.sv \
	hdl/ALU.sv

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ALU_VERILOG_HVL_FILES := \
	hvl/ALU_hvl_pkg.sv \
	hvl/Interface/src/ALUInterface.sv \
	hvl/ALU_tb.sv
