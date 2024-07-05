
# Local Definitions
#----------------------------------------------------------------------------------------------------------------------
# Design name
DESIGN_NAME				:= common
#----------------------------------------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------------------------------------
COMMON_SIM_MAKEFILE				:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
COMMON_SIM_MAKEFILE_DIRECTORY	:= $(abspath $(dir $(COMMON_SIM_MAKEFILE)))
COMMON_SIM_DIRECTORY			:= $(abspath $(COMMON_SIM_MAKEFILE_DIRECTORY))
COMMON_RTL_DIRECTORY			:= $(abspath $(COMMON_SIM_MAKEFILE_DIRECTORY)/../rtl)
COMMON_PROJECT_DIRECTORY		:= $(abspath $(COMMON_SIM_MAKEFILE_DIRECTORY)/../..)

include $(COMMON_PROJECT_DIRECTORY)/common/sim/inc/Makefiles/CreateSimLibs.mk
include $(COMMON_PROJECT_DIRECTORY)/common/sim/inc/Makefiles/projectSetup.mk
#----------------------------------------------------------------------------------------------------------------------
# Define local simulation source files.
#----------------------------------------------------------------------------------------------------------------------
LOCAL_VERILOG_SIM_FILES	:= \
	$(COMMON_SIM_DIRECTORY)/testbench/$(DESIGN_NAME)_tb.sv
#----------------------------------------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------------------------------------
display_local_environment_settings:
	@echo -e "[$(FILE_NAME_COLOUR) COMMON_SIM_MAKEFILE $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(COMMON_SIM_MAKEFILE)$(NO_COLOUR)"
	@echo -e "[$(DIRECTORY_NAME_COLOUR) COMMON_SIM_MAKEFILE_DIRECTORY $(NO_COLOUR)] $(DIRECTORY_STRING_COLOUR)$(COMMON_SIM_MAKEFILE_DIRECTORY)$(NO_COLOUR)"
	@echo -e "[$(DIRECTORY_NAME_COLOUR) COMMON_SIM_DIRECTORY $(NO_COLOUR)] $(DIRECTORY_STRING_COLOUR)$(COMMON_SIM_DIRECTORY)$(NO_COLOUR)"
	@echo -e "[$(DIRECTORY_NAME_COLOUR) COMMON_RTL_DIRECTORY $(NO_COLOUR)] $(DIRECTORY_STRING_COLOUR)$(COMMON_RTL_DIRECTORY)$(NO_COLOUR)"

#----------------------------------------------------------------------------------------------------------------------
# Local Clean
#----------------------------------------------------------------------------------------------------------------------
clean_local: display_local_environment_settings
	-- find . -name "com.*.*.log" -delete
	-- find . -name "opt.*.*.log" -delete
	-- find . -name "sim.*.*.log" -delete	
	-- rm -rf $(COMMON_SIM_DIRECTORY)/$(DESIGN_NAME)_work
#----------------------------------------------------------------------------------------------------------------------
# Generate working library
#----------------------------------------------------------------------------------------------------------------------
create_work_library: clean_local
	$(VLIB) \
		-unix \
		-type flat \
		-compress \
		-dirpath $(COMMON_SIM_DIRECTORY)/$(DESIGN_NAME)_work \
		$(DESIGN_NAME)_work
#----------------------------------------------------------------------------------------------------------------------
# Generate working library
#----------------------------------------------------------------------------------------------------------------------
map_libraries: create_work_library
	$(VMAP) $(VMAP_OPTS) work $(COMMON_SIM_DIRECTORY)/$(DESIGN_NAME)_work
#----------------------------------------------------------------------------------------------------------------------
# Compile Design Collateral
#----------------------------------------------------------------------------------------------------------------------
compile_c_model_for_simulation: map_libraries

