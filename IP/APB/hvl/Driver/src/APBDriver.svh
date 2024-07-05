`ifndef __APBDRIVER__SVH
    `define __APBDRIVER__SVH
//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf
// Module Name: APBDriver
// Description: UVM Driver
// · Receives transactions from the Sequencer.
// · Sends transactions to the interface.
//-----------------------------------------------------------------------------
class  APBDriver extends uvm_driver #( APBSequenceItem);
    typedef  APBDriver this_type_t;
    `uvm_component_utils( APBDriver)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    virtual  APBInterface                apb_intf;
    APBConfig                            apb_cfg; 
    uvm_analysis_port #(APBSequenceItem) drv_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new(string name = "APBDriver", uvm_component parent);
       super.new(name, parent);
 
       drv_ap = new("drv_ap", this);
    endfunction : new
 
    function void build_phase(uvm_phase phase);
       super.build_phase(phase);

        if (!uvm_config_db#(virtual APBInterface)::get(this, "", "apb_intf", apb_intf))
            `uvm_fatal("APBDriver", {"Virtual interface must be set for ", get_full_name ( ), "apb_intf"})
        if (!uvm_config_db#(APBConfig)::get(this, "", "apb_cfg", apb_cfg))
            `uvm_fatal("APBDriver", {"Configuration Object be set for ", get_full_name ( ), "apb_cfg"})
    endfunction : build_phase


    // /// Reset Phase Task, reset is Active LOW
    // task reset_phase(uvm_phase phase);
    //     phase.raise_objection(this);
    //     apb_intf.rstn = 1'b0;
    //     #13;
    //     apb_intf.rstn = 1'b1;
    //     phase.drop_objection(this);
    //   endtask: reset_phase 

    task run_phase ( uvm_phase phase );
        wait(apb_intf.rstn === 1'b1);
        @(posedge apb_intf.clk);
        drive( );
    endtask : run_phase
 
    virtual task drive( );
        // Local Task Variables
        APBSequenceItem item; // Declare a sequence_item handle.
 
        forever begin
            // Requence a new transaction.
            seq_item_port.get_next_item(item); 
            // Send transaction to DUT.
            // apb_intf.drive_inputs (     //
            //     item.Instruction,       //
            //     item.ProgramCounter,    //
            //     item.GPR_a,             //
            //     item.GPR_b,             //
            //     item.GPR_c,             //
            //     item.SPR_h,             //
            //     item.SPR_l              //
            // );
            // Driver is done with this handle.
            seq_item_port.item_done();

            drv_ap.write(item);
            @(posedge apb_intf.clk);
        end
    endtask : drive
 endclass :  APBDriver
 `endif // __APBDRIVER__SVH