#########################################################################################
# XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export FIFO_INC_CURRENT_MAKEFILE	  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export FIFO_INC_MAKEFILE_DIRECTORY := $(dir $(FIFO_INC_CURRENT_MAKEFILE))
export FIFO_INC_HDL_DIRECTORY      := $(abspath $(FIFO_INC_MAKEFILE_DIRECTORY)/../hdl)
export FIFO_INC_HVL_DIRECTORY      := $(abspath $(FIFO_INC_MAKEFILE_DIRECTORY)/../hvl)

export FIFO_TOPS                   := \
    SynchronousFIFO

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export FIFO_VERILOG_HDL_FILES := \
    ../../hdl/FIFOPointer.sv \
    ../../hdl/FIFOPointerCompare.sv \
    ../../../Memory/SynchronousSRAM/hdl/MemorySimple.sv \
    ../../../Synchronizer/hdl/xNStageSynchronizer.sv \
	hdl/SynchronousFIFO.sv

export FIFO_VERILOG_HVL_FILES := \
    hvl/Interface/src/SynchronousFIFOInterface.sv \
    hvl/SynchronousFIFO_pkg.sv \
    hvl/SynchronousFIFO_tb.sv
