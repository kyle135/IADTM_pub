//-------------------------------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Design Name:  Memory
// Module Name:  MemorySimple
// Description:  
// Dependencies: 
// · None
//-------------------------------------------------------------------------------------------------
`default_nettype none
module MemorySimple
#(  //-------------------------------//------------------------------------------------------------
    // Parameters                    // Desscription(s)
    //-------------------------------//------------------------------------------------------------
    // Memory Structure              //------------------------------------------------------------
    parameter integer N =  'd32,     // The data path width in bits.
    parameter integer D =  'd1024,   // The number of elements in the RAM (must be a power of two).
    parameter integer A = $clog2(D), // The width, in bits, of the address for specifying the memory location to read or write
    // Reset Configuration           //------------------------------------------------------------
    parameter integer RM =  'b1,     // If we want the memory to be reset with know values set to 1.
    parameter integer RS =  'b1,     // Set to 1 if a synchronous reset of the memory is
    parameter         RV = 1'b1      // If we are filling the contents of the memory during reset, what value do we want to be used.
)  (//-------------------------------//------------------------------------------------------------
    // Port                          // Desscription(s)
    //-------------------------------//------------------------------------------------------------
    input  wire         clk,         // Core Clock
    input  wire         rstn,        // Active-Low Reset
    input  wire         wren,        // Write Enable
    input  wire [A-1:0] waddr,       // Write Address
    input  wire [N-1:0] wdata,       // Write Data
    input  wire         rden,        // Read Enable
    input  wire [A-1:0] raddr,       // Write Address
    output wire [N-1:0] rdata        // Read Data
);
    //---------------------------------------------------------------------------------------------
    // Register/Wire Declarations
    //---------------------------------------------------------------------------------------------
    reg [N-1:0] memory [D];
    integer i, j;

    //---------------------------------------------------------------------------------------------
    // Synchronous Logic
    //---------------------------------------------------------------------------------------------
    // Generate memories
    generate
        if (RM == 1'b1 && RS == 1'b1) begin : SYNCHRONOUS_RESET
            always @(posedge clk)
                if      (~rstn) for (i = 0; i < D; i = i + 1) memory[i]    <= {N{RV}};
                else if (wren)                                 memory[waddr] <= wdata;
        end : SYNCHRONOUS_RESET
        else if (RM == 1'b1 && RS != 1'b1) begin : ASYNCHRONOUS_RESET
            always @(posedge clk, negedge rstn)
                if      (~rstn) for (j = 0; j < D; j = j + 1) memory[j]     <= {N{RV}};
                else if (wren)                                memory[waddr] <= wdata;
        end : ASYNCHRONOUS_RESET
        else begin : NO_RESET
            always @(posedge clk)
                if (wren) memory[waddr] <= wdata;
        end : NO_RESET
    endgenerate

    //---------------------------------------------------------------------------------------------
    // Combinational Logic
    //---------------------------------------------------------------------------------------------
    assign rdata = rden ? memory[raddr] : {N{RV}};

endmodule : MemorySimple
`default_nettype wire
