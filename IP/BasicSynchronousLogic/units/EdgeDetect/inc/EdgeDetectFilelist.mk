
#---------------------------------------------------------------------------------------
# Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
#                  Creative Commons Attribution 4.0 International.
# Company:         It's All Digital To Me
# Engineer:        Kyle D. Gilsdorf
# Design Name:     BasicSynchronousLogic
# Unit Name:       EdgeDetect
# XXX_VERILOG_HDL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_HVL_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export EDGEDETECT_INC_CURRENT_MAKEFILE	  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export EDGEDETECT_INC_MAKEFILE_DIRECTORY  := $(dir $(EDGEDETECT_INC_CURRENT_MAKEFILE))
export EDGEDETECT_HDL_DIRECTORY           := $(abspath $(EDGEDETECT_INC_MAKEFILE_DIRECTORY)/../hdl)
export EDGEDETECT_HVL_DIRECTORY           := $(abspath $(EDGEDETECT_INC_MAKEFILE_DIRECTORY)/../hvl)


export EDGEDETECT_TOPS                   := \
	


#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export EDGEDETECT_VERILOG_HDL_FILES     := \
	$(EDGEDETECT_HDL_DIRECTORY)/BehavioralNegativeEdgeDetectDFF.sv \
	$(EDGEDETECT_HDL_DIRECTORY)/BehavioralPositiveEdgeDetectDFF.sv \
	$(EDGEDETECT_HDL_DIRECTORY)/NegativeEdgeDetect.sv \
	$(EDGEDETECT_HDL_DIRECTORY)/PositiveEdgeDetect.sv \
	$(EDGEDETECT_HDL_DIRECTORY)/StructuralNegativeEdgeDetectDFF.sv \
	$(EDGEDETECT_HDL_DIRECTORY)/StructuralPositiveEditDetectDFF.sv

export EDGEDETECT_VERILOG_HVL_FILES     :=
	

