//---------------------------------------------------------------------------------------
// Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
//                  Creative Commons Attribution 4.0 International.
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     APBSlaveMemory
// Description:     Parameterizeable Memory that sits on a APB Bus.
//---------------------------------------------------------------------------------------
`default_nettype none
module APBSlaveMemory
#(  //----------------------------------//-----------------------------------------------
    // Parameter(s)                     // Description(s)
    //----------------------------------//-----------------------------------------------
    parameter integer     N = 32,       // Width of Data bus in bits.
    parameter integer     D = 1024,     // Depth of memory
    parameter integer     A = $clog2(D),// Width of Address bus in bits.
    parameter integer     B = 4,        // Number of byte lanes.
    parameter integer     O = 4,        // Width of Slave Select bus in bits.
    parameter bit [O-1:0] I = 1         // ID of Slave for select line.
)  (//----------------------------------//-----------------------------------------------
    // Global Signals                   // Description(s)
    //----------------------------------//-----------------------------------------------
    input  wire         pclk,           // Clock
    input  wire         presetn,        // Reset (Active LOW)
    //----------------------------------//-----------------------------------------------
    // Interface Signals                // Description(s)
    //----------------------------------//-----------------------------------------------
    input  wire [A-1:0] paddr,          // Address
    input  wire [  2:0] pprot,          // Protection type
    input  wire [O-1:0] pselx,          // Select
    input  wire         penable,        // Enable
    input  wire         pwrite,         // Direction
    input  wire [N-1:0] pwdata,         // Write data
    input  wire [B-1:0] pstrb,          // Write strobes
    output reg          pready,         // Ready
    output wire [N-1:0] prdata,         // Read Data
    output reg          pslverr         // Transfer failure
);

    import APB_hdl_pkg::*;

    //-------------------------------------------------------------------------
    // Parameters and typedefs
    //-------------------------------------------------------------------------
    typedef enum reg [1:0] {
        APB_IDLE  = 'd0,
        APB_READ  = 'd1,
        APB_WRITE = 'd2,
        APB_ERROR = 'd3
    } apb_slave_state_t;

    //-------------------------------------------------------------------------
    // Local net declaration
    //-------------------------------------------------------------------------
    wire pwren;
    wire prden;
    wire [N/B-1:0] pwdata_strb_byte_0;
    wire [N/B-1:0] pwdata_strb_byte_1;
    wire [N/B-1:0] pwdata_strb_byte_2;
    wire [N/B-1:0] pwdata_strb_byte_3;
    wire [N  -1:0] pwdata_strb;
    apb_slave_state_t apb_slave_state;

    //-------------------------------------------------------------------------
    // Combinational and Continuous Logic
    //-------------------------------------------------------------------------
    assign pwren =  pwrite & penable & pready;
    assign prden = ~pwrite & penable & pready;
    assign pwdata_strb_byte_0 = pstrb[0] ? pwdata[ 7: 0] : prdata[ 7: 0];
    assign pwdata_strb_byte_1 = pstrb[1] ? pwdata[15: 8] : prdata[15:8];
    assign pwdata_strb_byte_2 = pstrb[2] ? pwdata[23:16] : prdata[23:16];
    assign pwdata_strb_byte_3 = pstrb[3] ? pwdata[31:24] : prdata[31:24];
    assign pwdata_strb = {pwdata_strb_byte_3, pwdata_strb_byte_2,
                          pwdata_strb_byte_1, pwdata_strb_byte_0};
    //-------------------------------------------------------------------------
    // Synchronous Logic
    //-------------------------------------------------------------------------
    always@(posedge pclk, negedge presetn) begin
        if (~presetn) begin
            pready          <= apb_ready_t'(APB_READY);
            pslverr         <= apb_error_t'(APB_NO_ERROR);
            apb_slave_state <= APB_IDLE;
        end
        else begin
            case (apb_slave_state)
                APB_IDLE: begin
                    if      (pselx[I] &  pwrite) begin
                        pready          <= apb_ready_t'(APB_READY);
                        pslverr         <= apb_error_t'(APB_NO_ERROR);
                        apb_slave_state <= APB_WRITE;
                    end
                    else if (pselx[I] & ~pwrite) begin
                        pready          <= apb_ready_t'(APB_READY);
                        pslverr         <= apb_error_t'(APB_NO_ERROR);
                        apb_slave_state <= APB_READ;
                    end
                    else begin
                        pready          <= apb_ready_t'(APB_NOT_READY);
                        pslverr         <= apb_error_t'(APB_NO_ERROR);
                        apb_slave_state <= APB_IDLE;
                    end
                end
                APB_READ: begin
                    if      (pselx[I] & ~pwrite & penable) begin
                        pready          <= apb_ready_t'(APB_NOT_READY);
                        pslverr         <= apb_error_t'(APB_NO_ERROR);
                        apb_slave_state <= APB_IDLE;
                    end
                    else begin
                        pready          <= apb_ready_t'(APB_READY);
                        pslverr         <= apb_error_t'(APB_NO_ERROR);
                        apb_slave_state <= APB_READ;
                    end
                end
                APB_WRITE: begin
                    if      (pselx[I] & pwrite & penable) begin
                        pready          <= apb_ready_t'(APB_NOT_READY);
                        pslverr         <= apb_error_t'(APB_NO_ERROR);
                        apb_slave_state <= APB_IDLE;
                    end
                    else begin
                        pready          <= apb_ready_t'(APB_NOT_READY);
                        pslverr         <= apb_error_t'(APB_NO_ERROR);
                        apb_slave_state <= APB_WRITE;
                    end
                end
                APB_ERROR: begin
                    pready              <= apb_ready_t'(APB_NOT_READY);
                    pslverr             <= apb_error_t'(APB_ERROR);
                    apb_slave_state     <= APB_IDLE;
                end
                default: begin
                    pready              <= apb_ready_t'(APB_NOT_READY);
                    pslverr             <= apb_error_t'(APB_NO_ERROR);
                    apb_slave_state     <= APB_IDLE;
                end
           endcase
        end
    end

    //-------------------------------------------------------------------------
    // Module Instances
    //-------------------------------------------------------------------------
    MemorySimple
    #(  //-----------------------//--------------------------------------------
        // Parameters            // Desscription(s)
        //-----------------------//--------------------------------------------
        // Memory                //--------------------------------------------
        .N      ( N           ), // The data path width in bits.
        .D      ( D           ), // The number of elements in the RAM (must be a power of two).
        .A      ( A           ), // The width, in bits, of the address for specifying the memory location to read or write
        // Reset                 //--------------------------------------------
        .RM     ( 0           ), // If we want the memory to be reset with know values set to 1.
        .RS     ( 0           ), // Set to 1 if a synchronous reset of the memory is
        .RV     ( 0           )  // If we are filling the contents of the memory during reset, what value do we want to be used.
    )                            //
    u_MemorySimple               //
    (   //-----------------------//--------------------------------------------
        // Port                  // Desscription(s)
        //-----------------------//--------------------------------------------
        .clk    ( pclk        ), // [I][1] Core Clock
        .rstn   ( presetn     ), // [I][1] Active-Low Reset
        .wren   ( pwren       ), // [I][1] Write Enable
        .waddr  ( paddr       ), // [I][A] Write Address
        .wdata  ( pwdata_strb ), // [I][N] Write Data
        .rden   ( 1'b1        ), // [I][1] Read Enable
        .raddr  ( paddr       ), // [I][A] Write Address
        .rdata  ( prdata      )  // [O][N] Read Data
    );

endmodule : APBSlaveMemory
`default_nettype wire
