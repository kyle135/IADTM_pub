//-------------------------------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Design Name:  Memory
// Module Name:  MemoryTrueDualPort
// Description:  
// Dependencies: 
// · None
//-------------------------------------------------------------------------------------------------
`default_nettype none
module MemoryTrueDualPort
#(  //----------------------------------//---------------------------------------------------------
    // Parameters                       // Desscription(s)
    //----------------------------------//---------------------------------
    // Memory Structure                 //---------------------------------
    parameter integer    N = 'd8,       // The width, in bits, of the data being stored in the memory locations.
    parameter integer    D = 'd32,      // The number of elements in the RAM (must be a power of two).
    parameter integer    A = $clog2(D), // The width, in bits, of the address for specifying the memory location to read or write
    // Reset Configuration                  //---------------------------------
    parameter integer   RM = 1,            // If we want the memory to be reset with know values set to 1.
    parameter integer   RS = 1,            // Set to 1 if a synchronous reset of the memory is
    parameter integer   RV = 1             // If we are filling the contents of the memory during reset, what value do we want to be used.
)  (//--------------------------------------//---------------------------------
    // Port A                               // Description(s)
    //--------------------------------------//---------------------------------
    input  wire         clka,              // Write Core Clock
    input  wire         rstna,             // Active-Low Reset
    input  wire         wrena,             // Write Enable
    input  wire         rdena,             // Read Enable
    input  wire [A-1:0] addra,             // Write Address
    input  wire [N-1:0] wdata,             // Write Data
    output wire [N-1:0] rdata,             // Read Data
    //--------------------------------------//---------------------------------
    // Port B (Read)                        // Description(s)
    //--------------------------------------//---------------------------------
    input  wire         clkb,              // Read Core Clock
    input  wire         rstnb,             // Active-Low Reset
    input  wire         wrenb,             // Write Enable
    input  wire         rdenb,             // Read Enable
    input  wire [A-1:0] addrb,             // Address
    input  wire [N-1:0] wdatb,             // Write Data
    output wire [N-1:0] rdatb              // Read Data
);
    //-------------------------------------------------------------------------
    // Register/Wire Declarations
    //-------------------------------------------------------------------------
    reg [N-1:0] memory [D];
    integer i, j, k, l;


    //---------------------------------------------------------------------
    // Synchronous Logic
    //---------------------------------------------------------------------
    generate
        if (RM == 1'b1 && RS == 1'b1) begin : SYNCHRONOUS_RESET
            always @(posedge clka)
                if      (~rstna) for (i = 0; i < D; i = i + 1) memory[i]     <= {N{RV}};
                else if (wrena)                                 memory[addra] <= wdata;

            always @(posedge clkb)
                if      (~rstnb) for (j = 0; j < D; j = j + 1) memory[j]     <= {N{RV}};
                else if (wrenb)                                 memory[addrb] <= wdatb;
        end : SYNCHRONOUS_RESET
        else if (RM == 1'b1 && RS != 1'b1) begin : ASYNCHRONOUS_RESET
            always @(posedge clka, negedge rstna)
                if      (~rstna) for (k = 0; k < D; k = k + 1) memory[k]     <= {N{RV}};
                else if (wrena)                                 memory[addra] <= wdata;

            always @(posedge clkb, negedge rstnb)
                if      (~rstnb) for (l = 0; l < D; l = l + 1) memory[l]     <= {N{RV}};
                else if (wrenb)                                 memory[addrb] <= wdatb;
        end : ASYNCHRONOUS_RESET
        else begin : NO_RESET
            always @(posedge clka)
                if (wrena) memory[addra] <= wdata;

            always @(posedge clkb)
                if (wrenb) memory[addrb] <= wdatb;
        end : NO_RESET
    endgenerate

    //-------------------------------------------------------------------------
    // Combinational Logic
    //-------------------------------------------------------------------------
    assign rdata = rdena ? memory[addra] : {N{RV}};
    assign rdatb = rdenb ? memory[addrb] : {N{RV}};

endmodule
`default_nettype wire