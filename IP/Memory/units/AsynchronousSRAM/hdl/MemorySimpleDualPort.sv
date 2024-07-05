//-------------------------------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Design Name:  Memory
// Module Name:  MemorySimpleDualPort
// Description:  
// Dependencies: 
// · None
//-------------------------------------------------------------------------------------------------
`default_nettype none
module MemorySimpleDualPort
#(  //-------------------------//------------------------------------------------------------------
    // Parameters              // Desscription(s)
    //-------------------------//------------------------------------------------------------------
    // Memory Structure        //------------------------------------------------------------------
    parameter N  = 'd8,        // The width, in bits, of the data being stored in the memory locations.
    parameter D  = 'd32,       // The number of elements in the RAM (must be a power of two).
    parameter A  = $clog2(D),  // The width, in bits, of the address
    // Reset Configuration     //------------------------------------------------------------------
    parameter RM = 1'b1,       // If we want the memory to be reset with know values set to 1.
    parameter RS = 1'b1,       // Set to 1 if a synchronous reset of the memory is
    parameter RV = 1'b1        // If we are filling the contents of the memory during reset, what value do we want to be used.
)  (//-------------------------//------------------------------------------------------------------
    // Port A (Write)          // Description(s)
    //-------------------------//------------------------------------------------------------------
    input  wire         clka,  // Write Core Clock
    input  wire         rstna, // Active-Low Reset
    input  wire         wrena, // Write Enable
    input  wire [A-1:0] addra, // Write Address
    input  wire [N-1:0] wdata, // Write Data
    //-------------------------//------------------------------------------------------------------
    // Port B (Read)           // Description(s)
    //-------------------------//------------------------------------------------------------------
    input  wire         clkb,  // Read Core Clock
    input  wire         rstnb, // Active-Low Reset
    input  wire         rdenb, // Read Enable
    input  wire [A-1:0] addrb, // Read Address
    output wire [N-1:0] rdatb  // Read Data
);
    //---------------------------------------------------------------------------------------------
    // Register/Wire Declarations
    //---------------------------------------------------------------------------------------------
    reg [N-1:0] memory [D];
    integer i, j;
    
    //---------------------------------------------------------------------------------------------
    // Generate memories
    //---------------------------------------------------------------------------------------------

    generate
        //-----------------------------------------------------------------------------------------
        // Synchronous Logic
        //-----------------------------------------------------------------------------------------
        if (RM == 1'b1 && RS == 1'b1) begin : SYNCHRONOUS_RESET
            always @(posedge clka)
                if      (~rstna) for (i = 0; i < D; i = i + 1) memory[i] <= {N{RV}};
                else if (wrena)                                 memory[addra] <= wdata;
        end : SYNCHRONOUS_RESET
        else if (RM == 1'b1 && RS != 1'b1) begin : ASYNCHRONOUS_RESET
            always @(posedge clka, negedge rstna)
                if      (~rstna) for (j = 0; j < D; j = j + 1) memory[j] <= {N{RV}};
                else if (wrena)                                 memory[addra] <= wdata;
        end : ASYNCHRONOUS_RESET
        else begin : NO_RESET
            always @(posedge clka)
                if (wrena) memory[addra] <= wdata;
        end : NO_RESET
    endgenerate

    //---------------------------------------------------------------------------------------------
    // Combinational Logic
    //---------------------------------------------------------------------------------------------
    assign rdatb = rdenb ? memory[addrb] : {N{RV}};

endmodule : MemorySimpleDualPort
`default_nettype wire
