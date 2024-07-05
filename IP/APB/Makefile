#---------------------------------------------------------------------------------------
# Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
#                  Creative Commons Attribution 4.0 International 
#
# Company:         It's All Digital To Me
# Engineer:        Kyle D. Gilsdorf
# Module Name:     APBSlaveMemoryFilelist.mk
# Description:     
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
IP_NAME                 := APB
WORK_DIRECTORY          := $(IP_DIRECTORY)/$(IP_NAME)

include $(IP_DIRECTORY)/inc/Tools.mk
include $(WORK_DIRECTORY)/inc/$(IP_NAME)Filelist.mk

VERILOG_HDL_FILES       := $(APB_VERILOG_HDL_FILES)
VERILOG_HVL_FILES       := $(APB_VERILOG_HVL_FILES)
MODELS                  := $(APB_MODELS)
TOPS                    := $(APB_TOPS)
WIDTH                   := 32
ALGORITHMS              := $(APB_ALGORITHMS)

display:
	@echo "[VLIB]           $(VLIB) $(VLIB_OPTS)"
	@echo "[VMAP]           $(VMAP) $(VMAP_OPTS)"
	@echo "[VLOG]           $(VLOG) $(VLOG_OPTS)"
	@echo "[VSIM]           $(VSIM) $(VSIM_OPTS)"
	@echo "[IP_DIRECTORY]	$(IP_DIRECTORY)"
	@echo "[IP_NAME]        $(IP_NAME)"
	@echo "[UNIT_NAME]      $(UNIT_NAME)"
	@echo "[WORK_DIRECTORY] $(WORK_DIRECTORY)"

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
#----------------------------------------------------------------------------------------------------------------------
# Optimize Design (for simulation speed-up)
#------------------------------------------------------------------------------
optimize_simulation_model: compile_rtl_for_simulation
	$(VOPT) \
		$(IP_NAME)_tb \
		-o opt_$(IP_NAME)_tb > $(IP_NAME)_vopt.log
#------------------------------------------------------------------------------
# Simulate Design (Command Line)
#------------------------------------------------------------------------------
command_line_simulation: optimize_simulation_model
	$(VSIM) \
		-work $(IP_NAME)_work \
		+UVM_TESTNAME=APBTest \
		+UVM_VERBOSITY=UVM_HIGH \
		-gN=32 \
		-gA=32 \
		-c \
		-title "$(IP_NAME)" \
		-do "run -all;" \
		-voptargs=+acc \
		-t ns \
		$(IP_NAME)_tb \
		| tee $(IP_NAME)_vsim.log;
#------------------------------------------------------------------------------
# Simulate Design (Command Line)
#------------------------------------------------------------------------------
gui_simulation: optimize_simulation_model
	$(VSIM) \
		-work $(UNIT_NAME)_work \
		+UVM_TESTNAME=APBTest \
		+UVM_VERBOSITY=UVM_HIGH \
		-gN=32 \
		-gA=32
		-title "$(IP_NAME)" \
		-do "log -r /*; run -all;" \
		-voptargs=+acc \
		-t ns \
		$(IP_NAME)_tb \
		> $(IP_NAME)_vsim.log;
#--------------------------------------------------------------------------------------------------
# Synthesize
#--------------------------------------------------------------------------------------------------
synthesize_design: clean


