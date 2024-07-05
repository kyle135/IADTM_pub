ifndef ENVIRONMENT_MK
	define ENVIRONMENT_MK

export DESIGN_HOME      = ${PROGRAM_ROOT}/IP
export SIMULATION_HOME  = ${PROGRAM_ROOT}/IP
export SYNTHESIS_HOME   = ${PROGRAM_ROOT}/hdl/synthesis
export CHECK_HOME       = ${PROGRAM_ROOT}/hdl/check

all: ## clean sim_recipe chk_recipe phy_recipe rep_recipe

env:
	$(eval CLOCK_TIME     = $(shell if [ -e ${PHY_HOME}/.time ]; then cat ${PHY_HOME}/.time; else echo "00"; fi ))
	$(eval CALENDAR_DATE  = $(shell if [ -e ${PHY_HOME}/.date ]; then cat ${PHY_HOME}/.date; else echo "00"; fi ))
	echo "[CLOCK_TIME] ${CLOCK_TIME}"
	echo "[CLOCK_TIME] ${CLOCK_TIME}"

clean: env
	- find . -name "*.log" -delete
	- rm -rf -name "*.jou" -delete

########################################################################################################################
# Simulation Design
########################################################################################################################
sim_recipe:
	echo ${SIM_HOME}
	(cd ${SIM_HOME}; make all)

########################################################################################################################
# Check design using lint
########################################################################################################################
chk_recipe :
	(cd ${CHK_HOME}; make all)

########################################################################################################################
# Create design using Vivado Synthesis
########################################################################################################################
phy_recipe :
	(cd ${PHY_HOME}; make all)

########################################################################################################################
# Generate Report
########################################################################################################################
rep_recipe : gen_rep

# export SYN_I = $(shell if [ -e ${SYN_OUT_DIR}/vivado.log ]; then grep -o 'INFO\:'             ${SYN_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export SYN_W = $(shell if [ -e ${SYN_OUT_DIR}/vivado.log ]; then grep -o 'WARNING\:'          ${SYN_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export SYN_C = $(shell if [ -e ${SYN_OUT_DIR}/vivado.log ]; then grep -o 'CRITICAL WARNING\:' ${SYN_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export SYN_E = $(shell if [ -e ${SYN_OUT_DIR}/vivado.log ]; then grep -o 'ERROR\:'            ${SYN_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export OPT_I = $(shell if [ -e ${OPT_OUT_DIR}/vivado.log ]; then grep -o 'INFO\:'             ${OPT_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export OPT_W = $(shell if [ -e ${OPT_OUT_DIR}/vivado.log ]; then grep -o 'WARNING\:'          ${OPT_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export OPT_C = $(shell if [ -e ${OPT_OUT_DIR}/vivado.log ]; then grep -o 'CRITICAL WARNING\:' ${OPT_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export OPT_E = $(shell if [ -e ${OPT_OUT_DIR}/vivado.log ]; then grep -o 'ERROR\:'            ${OPT_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export PLC_I = $(shell if [ -e ${PLC_OUT_DIR}/vivado.log ]; then grep -o 'INFO\:'             ${PLC_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export PLC_W = $(shell if [ -e ${PLC_OUT_DIR}/vivado.log ]; then grep -o 'WARNING\:'          ${PLC_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export PLC_C = $(shell if [ -e ${PLC_OUT_DIR}/vivado.log ]; then grep -o 'CRITICAL WARNING\:' ${PLC_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export PLC_E = $(shell if [ -e ${PLC_OUT_DIR}/vivado.log ]; then grep -o 'ERROR\:'            ${PLC_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export RTE_I = $(shell if [ -e ${RTE_OUT_DIR}/vivado.log ]; then grep -o 'INFO\:'             ${RTE_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export RTE_W = $(shell if [ -e ${RTE_OUT_DIR}/vivado.log ]; then grep -o 'WARNING\:'          ${RTE_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export RTE_C = $(shell if [ -e ${RTE_OUT_DIR}/vivado.log ]; then grep -o 'CRITICAL WARNING\:' ${RTE_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export RTE_E = $(shell if [ -e ${RTE_OUT_DIR}/vivado.log ]; then grep -o 'ERROR\:'            ${RTE_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export PHY_I = $(shell if [ -e ${OPT_OUT_DIR}/vivado.log ]; then grep -o 'INFO\:'             ${PHY_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export PHY_W = $(shell if [ -e ${PHY_OUT_DIR}/vivado.log ]; then grep -o 'WARNING\:'          ${PHY_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export PHY_C = $(shell if [ -e ${PHY_OUT_DIR}/vivado.log ]; then grep -o 'CRITICAL WARNING\:' ${PHY_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export PHY_E = $(shell if [ -e ${PHY_OUT_DIR}/vivado.log ]; then grep -o 'ERROR\:'            ${PHY_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export BIT_I = $(shell if [ -e ${BIT_OUT_DIR}/vivado.log ]; then grep -o 'INFO\:'             ${BIT_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export BIT_W = $(shell if [ -e ${BIT_OUT_DIR}/vivado.log ]; then grep -o 'WARNING\:'          ${BIT_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export BIT_C = $(shell if [ -e ${BIT_OUT_DIR}/vivado.log ]; then grep -o 'CRITICAL WARNING\:' ${BIT_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export BIT_E = $(shell if [ -e ${BIT_OUT_DIR}/vivado.log ]; then grep -o 'ERROR\:'            ${BIT_OUT_DIR}/vivado.log | wc -l; else echo "00"; fi )
# export WNS   = $(shell if [ -e ${PHY_OUT_DIR}/vivado.log ]; then grep -P 'Post\sPhysical\sOptimization\sTiming\sSummary' ${PHY_OUT_DIR}/vivado.log | grep -oP '(?<=WNS=).*(?=\s\|\sTNS)' ; else echo "00"; fi )
# export TNS   = $(shell if [ -e ${PHY_OUT_DIR}/vivado.log ]; then grep -P 'Post\sPhysical\sOptimization\sTiming\sSummary' ${PHY_OUT_DIR}/vivado.log | grep -oP '(?<=TNS=).*(?=\s\|\sWHS)' ; else echo "00"; fi )
# export WHS   = $(shell if [ -e ${PHY_OUT_DIR}/vivado.log ]; then grep -P 'Post\sPhysical\sOptimization\sTiming\sSummary' ${PHY_OUT_DIR}/vivado.log | grep -oP '(?<=WHS=).*(?=\s\|\sTHS)' ; else echo "00"; fi )
# export THS   = $(shell if [ -e ${PHY_OUT_DIR}/vivado.log ]; then grep -P 'Post\sPhysical\sOptimization\sTiming\sSummary' ${PHY_OUT_DIR}/vivado.log | grep -oP '(?<=THS=).*(?=\s\|)'      ; else echo "00"; fi )
# export LNT_R = $(shell if [ -e ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt ]; then grep -oP '\[WARNING\]\s+\K\w+|\[ERROR\]\s+\K\w+|\[FATAL\]\s+\K\w+|\[INFO]\s+\K\w+' ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt | sort | uniq -c | wc -l ; else echo "00"; fi )
# export LNT_F = $(shell if [ -e ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt ]; then grep -o -i '\[FATAL\]'   ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt | wc -l ; else echo "00"; fi )
# export LNT_E = $(shell if [ -e ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt ]; then grep -o -i '\[ERROR\]'   ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt | wc -l ; else echo "00"; fi )
# export LNT_W = $(shell if [ -e ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt ]; then grep -o -i '\[WARNING\]' ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt | wc -l ; else echo "00"; fi )
# export LNT_N = $(shell if [ -e ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt ]; then grep -o -i '\[NOTE\]'    ${CHK_OUT_DIR}/rpt/ingress_top.detail.rpt | wc -l ; else echo "00"; fi )

