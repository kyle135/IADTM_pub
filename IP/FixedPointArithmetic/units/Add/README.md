Current Status
-----------------------------------------------------------
PS - StructuralRippleCarryAdd
PS - StructuralCarryLookAheadAdd

ER - BehvioralRippleCarryAdd    <-- Seems like a simulator issue. The code is identical to the DataFlow model.
ER - BehvioralCarryLookAheadAdd

PS - DataFlowRippleCarryAdd
FL - DataFlowCarryLookAheadAdd  <-- Seems like a simulator issue. The code is identical to the DataFlow model.

ER - BehvioralCarrySaveAdd
ER - BehvioralCarrySelectAdd
ER - BehvioralCarrySkipAdd
ER - DataFlowCarrySaveAdd
ER - DataFlowCarrySelectAdd
ER - DataFlowCarrySkipAdd
ER - StructuralCarrySaveAdd
ER - StructuralCarrySelectAdd
ER - StructuralCarrySkipAdd
FL - DataFlowBlockCarryLookAhead
FL - BehvioralBlockCarryLookAhead
FL - StructuralBlockCarryLookAhead

Legend
-----------------------------------------------------------
* PS - Pass
* FL - Fails to load
* ER - Errors in computation