#----------------------------------------------------------------------------------------------------------------------
# Compile Design Collateral
#----------------------------------------------------------------------------------------------------------------------
compile_rtl_for_simulation: compile_c_model_for_simulation
	$(info [COMMON_VERILOG_RTL_FILES] $(COMMON_VERILOG_RTL_FILES))
	$(VLOG) $(VLOG_OPTS) +define+UNIT_LEVEL_SIMULATION $(COMMON_VERILOG_RTL_FILES)
	$(info [COMMON_VERILOG_SIM_FILES] $(COMMON_VERILOG_SIM_FILES))
	$(VLOG) $(VLOG_OPTS) +define+UNIT_LEVEL_SIMULATION $(COMMON_VERILOG_SIM_FILES)
	$(info [LOCAL_VERILOG_SIM_FILES] $(LOCAL_VERILOG_SIM_FILES))
	$(VLOG) $(VLOG_OPTS) +define+UNIT_LEVEL_SIMULATION $(LOCAL_VERILOG_SIM_FILES)
#----------------------------------------------------------------------------------------------------------------------
# Optimize Design (for simulation speed-up)
#----------------------------------------------------------------------------------------------------------------------
optimize_simulation_model: compile_rtl_for_simulation
	$(VOPT) $(VOPT_OPTS) \
		$(DESIGN_NAME)_tb \
		-o opt_$(DESIGN_NAME)_tb
#----------------------------------------------------------------------------------------------------------------------
# Optimize Design for Multi-Core
#----------------------------------------------------------------------------------------------------------------------
multicore_optimize_simulation_model: compile_rtl_for_simulation
	mc2com $(VOPT_OPTS) $(DESIGN_NAME)_tb -o opt_$(DESIGN_NAME)_tb -mc2numpart 2
#----------------------------------------------------------------------------------------------------------------------
# Simulate Design (Command Line)
#----------------------------------------------------------------------------------------------------------------------
command_line_simulation: optimize_simulation_model
	$(VSIM) $(VSIM_OPTS) \
		+UVM_VERBOSITY=UVM_FULL \
		-title "$(DESIGN_NAME)" \
		-c \
		-sv_lib $(AES_CRYPT_DIRECTORY)/sim/c_model/aes_dpi \
		-do "quietly set StdArithNoWarnings 1; run -all; quit -f;" \
		opt_$(DESIGN_NAME)_tb
#--------------------------------------------------------------------------------------------------
# Simulate Design (GUI)
#--------------------------------------------------------------------------------------------------
gui_simulation: optimize_simulation_model
	$(VSIM) $(VSIM_OPTS) \
		+UVM_VERBOSITY=UVM_HIGH \
		-title "$(DESIGN_NAME)" \
		-gui \
		-sv_lib $(AES_CRYPT_DIRECTORY)/sim/c_model/aes_dpi \
		-do "quietly set StdArithNoWarnings 1; log -recursive /* -optcells; run -all;" \
		opt_$(DESIGN_NAME)_tb
#--------------------------------------------------------------------------------------------------
# Simulate Design (Command Line for offline GUI Debug)
#--------------------------------------------------------------------------------------------------
offline_gui_simulation: optimize_simulation_model
	$(VSIM) $(VSIM_OPTS) \
		+UVM_VERBOSITY=UVM_HIGH \
		-title "$(DESIGN_NAME)" \
		-c \
		-sv_lib $(AES_CRYPT_DIRECTORY)/sim/c_model/aes_dpi \
		-do "quietly set StdArithNoWarnings 1; vcd file DEBUG.vcd; vcd add -r -optcells /*; run -all; quit -f;" \
		opt_$(DESIGN_NAME)_tb
#--------------------------------------------------------------------------------------------------
# Offline GUI Debug)
#--------------------------------------------------------------------------------------------------
offline_debug:
	gtkwave \
		-c 8 \
		-o \
		$(COMMON_DIRECTORY)/sim/DEBUG.vcd \
		-a $(COMMON_DIRECTORY)/sim/DEBUG.sav \
		-r $(COMMON_DIRECTORY)/sim/DEBUG.rc
#--------------------------------------------------------------------------------------------------
# Synthesize Design
#--------------------------------------------------------------------------------------------------

.PHONY: display_environment_settings

