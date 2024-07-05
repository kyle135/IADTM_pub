
`default_nettype none
module SynchronousFIFO
#(  //------------------------------//-------------------------------------------------------------
    // Defines and Parameter(s)     //
    //------------------------------//-------------------------------------------------------------
    parameter integer N =  7,       // Data Width
    parameter integer D = 32,       // Number of elements
    parameter integer A = $clog2(D) // Address Width
)  (//------------------------------//-------------------------------------------------------------
    // I/O Definition(s)            //
    //------------------------------//-------------------------------------------------------------
    // Global Signals               //-------------------------------------------------------------
    input  wire         clk,        // Core Clock
    input  wire         rstn,       // Synchronous Reset (Active-Low)
    // Push Interface               //-------------------------------------------------------------
    input  wire         push,       // Push data into FIFO
    input  wire [N-1:0] pushData,   // Data to be pushed into FIFO
    output wire         full,       // FIFO is full
    // Pop Interface                //-------------------------------------------------------------
    input  wire         pop,        // Pop data from FIFO
    output wire [N-1:0] popData,    // Data popped from FIFO
    output wire         empty       // FIFO is empty
);

    //---------------------------------------------------------------------------------------------
    // Local Variable(s)
    //---------------------------------------------------------------------------------------------
    wire [A:0]  writeAddress;       // Write Address
    wire [A:0]  readAddress;        // Read Address

    //---------------------------------------------------------------------------------------------
    // Module Instances(s)
    //---------------------------------------------------------------------------------------------
    FIFOPointer
    #(  //------------------------------------//---------------------------------------------------
        // Parameters                         // Description(s)
        //------------------------------------//---------------------------------------------------
        .A           ( A                   )  // Number of Elements
    )
    u_FIFOPointerRead 
    (   //------------------------------------//---------------------------------------------------
        // Global Signal(s)                   // Direction, Size & Description
        //------------------------------------//---------------------------------------------------
        .clk         ( clk                 ), // [I][ 1] Core Clock
        .rstn        ( rstn                ), // [I][ 1] Synchronous Reset (Active-High)
        //------------------------------------//---------------------------------------------------
        // Pointer Interface                  // Direction, Size & Description
        //------------------------------------//---------------------------------------------------    
        .pointer    ( readAddress          ), // [O][A+1]
        .increment  ( pop                  )  // [I][1]
    );

    FIFOPointer
    #(  //------------------------------------//---------------------------------------------------
        // Parameters                         // Description(s)
        //------------------------------------//---------------------------------------------------
        .A           ( A                   )  // Number of Elements
    )
    u_FIFOPointerWrite
    (   //------------------------------------//---------------------------------------------------
        // Global Signal(s)                   // Direction, Size & Description
        //------------------------------------//---------------------------------------------------
        .clk         ( clk                 ), // [I][ 1] Core Clock
        .rstn        ( rstn                ), // [I][ 1] Synchronous Reset (Active-High)
        //------------------------------------//---------------------------------------------------
        // Pointer Interface                  // Direction, Size & Description
        //------------------------------------//---------------------------------------------------    
        .pointer    ( writeAddress         ), // [O][A+1]
        .increment  ( push                 )  // [I][1]
    );

    FIFOPointerCompare
    #(  //------------------------------------//---------------------------------------------------
        // Parameters                         // Description(s)
        //------------------------------------//---------------------------------------------------
        .A           ( A                   )  // Address Width (32 Elements)
    ) 
    u_FIFOPointerCompare
    (   //------------------------------------//---------------------------------------------------
        // Pointer(s)                         // Direction, Size and Description
        //------------------------------------//---------------------------------------------------
        .writeAddress( writeAddress        ), // [I][A+1] Write Pointer
        .readAddress ( readAddress         ), // [I][A+1] Read Pointer
        .empty       ( empty               ), // [O][1] FIFO is empty
        .full        ( full                )  // [O][1] FIFO is full
    );

    MemorySimple
    #(  //------------------------------------//---------------------------------------------------
        // Parameter(s)                       // Description(s)
        //------------------------------------//---------------------------------------------------
        .N           ( N                   ), // Data Width
        .A           ( A                   ), // Address Width
        .D           ( D                   )  // Number of Elements
    )                                         //
    u_memory                                  //
    (   //------------------------------------//---------------------------------------------------
        // Global Signal(s)                   // Direction, Size & Description
        //------------------------------------//---------------------------------------------------
        .clk         ( clk                 ), // [I][1] Core Clock
        .rstn        ( rstn                ), // [I][1] Synchronous Reset (Active-High)
        //------------------------------------//---------------------------------------------------
        // Write Interface                    // Direction, Size & Description
        //------------------------------------//---------------------------------------------------
        .wren        ( push                ), // [I][1] Write data enable to memory
        .waddr       ( writeAddress[A-1:0] ), // [I][A] Address to write data to in memory
        .wdata       ( pushData            ), // [I][N] Data to be written memory
        //------------------------------------//---------------------------------------------------
        // Read Interface                     // Direction, Size & Description
        //------------------------------------//---------------------------------------------------
        .rden        ( pop                 ), //
        .raddr       ( readAddress[A-1:0]  ), // [I][A] Address to read data from in memory
        .rdata       ( popData             )  // [O][N] Data read from memory
    );

endmodule : SynchronousFIFO
`default_nettype wire
