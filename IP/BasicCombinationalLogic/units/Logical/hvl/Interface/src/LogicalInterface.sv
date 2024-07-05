//-----------------------------------------------------------------------------
// Interface
//-----------------------------------------------------------------------------
interface LogicalInterface;
    
    parameter integer N= 32;
    //-------------------------------------------------------------------------
    // Interface Attributes
    //-------------------------------------------------------------------------
    // Internal Signals that connect to the DUT
    logic [N-1:0] a;
    logic [N-1:0] b;
    logic         c;

    //-------------------------------------------------------------------------
    // Interface Tasks
    //-------------------------------------------------------------------------    
    task drive_inputs;
   	input logic [31:0] _a;
    input logic [31:0] _b;
	begin
		a = _a;
		b = _b;
	end
    endtask : drive_inputs

    task capture_outputs;
    output logic _c;
    begin
	    _c = c;
    end
    endtask : capture_outputs

endinterface : LogicalInterface