# gen_rep:
# 	- rm -rf ${FPGA_NAME}.report
# 	@printf "//                                 ____  _   ___   ______ ___ ____    _    _\n"                            >${FPGA_NAME}.report
# 	@printf "//                                |  _ \| | | \ \ / / ___|_ _/ ___|  / \  | |      source env/setup_env\n" >>${FPGA_NAME}.report
# 	@printf "//                                | |_) | |_| |\ V /\___ \| | |     / _ \ | |      cd src/top/phy\n"       >>${FPGA_NAME}.report
# 	@printf "//                                |  __/|  _  | | |  ___) | | |___ / ___ \| |___   make -B all\n"          >>${FPGA_NAME}.report
# 	@printf "//                                |_|   |_| |_| |_| |____/___\____/_/   \_\_____|\n"                       >>${FPGA_NAME}.report
# 	@printf "//                  :=======================:=======:==========:===================:=========:\n"          >>${FPGA_NAME}.report
# 	@printf "//                  | Operation             | Infos | Warnings | Critical Warnings |  Errors |\n"          >>${FPGA_NAME}.report
# 	@printf "//                  :=======================:=======:==========:===================:=========:\n"          >>${FPGA_NAME}.report
# 	@printf "//                  | Synthesize            | %5d | %8d | %17d | %7d |\n" "$(SYN_I)" "$(SYN_W)" "$(SYN_C)" "$(SYN_E)"        >>${FPGA_NAME}.report
# 	@printf "//                  :-----------------------:-------:----------:-------------------:---------:\n"          >>${FPGA_NAME}.report
# 	@printf "//                  | Optimize              | %5d | %8d | %17d | %7d |\n" "$(OPT_I)" "$(OPT_W)" "$(OPT_C)" "$(OPT_E)"        >>${FPGA_NAME}.report
# 	@printf "//                  :-----------------------:-------:----------:-------------------:---------:\n"          >>${FPGA_NAME}.report
# 	@printf "//                  | Place                 | %5d | %8d | %17d | %7d |\n" "$(PLC_I)" "$(PLC_W)" "$(PLC_C)" "$(PLC_E)"        >>${FPGA_NAME}.report
# 	@printf "//                  :-----------------------:-------:----------:-------------------:---------:\n"          >>${FPGA_NAME}.report
# 	@printf "//                  | Route                 | %5d | %8d | %17d | %7d |\n" "$(RTE_I)" "$(RTE_W)" "$(RTE_C)" "$(RTE_E)"        >>${FPGA_NAME}.report
# 	@printf "//                  :-----------------------:-------:----------:-------------------:---------:\n"          >>${FPGA_NAME}.report
# 	@printf "//                  | Physical Optimization | %5d | %8d | %17d | %7d |\n" "$(PHY_I)" "$(PHY_W)" "$(PHY_C)" "$(PHY_E)"        >>${FPGA_NAME}.report
# 	@printf "//                  '-----------------------:-------:----------:-------------------:---------:\n"          >>${FPGA_NAME}.report
# 	@printf "//                  | Bit Generation        | %5d | %8d | %17d | %7d |\n" "$(BIT_I)" "$(BIT_W)" "$(BIT_C)" "$(BIT_E)"        >>${FPGA_NAME}.report
# 	@printf "//                  '-----------------------'-------'----------'-------------------'---------'\n"          >>${FPGA_NAME}.report
# 	@printf "//                                      _____ ___ __  __ ___ _   _  ____\n"                                >>${FPGA_NAME}.report
# 	@printf "//                                     |_   _|_ _|  \/  |_ _| \ | |/ ___|\n"                               >>${FPGA_NAME}.report
# 	@printf "//                                       | |  | || |\/| || ||  \| | |  _\n"                                >>${FPGA_NAME}.report
# 	@printf "//                                       | |  | || |  | || || |\  | |_| |\n"                               >>${FPGA_NAME}.report
# 	@printf "//                                       |_| |___|_|  |_|___|_| \_|\____|\n"                               >>${FPGA_NAME}.report
# 	@printf "//             :======================:======================:==================:==================:\n"    >>${FPGA_NAME}.report
# 	@printf "//             | Worst Negative Slave | Total Negative Slack | Worst Hold Slack | Total Hold Slack |\n"    >>${FPGA_NAME}.report
# 	@printf "//             :======================:======================:==================:==================:\n"    >>${FPGA_NAME}.report
# 	@printf "//             | %20.3f | %20.3f | %16.3f | %16.3f |\n" "$(WNS)" "$(TNS)" "$(WHS)" "$(THS)"    >>${FPGA_NAME}.report
# 	@printf "//             '----------------------'----------------------'------------------'------------------'\n"    >>${FPGA_NAME}.report
# 	@printf "//                                              ____ ____   ____\n"                                        >>${FPGA_NAME}.report
# 	@printf "//                                             / ___|  _ \ / ___|\n"                                       >>${FPGA_NAME}.report
# 	@printf "//                                            | |   | | | | |\n"                                           >>${FPGA_NAME}.report
# 	@printf "//                                            | |___| |_| | |___\n"                                        >>${FPGA_NAME}.report
# 	@printf "//                                             \____|____/ \____|\n"                                       >>${FPGA_NAME}.report
# 	@printf "//             :===================================================================================:\n"    >>${FPGA_NAME}.report
# 	@printf "//             |                                       TBD                                         |\n"    >>${FPGA_NAME}.report
# 	@printf "//             :===================================================================================:\n"    >>${FPGA_NAME}.report
# 	@printf "//                                           _     ___ _   _ _____\n"                                      >>${FPGA_NAME}.report
# 	@printf "//                                          | |   |_ _| \ | |_   _|   source env/setup_env\n"              >>${FPGA_NAME}.report
# 	@printf "//                                          | |    | ||  \| | | |     cd src/top/chk\n"                    >>${FPGA_NAME}.report
# 	@printf "//                                          | |___ | || |\  | | |     make -B lint_recipe\n"               >>${FPGA_NAME}.report
# 	@printf "//                                          |_____|___|_| \_| |_|\n"                                       >>${FPGA_NAME}.report
# 	@printf "//                \n"                                                                                      >>${FPGA_NAME}.report
# 	@printf "//                            :================:=======:=======:=========:======:\n"                       >>${FPGA_NAME}.report
# 	@printf "//                            | Rules Violated | FATAL | ERROR | WARNING | NOTE |\n"                       >>${FPGA_NAME}.report
# 	@printf "//                            :================:=======:=======:=========:======:\n"                       >>${FPGA_NAME}.report
# 	@printf "//                            | %14d | %5d | %5d | %7d | %4d |\n" "$(LNT_R)" "$(LNT_F)" "$(LNT_E)" "$(LNT_W)" "$(LNT_N)"                      >>${FPGA_NAME}.report
# 	@printf "//                            '----------------'-------'-------'---------'------'"                         >>${FPGA_NAME}.report

else

endif
