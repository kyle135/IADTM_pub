yosys -import
plugin -i systemverilog
yosys -import
# read design 
read_systemverilog \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseShiftMux.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseAND.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseNAND.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseNOR.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseNOT.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseOR.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseShiftLeft.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseShiftRight.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseXNOR.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BehavioralBitWiseXOR.sv \
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
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseAND.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseNAND.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseNOR.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseNOT.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseOR.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseShiftLeft.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseShiftRight.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseXNOR.sv \
    ../../../../BasicCombinationalLogic/units/BitWise/hdl/BitWiseXOR.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalAND.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalGT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalGTEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalLT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalLTEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalNEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalNOT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/BehavioralLogicalOR.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalAND.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalGT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalGTEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalLT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalLTEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalNEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalNOT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/DataFlowLogicalOR.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalAND.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalGT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalGTEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalLT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalLTEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalNEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalNOT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/StructuralLogicalOR.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalAND.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalGT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalGTEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalLT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalLTEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalNEQ.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalNOT.sv \
    ../../../../BasicCombinationalLogic/units/Logical/hdl/LogicalOR.sv \
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

# # generic synthesis
synth -top ALU

# mapping to mycells.lib
dfflibmap -liberty mycells.lib
abc -liberty mycells.lib
clean

# # write synthesized design
write_verilog ALU.vo


