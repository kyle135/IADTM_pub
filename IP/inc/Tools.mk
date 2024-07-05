#--------------------------------------------------------------------------------------------------
# Time-Stamp Generation
#--------------------------------------------------------------------------------------------------
HOUR			:= $(shell date +'%H.%M.%S' | cut -c 1,2)
MINUTE			:= $(shell date +'%H.%M.%S' | cut -c 4,5)
SECOND			:= $(shell date +'%H.%M.%S' | cut -c 7,8)
CLOCK_TIME		:= $(HOUR).$(MINUTE).$(SECOND)
DAY				:= $(shell date +'%m.%d.%Y' | cut -c 4,5)
MONTH			:= $(shell date +'%m.%d.%Y' | cut -c 1,2)
YEAR			:= $(shell date +'%m.%d.%Y' | cut -c 7,8,9,10)
CALENDAR_DATE	:= $(YEAR).$(MONTH).$(DAY)
TIME_STAMP		:= $(CALENDAR_DATE)_$(CLOCK_TIME)

#------------------------------------------------------------------------------
# Mentor Graphics Tools
#------------------------------------------------------------------------------
WSL_MODELSIM_ROOTDIR :=/mnt/c/questasim64_2021.1
WSL_PATH             :=$(MODELSIM_ROOTDIR)/win64

LIN_MODELSIM_ROOTDIR :=/tools/QuestaSim2021.2_1/questasim
LIN_PATH             :=$(LIN_MODELSIM_ROOTDIR)/linux_x86_64/


PATH                 :=$(LIN_PATH):$(PATH)

MVLIB := $(LIN_MODELSIM_ROOTDIR)/linux_x86_64/vlib
MVLOG := $(LIN_MODELSIM_ROOTDIR)/linux_x86_64/vlog
MGCC  := $(LIN_MODELSIM_ROOTDIR)/gcc-7.4.0-linux_x86_64/bin/gcc
MVMAP := $(LIN_MODELSIM_ROOTDIR)/linux_x86_64/vmap
MVOPT := $(LIN_MODELSIM_ROOTDIR)/linux_x86_64/vopt
MVSIM := $(LIN_MODELSIM_ROOTDIR)/linux_x86_64/vsim

MVLIB_OPTS := -compress -unix -type flat
MVLOG_OPTS := -sv
MVOPT_OPTS := -access=rw+/. -cellaccess=rw+/.
MVSIM_OPTS := -classdebug

#------------------------------------------------------------------------------
# Aldec Tools
#------------------------------------------------------------------------------
# ALDEC_ROOTDIR := /mnt/c/Aldec/Active-HDL-12-x64/
# # PATH=$(ALDEC_ROOTDIR):$(PATH)

# AVLIB         := $(ALDEC_ROOTDIR)/BIN/vlib.exe
# AVLOG         := $(ALDEC_ROOTDIR)/BIN/vlog.exe
# AVMAP         := $(ALDEC_ROOTDIR)/BIN/vmap.exe
# AVOPT         := $(ALDEC_ROOTDIR)/BIN/vopt.exe
# AVSIM         := $(ALDEC_ROOTDIR)/BIN/vsim.exe

# AVLIB_OPTS    := -compress
# AVOPT_OPTS    := -classdebug
# MVLOG_OPTS := -sv
#------------------------------------------------------------------------------
# All Tools
#-------------------------------------------------------------------------------
# Aldec Mappings
# VLIB := $(AVLIB) $(AVLIB_OPTS)
# VLOG := $(AVLOG) $(AVLOG_OPTS)
# VMAP := $(AVMAP)
# VOPT := $(AVOPT)
# VSIM := $(AVSIM)

VLIB := $(MVLIB) $(MVLIB_OPTS)
VLOG := $(MVLOG) $(MVLOG_OPTS)
VMAP := $(MVMAP) $(MVMAP_OPTS)
VOPT := $(MVOPT) $(MVOPT_OPTS)
VSIM := $(MVSIM) $(MVSIM_OPTS)