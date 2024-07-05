#--------------------------------------------------------------------------------------------------
# Locate our damn selves.
#--------------------------------------------------------------------------------------------------
PROJECT_SETUP_MAKEFILE			:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
PROJECT_SETUP_MAKEFILE_DIRECTORY:= $(dir $(PROJECT_SETUP_MAKEFILE))
PROJECT_SETUP_PROJECT_DIRECTORY	:= $(abspath $(PROJECT_SETUP_MAKEFILE_DIRECTORY)/../..)
#--------------------------------------------------------------------------------------------------
# Define Variables
#--------------------------------------------------------------------------------------------------
SHELL							:= /bin/bash
NAS								:= $(abspath /NAS)
WHOAMI							:= $(shell whoami)
HOST_TYPE						:= $(shell arch)

#--------------------------------------------------------------------------------------------------
# Define Global Directories Simmulation Directories
#--------------------------------------------------------------------------------------------------
export COMMON_DIRECTORY				:= $(abspath $(PROJECT_DIRECTORY)/hdl)
export COMMON_DESIGN_DIRECTORY		:= $(abspath $(COMMON_DIRECTORY)/design)
export COMMON_SIMULATION_DIRECTORY	:= $(abspath $(COMMON_DIRECTORY)/simulation)

#--------------------------------------------------------------------------------------------------
# Global include directories
#--------------------------------------------------------------------------------------------------
export COMMON_INCLUDE_DIRECTORY				:= $(COMMON_DIRECTORY)/include
export COMMON_DESIGN_INCLUDE_DIRECTORY		:= $(COMMON_DESIGN_DIRECTORY)/include
export COMMON_SIMULATION_INCLUDE_DIRECTORY	:= $(COMMON_SIMULATION_DIRECTORY)/include
#--------------------------------------------------------------------------------------------------
# Define lower level module's directories
#--------------------------------------------------------------------------------------------------
SYSTEM_CONTROLLER_DESIGN_UNIT_DIRECTORY		:= $(COMMON_DESIGN_DIRECTORY)/system_controller
ETHERNET_DIRECTORY							:= $(COMMON_DESIGN_DIRECTORY)/ethernet

#--------------------------------------------------------------------------------------------------
#
#--------------------------------------------------------------------------------------------------
export COMMON_SIMULATION_INTERFACES_DIRECTORY			:= $(abspath $(COMMON_SIMULATION_DIRECTORY)/uvm/interfaces)
export COMMON_SIMULATION_BUS_FUNCTONAL_MODELS_DIRECTORY:= $(abspath $(COMMON_SIMULATION_DIRECTORY)/modules/bus_functional_models)
#--------------------------------------------------------------------------------------------------
# Define necessary source files for synthesis
#----------  COMMON_DESIGN_DIRECTORY----------------------------------------------------------------------------------------
RTL_SOURCE_MAKEFILE				:= inc/Makefiles/rtl_source.mk

## include $(SYSTEM_CONTROLLER_DIRECTORY)/$(RTL_SOURCE_MAKEFILE)
## include $(COMMON_DIRECTORY)/des/$(RTL_SOURCE_MAKEFILE)
## include $(ETHERNET_DIRECTORY)/$(RTL_SOURCE_MAKEFILE)

#--------------------------------------------------------------------------------------------------
# Define necessary source files for simulation
#--------------------------------------------------------------------------------------------------
SIM_SOURCE_MAKEFILE				:= sim/inc/Makefiles/sim_source.mk

##include $(SYSTEM_CONTROLLER_DIRECTORY)/$(SIM_SOURCE_MAKEFILE)
##include $(COMMON_DIRECTORY)/$(SIM_SOURCE_MAKEFILE)
##include $(ETHERNET_DIRECTORY)/$(SIM_SOURCE_MAKEFILE)

#--------------------------------------------------------------------------------------------------
# Include environment setup Makefiles
#--------------------------------------------------------------------------------------------------
include $(abspath $(PROJECT_DIRECTORY)/include/makefiles/shellColour.mk)
## include $(abspath $(COMMON_DIRECTORY)/sim/inc/makefiles/QuestaSim_opts.mk)


