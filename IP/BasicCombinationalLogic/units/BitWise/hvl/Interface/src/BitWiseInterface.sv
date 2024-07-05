//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International 
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Create Date:  11/26/2020, 1:19:27 PM 
// Project Name: BasicCombinationalLogic
// Unit Name:    BitWise
// Design Name:  Interface
// Module Name:  BitWiseInterface
// Dependencies:
//-----------------------------------------------------------------------------
interface BitWiseInterface;    
    
    parameter integer N= 32;
    //-------------------------------------------------------------------------
    // Interface Attributes
    //-------------------------------------------------------------------------
    // Internal Signals that connect to the DUT
    logic [N-1:0] a;
    logic [N-1:0] b;
    logic [N-1:0] c;

    //-------------------------------------------------------------------------
    // Interface Tasks
    //-------------------------------------------------------------------------    
    task drive_inputs;
   	input logic [N-1:0] _a;
    input logic [N-1:0] _b;
	begin
		a = _a;
		b = _b;
	end
    endtask : drive_inputs

    task capture_outputs;
    output logic [N-1:0] _c;
    begin
	    _c = c;
    end
    endtask : capture_outputs

endinterface : BitWiseInterface
