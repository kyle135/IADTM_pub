//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Design Name:  FIFO
// IP Name:      SynchronousFIFOInterface
// Description:  Synchronous FIFO Interface
//-----------------------------------------------------------------------------
interface SynchronousFIFOInterface
#(  //----------------------------------//-------------------------------------
    // Parameters                       // Descriptions
    //----------------------------------//-------------------------------------
    parameter integer N = 32            // Data path width in bits.
)  (//----------------------------------//-------------------------------------
    // Global Signals                   // Description(s)
    //----------------------------------//-------------------------------------
    input  wire       clk               // Core Clock
);

    // Global Signals                   //
    logic         rstn;                 // Synchronous Reset (Active-Low)
    // Push Interface                   //-------------------------------------
    logic         push;                 // Push data into FIFO
    logic [N-1:0] pushData;             // Data to be pushed into FIFO
    logic         full;                 // FIFO is full
    // Pop Interface                    //-------------------------------------
    logic         pop;                  // Pop data from FIFO
    logic [N-1:0] popData;              // Data popped from FIFO
    logic         empty;                // FIFO is empty

    initial begin
        pop  = 1'b0;
        push = 1'b0;
        pushData = {N{1'b0}};
    end

    task capture_outputs;               //
    input  logic       _pop;            //
    output logic [N-1] _popData;        //
    output logic       _empty;          //
    begin                               //
        while (empty === 1'b1) @(posedge clk);   //
        pop     = _pop;                 //
        _popData = popData;             //
        _empty   = empty;               //
        @(posedge clk);   //
        pop     = 1'b0;
    end                                 //
    endtask : capture_outputs;          //-------------------------------------


    task drive_inputs;
    input logic         _push;          // Push data into FIFO
    input logic [N-1:0] _pushData;      // Data to be pushed into FIFO
    output logic        _full;
    begin                               //
        while (full === 1'b1) @(posedge clk);    //
        push     = _push;               //
        pushData = _pushData;           //
        _full    = full;                //
        @(posedge clk);   //
        push     = 1'b0;
    end                                 //
    endtask : drive_inputs              //-------------------------------------

endinterface : SynchronousFIFOInterface
