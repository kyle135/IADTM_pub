//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is 
//               licensed under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf
// Module Name:  APBSlaveMemory_hdl_top
// Description:   HDL top for UVM Dual Top.
//-----------------------------------------------------------------------------
module APBSlaveMemory_hdl_top;
    parameter integer N = 32;
    parameter integer D = 1024;
    parameter integer A = $clog2(D);
    parameter integer B = 4;
    parameter integer O = 1;

    bit pclk;
    bit presetn;

    APBInterface #(N, D, 1) u_APB_intf (pclk, presetn);

    APBSlaveMemory
    #(  //------------------------------//-------------------------------------
        // Parameter(s)                 // Description(s)
        //------------------------------//-------------------------------------
        .N      ( N                  ), // Width of Data bus in bits.
        .D      ( D                  ), // Depth of memory
        .A      ( A                  ), // Width of Address bus in bits.
        .B      ( B                  ), // Number of byte lanes.
        .O      ( O                  ), // Width of Slave Select bus in bits.
        .I      ( 0                  )  // ID of Slave for select line.
    )                                   //
    u_APBSlaveMemory                    //
    (   //------------------------------//-------------------------------------
        // Global Signals               // Direciton, Size &  Description(s)
        //------------------------------//-------------------------------------
        .pclk   ( pclk               ), // [I][1] Clock
        .presetn( presetn            ), // [I][1] Reset (Active LOW)
        //------------------------------//-------------------------------------
        // APB Bus                      // Direciton, Size & Description(s)
        //------------------------------//-------------------------------------
        .paddr  ( u_APB_intf.PADDR   ), // [I][A] Address
        .pprot  ( u_APB_intf.PPROT   ), // [I][1] Protection type
        .pselx  ( u_APB_intf.PSELx   ), // [I][O] Select
        .penable( u_APB_intf.PENABLE ), // [I][1] Enable
        .pwrite ( u_APB_intf.PWRITE  ), // [I][1] Direction
        .pwdata ( u_APB_intf.PWDATA  ), // [I][N] Write data
        .pstrb  ( u_APB_intf.PSTRB   ), // [I][B] Write strobes
        .pready ( u_APB_intf.PREADY  ), // [O][1] Ready
        .prdata ( u_APB_intf.PRDATA  ), // [O][N] Read Data
        .pslverr( u_APB_intf.PSLVERR )  // [O][1] Transfer failure
    );


    // Free running clock
    initial begin
        pclk = 1'b0;
        forever begin
            #5 pclk = ~pclk;
        end
    end

    // Reset
    initial begin
        presetn     = 1'b0;
        #50 presetn = 1'b1;
    end

endmodule : APBSlaveMemory_hdl_top
