//---------------------------------------------------------------------------------------
// Licensing:       It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed under
//                  Creative Commons Attribution 4.0 International 
//
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     APBInterface
// Description:
//---------------------------------------------------------------------------------------
interface APBInterface
#(  //------------------------------//-------------------------------------------------------------
    // Parameter(s)                 // Description(s)
    //------------------------------//-------------------------------------------------------------
    parameter integer N = 32,       // Data path width in bits.
    parameter integer A = 32,       // Address with in bits.
    parameter integer S = 4,        // Number of slaves.
    parameter integer I = 0         // Current Slave ID.
)  (//------------------------------//-------------------------------------------------------------
    //                              // Description(s)
    //------------------------------//-------------------------------------------------------------
    input wire PCLK,                // Clock. The rising edge of PCLK times all transfers on the APB.
    input wire PRESETn              // Reset. The APB reset signal is active LOW. This signal is 
    //                              // normally connected directly to the system bus reset signal.
);                                  // 

    import APB_hdl_pkg::*;

    //------------------------------//-------------------------------------------------------------
    // Interface Signals            // Description(s)
    //------------------------------//-------------------------------------------------------------
    logic [A-1:0] PADDR;            // Address. This is the APB address bus. It can be up to 32 
    //                              // bits wide and is driven by the peripheral bus bridge unit.
    logic [  2:0] PPROT;            // Protection type. This signal indicates the normal, 
    //                              // privileged, or secure protection level of the transaction 
    //                              // and whether the transaction is a data access or an 
    //                              // instruction access.
    logic [S-1:0] PSELx;            // Select. The APB bridge unit generates this signal to each 
    //                              // peripheral bus slave. It indicates that the slave device is 
    //                              // selected and that a data transfer is required. There is a 
    //                              // PSELx signal for each slave.
    logic         PENABLE;          // Enable. This signal indicates the second and subsequent 
    //                              // cycles of an APB transfer.
    logic         PWRITE;           // Direction. This signal indicates an APB write access when 
    //                              // HIGH and an APB read access when LOW.
    logic [N-1:0] PWDATA;           // Write data. This bus is driven by the peripheral bus bridge 
    //                              // unit during write cycles when PWRITE is HIGH. This bus can 
    //                              // be up to 32 bits wide.
    logic [  3:0] PSTRB;            // Write strobes. This signal indicates which byte lanes to 
    //                              // update during a write transfer. There is one write strobe 
    //                              // for each eight bits of the write data bus. Therefore, 
    //                              // PSTRB[n] corresponds to PWDATA[(8n + 7):(8n)]. Write strobes
    //                              // must not be active during a read transfer.
    logic         PREADY;           // Ready. The slave uses this signal to extend an APB transfer.
    logic [N-1:0] PRDATA;           // Read Data. The selected slave drives this bus during read 
    //                              // cycles when PWRITE is LOW. This bus can be up to 32-bits wide.
    logic         PSLVERR;          // This signal indicates a transfer failure. APB peripherals 
    //                              // are not required to support the PSLVERR pin. This is true 
    //                              // for both existing and new APB peripheral designs. Where a 
    //                              // peripheral does not include this pin then the appropriate
    //                              // input to the APB bridge is tied LOW.



    task automatic wait_for_timeout;
    ref    logic signal;
    input  logic value;
    input  time  timeout_value;
    output logic timeout;
    begin
        timeout = 1'b0;
        fork
            begin
                fork
                    begin
                        #timeout_value;
                        timeout = '1;
                    end
                join_none
                wait(signal === value || timeout);
                disable fork;
            end
        join
    end
    endtask : wait_for_timeout

    //-------------------------------------------------------------------------
    // APB Master Transactions
    //-------------------------------------------------------------------------
    // Write transfer with no wait states.
    task basic_write_no_wait_states;
    input  logic [A-1:0] write_address;
    input  logic [N-1:0] write_data;
    input  logic [S-1:0] slave_select;
    output logic         slave_error;
    begin
        // Broadcast the transactiona and data to the slave.
        PADDR   = write_address;
        PSTRB   = 4'b0000;
        PWRITE  = apb_direction_t'(APB_WRITE);
        PWDATA  = write_data;
        PSELx   = slave_select;
        PENABLE = apb_enable_t'(APB_DISABLE);
        // Wait for ready to be asserted by the slame.
        fork
            while (PREADY === apb_ready_t'(APB_NOT_READY)) @(posedge PCLK);
            // Add timeout
        join_any
        // Begin the write.
        PADDR   = write_address;
        PWRITE  = apb_direction_t'(APB_WRITE);
        PSTRB   = 4'b1111;
        PWDATA  = write_data;
        PSELx   = slave_select;
        PENABLE = apb_enable_t'(APB_ENABLE);
        // Terminate the write
        @(posedge PCLK);
        PADDR   = {A{1'b0}};
        PWRITE  = apb_direction_t'(APB_WRITE);
        PSTRB   = 4'b0000;
        PWDATA  = {N{1'b0}};
        PSELx   = {S{1'b0}};
        PENABLE = apb_enable_t'(APB_DISABLE);
    end
    endtask : basic_write_no_wait_states

    // Read transfer with no wait states
    task basic_read_no_wait_states;    
    input  logic [N-1:0] read_address;
    input  logic [S-1:0] slave_select;
    output logic [N-1:0] read_data;
    output logic         slave_error;
    begin
        // Broadcast the transactiona and data to the slave.
        PADDR     = read_address;
        PWRITE    = apb_direction_t'(APB_READ);
        read_data = PRDATA;
        PSELx     = slave_select;
        PENABLE   = apb_enable_t'(APB_DISABLE);
        // Wait for ready to be asserted by the slame.
        fork
            while (PREADY === apb_ready_t'(APB_NOT_READY)) @(posedge PCLK);
            // Add timeout
        join_any
        PADDR     = read_address;
        PWRITE    = apb_direction_t'(APB_READ);
        read_data = PRDATA;
        PSELx     = slave_select;
        PENABLE   = apb_enable_t'(APB_ENABLE);
        // Terminate the write
        @(posedge PCLK);
        PADDR     = {A{1'b0}};
        PWRITE    = apb_direction_t'(APB_READ);
        PWDATA    = {N{1'b0}};
        PSELx     = {S{1'b0}};
        PENABLE   = apb_enable_t'(APB_DISABLE);
    end
    endtask : basic_read_no_wait_states

    //-------------------------------------------------------------------------
    // APB Slave Transfers
    //-------------------------------------------------------------------------
    task capture_transfer;
    output logic [A-1:0] address;
    output logic         write_read_n;
    output logic [N-1:0] data;
    begin
        while(~PSELx[I]) @(posedge PCLK);
        address = PADDR;
        write_read_n = PWRITE;
        while ( PSELx[I] === apb_select_t'(APB_SELECTED) | 
                PENABLE  === apb_enable_t'(APB_DISABLE)  | 
                PREADY   === apb_ready_t'(APB_NOT_READY))
            @(posedge PCLK);

        if (PWRITE === apb_direction_t'(APB_WRITE)) data = PWDATA;
        else                                        data = PRDATA;
    end
    endtask : capture_transfer

endinterface : APBInterface
