//---------------------------------------------------------------------------------------
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Description:  
//---------------------------------------------------------------------------------------
`default_nettype none
module FIFOPointerCompare
#(  //------------------------------//---------------------------------------------------
    // Parameters                   // Description(s)
    //------------------------------//---------------------------------------------------
    parameter integer A = 4         //
)  (//------------------------------//---------------------------------------------------
    //                              // Description(s)
    //------------------------------//---------------------------------------------------
    input  wire [A:0] writeAddress, //
    input  wire [A:0] readAddress,  //
    output wire       empty,        //
    output wire       full          //
);

    assign empty = writeAddress == readAddress;
    assign full = (writeAddress[A-1:0] == readAddress[A-1:0]) & (writeAddress[A] ^ readAddress[A]);


endmodule : FIFOPointerCompare
`default_nettype wire
