#########################################################################################
# XXX_VERILOG_RTL_FILES: These are files that are required for synthesis and simulation
# XXX_VERILOG_SIM_FILES: These are files that are required for simulation only
# XXX_VERILOG_SYN_FILES: These are files that are required for synthesis only
#########################################################################################
#----------------------------------------------------------------------------------------
# Locate our damn selves.
#----------------------------------------------------------------------------------------
export ALU_INC_CURRENT_MAKEFILE	  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
export ALU_INC_MAKEFILE_DIRECTORY := $(dir $(ALU_INC_CURRENT_MAKEFILE))
export ALU_INC_HDL_DIRECTORY      := $(abspath $(ALU_INC_MAKEFILE_DIRECTORY)/../hdl)
export ALU_INC_HVL_DIRECTORY      := $(abspath $(ALU_INC_MAKEFILE_DIRECTORY)/../hvl)

export ALU_MODELING               := \
    Behavioral \
	DataFlow \
	Structural

export ALU_TOPS                   := \
	ALU

export ALU_DPI_FILES              := \
	hvl/CModel/ALUCModel.c

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ALU_VERILOG_HDL_FILES := \
	../../hdl/MIPS32_1_hdl_pkg.sv \
	hdl/ALU_hdl_pkg.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseAND.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseNAND.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseNOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseNOT.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseShiftLeft.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseShiftRight.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseXNOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseXOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseAND.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseShiftMux.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseNAND.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseNOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseNOT.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseShiftLeft.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseShiftRight.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseXNOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseXOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseAND.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseNAND.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseNOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseNOT.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseShiftLeft.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseShifRight.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseXNOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/DataFlowBitWiseXOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseAND.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseNAND.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseNOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseNOT.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseShiftLeft.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseShiftRight.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseXNOR.sv \
	../../../../BasicCombinationalLogic/units/BitWise/hdl/StructuralBitWiseXOR.sv \
	../../../../FixedPointArithmetic/units/Add/hdl/BehavioralAddRippleCarry.sv \
    ../../../../FixedPointArithmetic/units/Add/hdl/DataFlowAddRippleCarry.sv \
    ../../../../FixedPointArithmetic/units/Add/hdl/StructuralAddRippleCarry.sv \
    ../../../../FixedPointArithmetic/units/Add/hdl/AddRippleCarry.sv \
    ../../../../FixedPointArithmetic/units/Add/hdl/AddCarryLookAhead.sv \
    ../../../../FixedPointArithmetic/units/Add/hdl/AddCarrySave.sv \
    ../../../../FixedPointArithmetic/units/Add/hdl/AddCarrySelect.sv \
	../../../../FixedPointArithmetic/hdl/FixedPointAdd.sv \
	../../../../FixedPointArithmetic/hdl/FixedPointCompare.sv \
	../../../../FixedPointArithmetic/hdl/FixedPointDivide.sv \
	../../../../FixedPointArithmetic/hdl/FixedPointMultiply.sv \
	../../../../FixedPointArithmetic/hdl/FixedPointArithmeticShift.sv \
	../../../../FixedPointArithmetic/hdl/FixedPointSubtract.sv \
	../../../../FixedPointArithmetic/hdl/FixedPointCountLeadingOnes.sv \
	../../../../FixedPointArithmetic/hdl/FixedPointCountLeadingZeros.sv \
	hdl/ALUAddSubtract.sv \
	hdl/ALUShift.sv \
	hdl/ALUMultiplyDivide.sv \
	hdl/ALULogical.sv \
	hdl/ALU.sv

#----------------------------------------------------------------------------------------
# Specify Verilog RTL Files
#----------------------------------------------------------------------------------------
export ALU_VERILOG_HVL_FILES := \
	hvl/ALU_hvl_pkg.sv \
	hvl/Interface/src/ALUInterface.sv \
	hvl/ALU_tb.sv
