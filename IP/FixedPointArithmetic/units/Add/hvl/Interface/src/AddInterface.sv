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
    logic         carry_in;
    logic [N-1:0] c;
    logic         carry_out;
    //-------------------------------------------------------------------------
    // Interface Tasks
    //-------------------------------------------------------------------------    
    task drive_inputs;
   	input logic [N-1:0] _a;
    input logic [N-1:0] _b;
    input logic         _carry_in;
	begin
		a        = _a;
        b        = _b;
        carry_in = _carry_in;
	end
    endtask : drive_inputs

    task capture_outputs;
    output logic [N-1:0] _c;
    output logic         _carry_out;
    begin
	    _c = c;
        _carry_out = carry_out;
    end
    endtask : capture_outputs

endinterface : AddInterface

