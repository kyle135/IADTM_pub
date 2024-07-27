//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//-----------------------------------------------------------------------------
`timescale 1ns / 1ps
module FixedPointSubtract_tb
#(  //-------------------------------------------------------------------------
    // Parameter(s)
    //-------------------------------------------------------------------------
    parameter integer N     = 32,
    parameter integer O     = $clog2(N)
);


    //-------------------------------------------------------------------------
    // Local Parameters
    //-------------------------------------------------------------------------
    localparam MAX_DELAY=150;

    //-------------------------------------------------------------------------
    // Local TestBench Signals
    //-------------------------------------------------------------------------
    bit           clk;
    bit   [N-1:0] a;
    bit   [N-1:0] b;
    bit           carry_in;
    logic [N-1:0] c;
    logic [N-1:0] carry_out;
    
    FixedPointSubtract
    #(  //-----------------------------//------------------------------------
        // Parameter(s)                // Description(s)
        //-----------------------------//------------------------------------
        .N          ( 32            ), // Data path width in bits.
        .ALGORITHM  ("RippleCarrySubtraction")  //
    )                                  //
    u_DUT                              //
    (   //-----------------------------//------------------------------------
        // Inputs                      // Description(s)
        //-----------------------------//------------------------------------
        .a          ( a             ), // [I][N]
        .b          ( b             ), // [I][N]
        .carry_in   ( carry_in      ), // [I][1]
        //-----------------------------//------------------------------------
        // Inputs                      // Description(s)
        //-----------------------------//------------------------------------
        .carry_out  ( carry_out     ), //
        .c          ( c             )  //
    );    


    initial begin
        // Reset Values
        clk = 1;
        forever
            #5ns clk <= ~clk;
    end

    initial begin        
        repeat (10) @(posedge clk);
        $display("Out of simulated reset.");

        $display("Test Case 1");
        a = 1;
        b = 0;
        carry_in = 0;
        @(posedge clk);
        $display("0x%08x - 0x%08x = 0x%08x", a, b, c);
        
        $display("Test Case 2");
        a = 0;
        b = 1;
        carry_in = 0;
        @(posedge clk);
        $display("0x%08x - 0x%08x = 0x%08x", a, b, c);

        $display("Test Case 3");
        a =  0;
        b =  0;
        carry_in = 0;
        @(posedge clk);
        $display("0x%08x - 0x%08x = 0x%08x", a, b, c);
        
        $display("Test Case 4");
        a =  0;
        b = -1;
        carry_in = 0;
        @(posedge clk);
        $display("0x%08x - 0x%08x = 0x%08x", a, b, c);

        $display("Test Case 5");
        a = -1;
        b =  0;
        carry_in = 0;        
        @(posedge clk);
        $display("0x%08x - 0x%08x = 0x%08x", a, b, c);

        $finish;
    end


endmodule : FixedPointSubtract_tb