timestamp: clean
	$(info TIME_STAMP : $(TIME_STAMP))
#--------------------------------------------------------------------------------------------------
# Display Environment
#--------------------------------------------------------------------------------------------------
display_environment_settings: timestamp
	$(info USER                               : $(WHOAMI))
	$(info HOST_TYPE                          : $(HOST_TYPE))
	$(info PROJECT_NAME                       : $(PROJECT_NAME))
	$(info PROJECT_DIRECTORY                  : $(PROJECT_DIRECTORY))
	# $(info COMMON_INCLUDE_DIRECTORY           : $(COMMON_INCLUDE_DIRECTORY))
	# $(info COMMON_DESIGN_DIRECTORY            : $(COMMON_DESIGN_DIRECTORY))
	# $(info COMMON_DESIGN_INCLUDE_DIRECTORY:   : $(COMMON_DESIGN_INCLUDE_DIRECTORY))
	# $(info COMMON_SIMULATION_DIRECTORY        : $(COMMON_SIMULATION_DIRECTORY))
	# $(info COMMON_SIMULATION_INCLUDE_DIRECTORY: $(COMMON_SIMULATION_INCLUDE_DIRECTORY))
	# $(info COMMON_SYNTHESIS_DIRECTORY         : $(COMMON_SYNTHESIS_DIRECTORY))
	# @echo -e "✘ [$(DIRECTORY_NAME_COLOUR) BOARD_ADMIN_DIRECTORY $(NO_COLOUR)] $(DIRECTORY_STRING_COLOUR)$(BOARD_ADMIN_DIRECTORY)$(NO_COLOUR)"
	# @echo -e "  $(DOT_COLOUR)￭$(NO_COLOUR) [$(FILE_NAME_COLOUR) BOARD_ADMIN_VHDL_SIM_FILES $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(BOARD_ADMIN_VHDL_SIM_FILES)$(NO_COLOUR)"
	# @echo -e "  $(DOT_COLOUR)￭$(NO_COLOUR) [$(FILE_NAME_COLOUR) BOARD_ADMIN_VERILOG_SIM_FILES $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(BOARD_ADMIN_VERILOG_SIM_FILES)$(NO_COLOUR)"
	# @echo -e "  $(DOT_COLOUR)￭$(NO_COLOUR) [$(FILE_NAME_COLOUR) BOARD_ADMIN_VHDL_RTL_FILES $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(BOARD_ADMIN_VHDL_RTL_FILES)$(NO_COLOUR)"
	# @echo -e "  $(DOT_COLOUR)￭$(NO_COLOUR) [$(FILE_NAME_COLOUR) BOARD_ADMIN_VERILOG_RTL_FILES $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(BOARD_ADMIN_VERILOG_RTL_FILES)$(NO_COLOUR)"

	# @echo -e "✘ [$(DIRECTORY_NAME_COLOUR) COMMON_DIRECTORY $(NO_COLOUR)] $(DIRECTORY_STRING_COLOUR)$(COMMON_DIRECTORY)$(NO_COLOUR)"
	# @echo -e "  $(DOT_COLOUR)￭$(NO_COLOUR) [$(FILE_NAME_COLOUR) COMMON_VHDL_SIM_FILES $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(COMMON_VHDL_SIM_FILES)$(NO_COLOUR)"
	# @echo -e "  $(DOT_COLOUR)￭$(NO_COLOUR) [$(FILE_NAME_COLOUR) COMMON_VERILOG_SIM_FILES $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(COMMON_VERILOG_SIM_FILES)$(NO_COLOUR)"
	# @echo -e "  $(DOT_COLOUR)￭$(NO_COLOUR) [$(FILE_NAME_COLOUR) COMMON_VHDL_RTL_FILES] $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(COMMON_VHDL_RTL_FILES)$(NO_COLOUR)"
	# @echo -e "  $(DOT_COLOUR)￭$(NO_COLOUR) [$(FILE_NAME_COLOUR) COMMON_VERILOG_RTL_FILES] $(NO_COLOUR)] $(FILE_STRING_COLOUR)$(COMMON_VERILOG_RTL_FILES)$(NO_COLOUR)"

