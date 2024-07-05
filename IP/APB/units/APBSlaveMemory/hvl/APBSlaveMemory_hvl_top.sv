//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International 
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf
// Module Name: APBSlaveMemory_hvl_top
// Description: HVL top for UVM Dual Top.
//-----------------------------------------------------------------------------
module APBSlaveMemory_hvl_top;
    import uvm_pkg::*;
    import APB_hvl_pkg::*;
    


    initial begin
        uvm_config_db #(virtual APBInterface #(32, 1024, 1))::set(
            null, 
            "uvm_test_top", 
            "APBSlaveMemory_hdl_top.u_APB_intf", 
            APBSlaveMemory_hdl_top.u_APB_intf
        );

        run_test("APBSlaveMemoryTest");
    end

endmodule : APBSlaveMemory_hvl_top
