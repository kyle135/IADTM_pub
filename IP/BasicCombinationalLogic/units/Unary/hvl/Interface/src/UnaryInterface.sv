//-----------------------------------------------------------------------------
// Interface
//-----------------------------------------------------------------------------
interface UnaryInterface;
    
    parameter integer N= 32;
    //-------------------------------------------------------------------------
    // Interface Attributes
    //-------------------------------------------------------------------------
    // Internal Signals that connect to the DUT
    logic [31:0] a;
    logic        c;
    //-------------------------------------------------------------------------
    // Interface Tasks
    //-------------------------------------------------------------------------    
    task drive_inputs;
   	input logic [31:0] _a;
	begin
		a = _a;
	end
    endtask : drive_inputs

    task capture_outputs;
    output logic _c;
    begin
	    _c = c;
    end
    endtask : capture_outputs

endinterface : UnaryInterface
