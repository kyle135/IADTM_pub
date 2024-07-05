`ifndef __ALUDRIVER__SVH
    `define __ALUDRIVER__SVH
//-------------------------------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
// Module Name:     ALUDriver
// Description:     UVM Driver
// · Receives transactions from the Sequencer.
// · Sends transactions to the interface.
//-------------------------------------------------------------------------------------------------
class  ALUDriver extends uvm_driver #( ALUSequenceItem);
    typedef  ALUDriver this_type_t;
    `uvm_component_utils( ALUDriver)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    virtual  ALUInterface                alu_intf;
    ALUConfig                            alu_cfg; 
    uvm_analysis_port #(ALUSequenceItem) drv_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new(string name = "ALUDriver", uvm_component parent);
       super.new(name, parent);
 
       drv_ap = new("drv_ap", this);
    endfunction : new
 
    function void build_phase(uvm_phase phase);
       super.build_phase(phase);

        if (!uvm_config_db#(virtual ALUInterface)::get(this, "", "alu_intf", alu_intf))
            `uvm_fatal("ALUDriver", {"Virtual interface must be set for ", get_full_name ( ), "alu_intf"})
        if (!uvm_config_db#(ALUConfig)::get(this, "", "alu_cfg", alu_cfg))
            `uvm_fatal("ALUDriver", {"Configuration Object be set for ", get_full_name ( ), "alu_cfg"})
    endfunction : build_phase


    // /// Reset Phase Task, reset is Active LOW
    // task reset_phase(uvm_phase phase);
    //     phase.raise_objection(this);
    //     alu_intf.rstn = 1'b0;
    //     #13;
    //     alu_intf.rstn = 1'b1;
    //     phase.drop_objection(this);
    //   endtask: reset_phase 

    task run_phase ( uvm_phase phase );
        wait(alu_intf.rstn === 1'b1);
        @(posedge alu_intf.clk);
        drive( );
    endtask : run_phase
 
    virtual task drive( );
        // Local Task Variables
        ALUSequenceItem item; // Declare a sequence_item handle.
 
        forever begin
            // Requence a new transaction.
            seq_item_port.get_next_item(item); 
            // Send transaction to DUT.
            alu_intf.drive_inputs (     //
                item.Instruction,       //
                item.ProgramCounter,    //
                item.GPR_a,             //
                item.GPR_b,             //
                item.GPR_c,             //
                item.SPR_h,             //
                item.SPR_l              //
            );
            // Driver is done with this handle.
            seq_item_port.item_done();

            drv_ap.write(item);
            @(posedge alu_intf.clk);
        end
    endtask : drive
 endclass :  ALUDriver
 `endif // __ALUDRIVER__SVH