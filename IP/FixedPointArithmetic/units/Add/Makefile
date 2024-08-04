#------------------------------------------------------------------------------
# Define System Variables
#------------------------------------------------------------------------------
SHELL							:= /bin/bash
WHOAMI							:= $(shell whoami)
HOST_TYPE						:= $(shell arch)
#------------------------------------------------------------------------------
# Find our top-level paths
#------------------------------------------------------------------------------
THIS_MAKEFILE           := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_MAKEFILE_DIRECTORY := $(dir $(THIS_MAKEFILE))
IP_DIRECTORY	        := $(abspath $(THIS_MAKEFILE_DIRECTORY)/../../..)
IP_NAME                 := FixedPointArithmetic
UNIT_NAME               := Add
UC_UNIT_NAME            := $(shell echo -n "$(UNIT_NAME)" | tr 'a-z' 'A-Z')
WORK_DIRECTORY          := $(IP_DIRECTORY)/$(IP_NAME)/units/$(UNIT_NAME)

include $(IP_DIRECTORY)/inc/Tools.mk
include $(WORK_DIRECTORY)/inc/$(UNIT_NAME)Filelist.mk

VERILOG_HDL_FILES       := $($(UC_UNIT_NAME)_VERILOG_HDL_FILES)
VERILOG_HVL_FILES       := $($(UC_UNIT_NAME)_VERILOG_HVL_FILES)

TOPS                    := $($(UC_UNIT_NAME)_TOPS)
MODELS                  := $($(UC_UNIT_NAME)_MODELS)
WIDTH                   := 32

display:
	@echo "[VLIB]           $(VLIB) $(VLIB_OPTS)"
	@echo "[VMAP]           $(VMAP) $(VMAP_OPTS)"
	@echo "[VLOG]           $(VLOG) $(VLOG_OPTS)"
	@echo "[VSIM]           $(VSIM) $(VSIM_OPTS)"
	@echo "[IP_NAME]        $(IP_NAME)"
	@echo "[UNIT_NAME]      $(UNIT_NAME)"
	@echo "[WORK_DIRECTORY] $(WORK_DIRECTORY)"
	@echo "[UC_UNIT_NAME]   $(UC_UNIT_NAME)"

#------------------------------------------------------------------------------
# Local Clean
#------------------------------------------------------------------------------
clean: display
	@rm -rf $(WORK_DIRECTORY)/$(UNIT_NAME)_work
	@find $(WORK_DIRECTORY)/. -name "*.log" -delete
	@find $(WORK_DIRECTORY)/. -name "*.wlf" -delete
	@find $(WORK_DIRECTORY)/. -name "transcript" -delete
	@find $(WORK_DIRECTORY)/. -name "modelsim.ini" -delete

#------------------------------------------------------------------------------
# Generate working library
#------------------------------------------------------------------------------
create_work_library: clean
	$(VLIB) \
		$(UNIT_NAME)_work  > $(UNIT_NAME)_vlib.log
#------------------------------------------------------------------------------
# Generate working library
#------------------------------------------------------------------------------
map_libraries: create_work_library
	$(VMAP) work $(UNIT_NAME)_work > $(UNIT_NAME)_vmap.log
#------------------------------------------------------------------------------
# Compile Design Collateral
#------------------------------------------------------------------------------
compile_c_model_for_simulation: map_libraries
#------------------------------------------------------------------------------
# Compile Design Collateral
#------------------------------------------------------------------------------
compile_rtl_for_simulation: compile_c_model_for_simulation
	$(info [$(UC_UNIT_NAME)_VERILOG_HDL_FILES] $(VERILOG_HDL_FILES))
	$(VLOG) -work $(UNIT_NAME)_work $(VERILOG_HDL_FILES) > $(UNIT_NAME)_vlog_hdl.log
	$(info [$(UC_UNIT_NAME)_VERILOG_HVL_FILES] $(VERILOG_HVL_FILES))
	$(VLOG) -work $(UNIT_NAME)_work $(VERILOG_HVL_FILES) > $(UNIT_NAME)_vlog_hvl.log
#----------------------------------------------------------------------------------------------------------------------
# Optimize Design (for simulation speed-up)
#------------------------------------------------------------------------------
optimize_simulation_model: compile_rtl_for_simulation
	$(VOPT) \
		$(UNIT_NAME)_tb \
		-o opt_$(UNIT_NAME)_tb > $(UNIT_NAME)_vopt.log
#------------------------------------------------------------------------------
# Simulate Design (Command Line)
#------------------------------------------------------------------------------
command_line_simulation: optimize_simulation_model
	$(foreach top, $(TOPS), \
		$(foreach model, $(MODELS), \
			$(VSIM) \
				-work $(UNIT_NAME)_work \
				+UVM_VERBOSITY=UVM_LOW \
				-gTOP="$(top)" \
				-gMODEL="$(model)" \
				-gN=$(WIDTH) \
				-c \
				-title "$(UNIT_NAME)$(model)$(top)x$(WIDTH)" \
				-do "quietly set StdArithNoWarnings 1; log -recursive /* -optcells; run -all;" \
				$(UNIT_NAME)_tb \
				> $(UNIT_NAME)$(model)$(top)x$(WIDTH)_vsim.log; \
		) \
	)

#------------------------------------------------------------------------------
# 
#------------------------------------------------------------------------------
gui_simulation: optimize_simulation_model
	$(VSIM) \
		-work $(UNIT_NAME)_work \
		+UVM_TESTNAME=AddTest \
		+UVM_VERBOSITY=UVM_MEDIUM \
		-gDUT=$(UNIT_NAME) \
		-gTOP=$(TOP) \
		-gMODEL=$(MODEL) \
		-gN=$(WIDTH) \
		-title "$(UNIT_NAME)" \
		-do "log -r /*; run -all;" \
		-voptargs=+acc \
		-t ns \
		$(UNIT_NAME)_tb \
		> $(UNIT_NAME)_vsim.log;
