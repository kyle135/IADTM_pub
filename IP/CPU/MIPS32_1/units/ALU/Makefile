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
IP_DIRECTORY	        := $(abspath $(THIS_MAKEFILE_DIRECTORY)/../../../..)
IP_NAME                 := CPU/MIPS32_1
UNIT_NAME               := ALU
WORK_DIRECTORY          := $(IP_DIRECTORY)/$(IP_NAME)/units/$(UNIT_NAME)

include $(IP_DIRECTORY)/inc/Tools.mk
include $(WORK_DIRECTORY)/inc/$(UNIT_NAME)Filelist.mk

VERILOG_HDL_FILES       := $(ALU_VERILOG_HDL_FILES)
VERILOG_HVL_FILES       := $(ALU_VERILOG_HVL_FILES)
MODELS                  := $(ALU_MODELS)
TOPS                    := $(ALU_TOPS)
WIDTH                   := 32
ALGORITHMS              := $(ALU_ALGORITHMS)

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
	$(MGCC) -c -fpic -I$(LIN_MODELSIM_ROOTDIR)/include $(ALU_DPI_FILES)
	gcc -shared -o ALUCModel.so ALUCModel.o
#------------------------------------------------------------------------------
# Compile Design Collateral
#------------------------------------------------------------------------------
compile_rtl_for_simulation: compile_c_model_for_simulation
	$(info [$(UNIT)_VERILOG_HDL_FILES] $(VERILOG_HDL_FILES))
	$(VLOG) -work $(UNIT_NAME)_work $(VERILOG_HDL_FILES) > $(UNIT_NAME)_vlog_hdl.log
	$(info [$(UNIT)_VERILOG_HVL_FILES] $(VERILOG_HVL_FILES))
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
	$(VSIM) \
		-work $(UNIT_NAME)_work \
		+UVM_TESTNAME=ALUTest \
		+UVM_VERBOSITY=UVM_HIGH \
		-gN=$(WIDTH) \
		-gR=32 \
		-c \
		-title "$(UNIT_NAME)" \
		-do "run -all;" \
		-voptargs=+acc \
		-t ns \
		-sv_lib ALUCModel \
		$(UNIT_NAME)_tb \
		| tee $(UNIT_NAME)_vsim.log;
#------------------------------------------------------------------------------
# Simulate Design (Command Line)
#------------------------------------------------------------------------------
gui_simulation: optimize_simulation_model
	$(VSIM) \
		-work $(UNIT_NAME)_work \
		+UVM_TESTNAME=ALUTest \
		+UVM_VERBOSITY=UVM_MEDIUM \
		-gN=$(WIDTH) \
		-gR=32 \
		-title "$(UNIT_NAME)" \
		-do "log -r /*; run -all;" \
		-voptargs=+acc \
		-t ns \
		-sv_lib ALUCModel \
		$(UNIT_NAME)_tb \
		> $(UNIT_NAME)_vsim.log;
#--------------------------------------------------------------------------------------------------
# Synthesize
#--------------------------------------------------------------------------------------------------
synthesize_design: clean
	yosys -c syn/ALU.tcl > ALU_syn.log

