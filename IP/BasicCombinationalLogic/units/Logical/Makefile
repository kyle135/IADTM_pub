#------------------------------------------------------------------------------
# Licensing:     It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed
#                licensed under Creative Commons Attribution 4.0 International
# Company:       It's All Digital To Me
# Engineer:      Kyle D. Gilsdorf
# Module Name:   Logical Makefile
# Description:   Makefile for simulation, synthesizing etc...
#------------------------------------------------------------------------------
# Define System Variables
#------------------------------------------------------------------------------
SHELL                   := /bin/bash
WHOAMI                  := $(shell whoami)
HOST_TYPE               := $(shell arch)
#------------------------------------------------------------------------------
# Find our top-level paths
#------------------------------------------------------------------------------
THIS_MAKEFILE           := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_MAKEFILE_DIRECTORY := $(dir $(THIS_MAKEFILE))
IP_DIRECTORY            := $(abspath $(THIS_MAKEFILE_DIRECTORY)/../../..)
IP_NAME                 := BasicCombinationalLogic
UNIT_NAME               := Logical
WORK_DIRECTORY          := $(IP_DIRECTORY)/$(IP_NAME)/units/$(UNIT_NAME)

include $(IP_DIRECTORY)/inc/Tools.mk
include $(WORK_DIRECTORY)/inc/$(UNIT_NAME)Filelist.mk

VERILOG_HDL_FILES       := $(LOGICAL_VERILOG_HDL_FILES)
VERILOG_HVL_FILES       := $(LOGICAL_VERILOG_HVL_FILES)
MODELING                := $(LOGICAL_MODELING)
TOPS                    := $(LOGICAL_TOPS)
WIDTH                   := 32

display:
	@echo "[VLIB] $(VLIB) $(VLIB_OPTS)"
	@echo "[VMAP] $(VMAP) $(VMAP_OPTS)"
	@echo "[VLOG] $(VLOG) $(VLOG_OPTS)"
	@echo "[VSIM] $(VSIM) $(VSIM_OPTS)"

#------------------------------------------------------------------------------
# Local Clean
#------------------------------------------------------------------------------
clean: display
	@rm -rf $(WORK_DIRECTORY)/$(UNIT_NAME)_work
	@find $(WORK_DIRECTORY)/. -name "*.log" -delete
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
	$(info [$(UNIT)_VERILOG_HDL_FILES] $(VERILOG_HDL_FILES))
	$(VLOG) -work $(UNIT_NAME)_work $(VERILOG_HDL_FILES) > $(UNIT_NAME)_vlog_hdl.log
	$(info [$(UNIT)_VERILOG_HVL_FILES] $(VERILOG_HVL_FILES))
	$(VLOG) -work $(UNIT_NAME)_work $(VERILOG_HVL_FILES) > $(UNIT_NAME)_vlog_hvl.log
#------------------------------------------------------------------------------
# Optimize Design (for simulation speed-up)
#------------------------------------------------------------------------------
optimize_simulation_model: compile_rtl_for_simulation
	$(VOPT) \
		$(UNIT_NAME)_tb \
		-o opt_$(UNIT_NAME)_tb > $(UNIT_NAME)_vopt.log
#----------------------------------------------------------------------------------------------------------------------
# Simulate Design (Command Line)
#----------------------------------------------------------------------------------------------------------------------
command_line_simulation: optimize_simulation_model
	$(foreach top, $(TOPS), \
		$(foreach model, $(MODELING), \
			$(VSIM) $(VSIM_OPTS) \
				-work $(UNIT_NAME)_work \
				+UVM_VERBOSITY=UVM_LOW \
				-gDUT="$(top)" \
				-gMODEL="$(model)" \
				-gN=$(WIDTH) \
				-c \
				-title "$(UNIT_NAME)_$(model)$(top)" \
				-do "quietly set StdArithNoWarnings 1; run -all;" \
				$(UNIT_NAME)_tb \
				> $(UNIT_NAME)_$(model)$(top)_vsim.log; \
		) \
	)
#------------------------------------------------------------------------------
# Simulate Design (GUI)
#------------------------------------------------------------------------------
gui_simulation: optimize_simulation_model
	$(VSIM) $(VSIM_OPTS) \
		-work $(UNIT_NAME)_work \
		+UVM_VERBOSITY=UVM_MEDIUM \
		-gDUT=LogicalLT \
		-gMODEL=Structural \
		-gN=$(WIDTH) \
		-title "$(UNIT_NAME)_$(model)$(top)" \
		-accessobjdebug \
		-debugdb \
		-classdebug \
		-gui \
		$(UNIT_NAME)_tb \
		-do "quietly set StdArithNoWarnings 1; log -recursive /* -optcells; run -all;"
#------------------------------------------------------------------------------
# Simulate Design (Command Line for offline GUI Debug)
#------------------------------------------------------------------------------
offline_gui_simulation: optimize_simulation_model
	$(VSIM) $(VSIM_OPTS) \
		+UVM_VERBOSITY=UVM_HIGH \
		-title "$(DESIGN_NAME)" \
		-debug \
		-c \
		-do "quietly set StdArithNoWarnings 1; vcd file DEBUG.vcd; vcd add -r -optcells /*; run -all; quit -f;" \
		opt_$(UNIT_NAME)_tb
#------------------------------------------------------------------------------
# Offline GUI Debug)
#------------------------------------------------------------------------------
offline_debug:
	gtkwave \
		-c 8 \
		-o \
		$(COMMON_DIRECTORY)/sim/DEBUG.vcd \
		-a $(COMMON_DIRECTORY)/sim/DEBUG.sav \
		-r $(COMMON_DIRECTORY)/sim/DEBUG.rc
#------------------------------------------------------------------------------
# Synthesize Design
#------------------------------------------------------------------------------



.PHONY: display_environment_settings




