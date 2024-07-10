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
# Locate our damn selves.
#------------------------------------------------------------------------------
export FIFO_INC_CURRENT_MAKEFILE   := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export FIFO_INC_MAKEFILE_DIRECTORY := $(dir $(FIFO_INC_CURRENT_MAKEFILE))
export FIFO_INC_HDL_DIRECTORY      := $(abspath $(FIFO_INC_MAKEFILE_DIRECTORY)/../hdl)
export FIFO_INC_HVL_DIRECTORY      := $(abspath $(FIFO_INC_MAKEFILE_DIRECTORY)/../hvl)

export FIFO_MODELING               := \
    Behavioral \
	DataFlow \
	Structural

export FIFO_TOPS                   := \
	AsynchronousFIFO \
    SynchronousFIFO



#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export FIFO_VERILOG_HDL_FILES := \
    hdl/FIFOPointer.sv \
    hdl/FIFOCompare.sv \
    ../Synchronizer/hdl/xNStageSynchronizer.sv \
    units/AsynchronousFIFO/hdl/AsynchronousFIFO.sv \
	units/SynchronousFIFO/hdl/SynchronousFIFO.sv

