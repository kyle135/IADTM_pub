#------------------------------------------------------------------------------
# Licensing:  It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
# 			  under Creative Commons Attribution 4.0 International.
# Company:    It's All Digital To Me
# Engineer:   Kyle D. Gilsdorf
#
#
#----------------------------------------------------------------------------
#  ___                      _ _         _      
# |_ _|_ _  __ _ _ _ ___ __| (_)___ _ _| |_ ___
#  | || ' \/ _` | '_/ -_) _` | / -_) ' \  _(_-<
# |___|_||_\__, |_| \___\__,_|_\___|_||_\__/__/
#          |___/       
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Define System Variables
#------------------------------------------------------------------------------
SHELL					:= /bin/bash
WHOAMI					:= $(shell whoami)
HOST_TYPE				:= $(shell arch)
#------------------------------------------------------------------------------
# Find our top-level paths
#------------------------------------------------------------------------------
THIS_MAKEFILE           := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_MAKEFILE_DIRECTORY := $(dir $(THIS_MAKEFILE))
IP_DIRECTORY	        := $(abspath $(THIS_MAKEFILE_DIRECTORY)/..)
IP_NAME                 := BasicSynchronousLogic
WORK_DIRECTORY          := $(IP_DIRECTORY)/$(IP_NAME)

include $(IP_DIRECTORY)/inc/Tools.mk
include $(WORK_DIRECTORY)/inc/$(IP_NAME)Filelist.mk

VERILOG_HDL_FILES       := $(BASICSYNCHRONOUSLOGIC_VERILOG_HDL_FILES)
VERILOG_HVL_FILES       := $(BASICSYNCHRONOUSLOGIC_VERILOG_HVL_FILES)

#------------------------------------------------------------------------------
#  ___        _              
# | _ \___ __(_)_ __  ___ ___
# |   / -_) _| | '_ \/ -_|_-<
# |_|_\___\__|_| .__/\___/__/
#              |_|           
#------------------------------------------------------------------------------
display:
	@echo "[VLIB]              $(VLIB) $(VLIB_OPTS)"
	@echo "[VMAP]              $(VMAP) $(VMAP_OPTS)"
	@echo "[VLOG]              $(VLOG) $(VLOG_OPTS)"
	@echo "[VSIM]              $(VSIM) $(VSIM_OPTS)"
	@echo "[IP_DIRECTORY]      $(IP_DIRECTORY)"
	@echo "[IP_NAME]           $(IP_NAME)"
	@echo "[UNIT_NAME]         $(UNIT_NAME)"
	@echo "[WORK_DIRECTORY]    $(WORK_DIRECTORY)"
	@echo "[VERILOG_HDL_FILES] $(VERILOG_HDL_FILES)"
	@echo "[VERILOG_HVL_FILES] $(VERILOG_HVL_FILES)"

#------------------------------------------------------------------------------
# Local Clean
#------------------------------------------------------------------------------
clean: display
	@rm -rf $(WORK_DIRECTORY)/$(IP_NAME)_work
	@find $(WORK_DIRECTORY)/. -name "*.log" -delete
	@find $(WORK_DIRECTORY)/. -name "*.wlf" -delete
	@find $(WORK_DIRECTORY)/. -name "transcript" -delete
	@find $(WORK_DIRECTORY)/. -name "modelsim.ini" -delete
	@find $(WORK_DIRECTORY)/. -name "*.o" -delete
	@find $(WORK_DIRECTORY)/. -name "*.so" -delete

#------------------------------------------------------------------------------
# Generate working library
#------------------------------------------------------------------------------
create_work_library: clean
	$(VLIB) \
		$(IP_NAME)_work  > $(IP_NAME)_vlib.log
#------------------------------------------------------------------------------
# Generate working library
#------------------------------------------------------------------------------
map_libraries: create_work_library
	$(VMAP) work $(IP_NAME)_work > $(IP_NAME)_vmap.log
#------------------------------------------------------------------------------
# Compile Design Collateral
#------------------------------------------------------------------------------
compile_c_model_for_simulation: map_libraries

#------------------------------------------------------------------------------
# Compile Design Collateral
#------------------------------------------------------------------------------
compile_rtl_for_simulation: compile_c_model_for_simulation
ifneq ($(strip $(VERILOG_HDL_FILES)),)
	@$(info [$(IP_NAME)_VERILOG_HDL_FILES] $(VERILOG_HDL_FILES))
	@$(VLOG) -work $(IP_NAME)_work $(VERILOG_HDL_FILES) > $(IP_NAME)_vlog_hdl.log
endif
ifneq ($(strip $(VERILOG_HVL_FILES)),)
	@$(info [$(IP_NAME)_VERILOG_HVL_FILES] $(VERILOG_HVL_FILES))
	@$(VLOG) -work $(IP_NAME)_work $(VERILOG_HVL_FILES) > $(IP_NAME)_vlog_hvl.log
endif
