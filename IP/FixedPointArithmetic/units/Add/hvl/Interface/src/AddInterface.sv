//-----------------------------------------------------------------------------
// Interface
//-----------------------------------------------------------------------------
interface AddInterface;
    
    parameter integer N= 32;
    //-------------------------------------------------------------------------
    // Interface Attributes
    //-------------------------------------------------------------------------
    // Internal Signals that connect to the DUT
    logic [N-1:0] a;
    logic [N-1:0] b;
    logic         ci;
    logic [N-1:0] c;
    logic         co;
    //-------------------------------------------------------------------------
    // Interface Tasks
    //-------------------------------------------------------------------------    
    task drive_inputs;
   	input logic [N-1:0] _a;
    input logic [N-1:0] _b;
    input logic         _ci;
	begin
		a        = _a;
        b        = _b;
        ci = _ci;
	end
    endtask : drive_inputs

    task capture_outputs;
    output logic [N-1:0] _c;
    output logic         _co;
    begin
	    _c = c;
        _co = co;
    end
    endtask : capture_outputs

endinterface : AddInterface

