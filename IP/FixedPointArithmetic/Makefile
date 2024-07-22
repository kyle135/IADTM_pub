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
IP_DIRECTORY	        := $(abspath $(THIS_MAKEFILE_DIRECTORY)/..)
IP_NAME                 := FixedPointArithmetic
WORK_DIRECTORY          := $(IP_DIRECTORY)/$(IP_NAME)

include $(IP_DIRECTORY)/inc/Tools.mk
include $(WORK_DIRECTORY)/inc/$(IP_NAME)Filelist.mk

VERILOG_HDL_FILES       := $(FIXEDPOINTARITHMETIC_VERILOG_HDL_FILES)
VERILOG_HVL_FILES       := $(FIXEDPOINTARITHMETIC_VERILOG_HVL_FILES)
MODELS                  := $(FIXEDPOINTARITHMETIC_MODELS)
TOPS                    := $(FIXEDPOINTARITHMETIC_TOPS)
TOP                     := FixedPointSubtract
WIDTH                   := 32
ALGORITHMS              := $(FIXEDPOINTARITHMETIC_ALGORITHMS)

display:
	@echo "[VLIB]           $(VLIB) $(VLIB_OPTS)"
	@echo "[VMAP]           $(VMAP) $(VMAP_OPTS)"
	@echo "[VLOG]           $(VLOG) $(VLOG_OPTS)"
	@echo "[VSIM]           $(VSIM) $(VSIM_OPTS)"
	@echo "[IP_DIRECTORY]	$(IP_DIRECTORY)"
	@echo "[IP_NAME]        $(IP_NAME)"
	@echo "[TOPS]           $(TOPS)"
	@echo "[UNIT_NAME]      $(UNIT_NAME)"
	@echo "[WORK_DIRECTORY] $(WORK_DIRECTORY)"

#------------------------------------------------------------------------------
# Local Clean
#------------------------------------------------------------------------------
clean: display
	@rm -rf $(WORK_DIRECTORY)/slpp_all
	@rm -rf $(WORK_DIRECTORY)/$(UNIT_NAME)_work
	@find $(WORK_DIRECTORY)/. -name "*.vo" -delete
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
	$(info [$(UNIT)_VERILOG_HDL_FILES] $(VERILOG_HDL_FILES))
	$(VLOG) -work $(IP_NAME)_work $(VERILOG_HDL_FILES) > $(IP_NAME)_vlog_hdl.log
	$(info [$(UNIT)_VERILOG_HVL_FILES] $(VERILOG_HVL_FILES))
	$(VLOG) -work $(IP_NAME)_work $(VERILOG_HVL_FILES) > $(IP_NAME)_vlog_hvl.log
#----------------------------------------------------------------------------------------------------------------------
# Optimize Design (for simulation speed-up)
#------------------------------------------------------------------------------
optimize_simulation_model: compile_rtl_for_simulation
	$(foreach top, $(TOPS), \
		$(VOPT) \
			$(top)_tb \
			-o opt_$(top)_tb > $(top)_vopt.log; \
	)
#------------------------------------------------------------------------------
# Simulate Design (Command Line)
#------------------------------------------------------------------------------
command_line_simulation: optimize_simulation_model
	$(foreach top, $(TOPS), \
		$(VSIM) \
			-work $(IP_NAME)_work \
			-gN=$(WIDTH) \
			-c \
			-title "$(IP_NAME)_$(top)" \
			-do "run -all;" \
			-voptargs=+acc \
			-t ns \
			$(top)_tb \
			| tee $(IP_NAME)_$(top)_vsim.log; \
	)
#------------------------------------------------------------------------------
# Simulate Design (Command Line)
#------------------------------------------------------------------------------
gui_simulation: optimize_simulation_model
	$(VSIM) \
		-work $(IP_NAME)_work \
		-gN=$(WIDTH) \
		-title "$(IP_NAME) - $(TOP)" \
		-do "log -r /*; run -all;" \
		-voptargs=+acc \
		-t ns \
		$(TOP)_tb \
		> $(IP_NAME)_vsim.log;
#--------------------------------------------------------------------------------------------------
# Synthesize
#--------------------------------------------------------------------------------------------------
synthesize_design: clean
	yosys -q -c syn/ALU.tcl > FIXEDPOINTARITHMETIC_syn.log

