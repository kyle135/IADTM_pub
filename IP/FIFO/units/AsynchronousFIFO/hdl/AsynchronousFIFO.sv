//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//
//---------------------------------------------------------------------------------------
`default_nettype none
module AsynchronousFIFO
#(  //------------------------------------------------//---------------------------------
    // Defines and Parameter(s)                       // Description(s)
    //------------------------------------------------//---------------------------------
    parameter    dataWidth        =  7,               // Data Width
    parameter    addressWidth     =  5,               // Address Width
    parameter    pointerWidth     = addressWidth + 1, // Adjusted Address Width
    parameter    numberOfElements = 32                // Number of elements
)  (//------------------------------------------------//---------------------------------
    // Push Interface                                 // Description(s)
    //------------------------------------------------//---------------------------------
    input  wire                writeClock,            // Core Clock
    input  wire                writeReset,            // Synchronous Reset (Active-Low)
    input  wire                push,                  // Push data into FIFO
    input  wire [dataWidth-1:0]pushData,              // Data to be pushed into FIFO
    output wire                full,                  // FIFO is full
    //------------------------------------------------//---------------------------------
    // Pop Interface                                  // Description(s)
    //------------------------------------------------//---------------------------------
    input  wire                readClock,             // Core Clock
    input  wire                readReset,             // Synchronous Reset (Active-Low)    
    input  wire                pop,                   // Pop data from FIFO
    output wire [dataWidth-1:0]popData,               // Data popped from FIFO
    output wire                empty                  // FIFO is empty
);


    //------------------------------------------------//---------------------------------
    // Local Variable(s)                              // Description(s)
    //------------------------------------------------//---------------------------------
    wire [addressWidth:0] writeAddress;               // Write Address
    wire [addressWidth:0] readAddress;                // Read Address    
    wire [pointerWidth:0] writePointer;               // Write Pointer
    wire [pointerWidth:0] readPointer;                // Read Pointer
    wire [pointerWidth:0] writePointerSynced;         // Write Pointer synchronized to the Read Clock Domain
    wire [pointerWidth:0] readPointerSynced;          // Read Pointer synchronized to the Write Clock Domain

    
    AsynchronousFIFOCompareEmpty 
    #(  //--------------------------------------------//---------------------------------
        // Parameter(s)                               // Description(s)
        //--------------------------------------------//---------------------------------
        .pointerWidth          ( pointerWidth      )  // [PW] Address width in bits
    )
    u_AsynchronousFIFOCompareEmpty    
    (   //--------------------------------------------//---------------------------------
        // Global Signals                             // Description(s)
        //--------------------------------------------//---------------------------------
        .readClock             ( readClock         ), // [I][ 1] Core Clock
        .readReset             ( readReset         ), // [I][ 1] Synchronous Reset (Active-Low)
        //--------------------------------------------//---------------------------------
        // Pointer Stuffs                             // Description(s)
        //--------------------------------------------//---------------------------------
        .writePointerEmpty     ( full              ), // [O][ 1]
        .readAddress           ( readAddress       ), // [O][AW]
        .writePointer          ( readPointer       ), // [O][PW]
        .writePointerSynced    ( readPointerSynced ), // [O][PW]
        .incrementWritePointer ( pop               )  // [I][ 1]
    );
    

    AsynchronousFIFOCompareFull
    #(  //--------------------------------------------//---------------------------------
        // Parameter(s)                               // Description(s)
        //--------------------------------------------//---------------------------------
        .pointerWidth          ( pointerWidth      )  // [PW] Address width in bits
    ) 
    u_AsynchronousFIFOCompareFull
    (                        //
        //--------------------------------------------//---------------------------------
        // Global Signals                             // Description(s)
        //--------------------------------------------//---------------------------------
        .writeClock            ( writeClock        ), // [I][ 1] Core Clock
        .writeReset            ( writeReset        ), // [I][ 1] Synchronous Reset (Active-Low)    
        //--------------------------------------------//---------------------------------
        // Pointer Stuffs                             // Description(s)
        //--------------------------------------------//---------------------------------
        .writePointerFull      ( full              ), //
        .writeAddress          ( writeAddress      ), // [O][AW]
        .writePointer          ( writePointer      ), // [O][PW]
        .writePointerSynced    ( writePointerSynced), // [O][PW]
        .incrementReadPointer  ( push              )  //
    );

    xNStageSynchronizer
    #(  //--------------------------------------------//---------------------------------
        // Parameter(s)                               // Description(s)
        //--------------------------------------------//---------------------------------
        .dataWidth             ( pointerWidth      )  // [PW] Address width in bits
    ) 
    u_xNStageSynchronizer_wr
    (                        
        //--------------------------------------------//---------------------------------------------------------
        // Inputs to be synchronized                  // Direction, Size  Description(s)
        //--------------------------------------------//---------------------------------------------------------
        .destinationClock      ( readClock         ), // [I][ 1]
        .destinationReset      ( readReset         ), // [I][ 1]
        .sourcePointer         ( writePointer      ), // [I][PW]
        .destinationPointer    ( writePointerSynced)  // [I][PW]
    );


    xNStageSynchronizer
    #(  //---------------------------------------------------------
        // Parameter(s)                                        // Description(s)
        //--------------------------------------------------//---------------------------------------------------------
        .pointerWidth                ( pointerWidth        )    // [PW] Address width in bits
    ) 
    u_xNStageSynchronizer_rd    
    (   //--------------------------------------------------//---------------------------------------
        //                                                    //
        //--------------------------------------------------//---------------------------------------------------------
        .destinationClock            ( writeClock        ),    // [I][ 1]
        .destinationReset            ( writeReset        ),    // [I][ 1]
        .sourcePointer                ( readPointer        ),    // [I][PW]
        .destinationPointer            ( readPointerSynced    )    // [I][PW]
    );


    MemorySimpleDualPort #(                                //
        //--------------------------------------------------//---------------------------------------------------------
        // Parameter(s)                                        // Description(s)
        //--------------------------------------------------//---------------------------------------------------------
        .dataWidth                    ( dataWidth            ),    // [DW] Data Width in bits
        .addressWidth                ( addressWidth        ),    // [AW] Address Width in bits
        .numberOfElements            ( numberOfElements    )    // [NE] Number of Elements
    ) u_MemorySimpleDualPort        (                        //
        //--------------------------------------------------//---------------------------------------------------------
        // Write Interface                                    // Direction, Size & Description
        //--------------------------------------------------//---------------------------------------------------------
        .writeClock                    ( writeClock        ),    // [I][ 1] Core Clock
        .writeReset                    ( writeReset        ),    // [I][ 1] Synchronous Reset (Active-High)
        .write                        ( push                ),    // [I][ 1] Write data enable to memory
        .writeAddress                ( writeAddress        ),    // [I][AW] Address to write data to in memory
        .writeData                    ( pushData            ),    // [I][DW] Data to be written memory
        //--------------------------------------------------//---------------------------------------------------------
        // Read Interface                                    // Direction, Size & Description
        //--------------------------------------------------//---------------------------------------------------------
        .readClock                    ( readClock            ),    // [I][ 1] Core Clock
        .readReset                    ( readReset            ),    // [I][ 1] Synchronous Reset (Active-High)
        .readAddress                ( readAddress        ),    // [I][AW] Address to read data from in memory
        .readData                    ( popData            )    // [O][DW] Data read from memory
    );


endmodule : AsynchronousFIFO
`default_nettype wire
