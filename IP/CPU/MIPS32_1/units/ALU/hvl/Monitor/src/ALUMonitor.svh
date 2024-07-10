//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Module:       UVM Monitor class for ALU
//-------------------------------------------------------------------------------------------------
`ifndef __ALUMONITOR__SVH
    `define __ALUMONITOR__SVH
class  ALUMonitor extends uvm_monitor;
    typedef ALUMonitor this_type_t;
    `uvm_component_utils(ALUMonitor)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    virtual ALUInterface                 alu_intf;
    ALUConfig                            alu_cfg;
    uvm_analysis_port #(ALUSequenceItem) drv_ap;
    uvm_analysis_port #(ALUSequenceItem) mon_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------    
    function new(string name="ALUMonitor", uvm_component parent);
        super.new(name, parent);
        mon_ap = new("mon_ap", this);
        drv_ap = new("drv_ap", this);
    endfunction : new
 
    function void build_phase(uvm_phase phase);
    begin
       super.build_phase(phase );
 
        if (!uvm_config_db#(virtual  ALUInterface)::get(this, "", "alu_intf", alu_intf))
            `uvm_fatal ("ALUMonitor", {"Virtual interface must be set for ", get_full_name ( ), ".alu_intf"});
        if (!uvm_config_db#(ALUConfig)::get(this, "", "alu_cfg", alu_cfg))
            `uvm_fatal ("ALUMonitor", {"Configuration object must be set for ", get_full_name ( ), ".alu_cfg"});
    end
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        wait(alu_intf.rstn === 1'b1);
        @(posedge alu_intf.clk);
        fork
            monitor_inputs();
            monitor_outputs();
        join
    endtask : run_phase
 
    virtual task monitor_inputs( );
    ALUSequenceItem item;
    logic           valid;
    begin
        item = ALUSequenceItem::type_id::create("input_item");
        forever begin
            valid = 1'b0;
            alu_intf.capture_inputs(
                .i_Instruction(item.Instruction),
                .i_ProgramCounter(item.ProgramCounter),
                .i_GPR_a(item.GPR_a),
                .i_GPR_b(item.GPR_b),
                .i_GPR_c(item.GPR_c),
                .i_SPR_h(item.SPR_h),                
                .i_SPR_l(item.SPR_l),                
                .o_valid(valid     )
            ); 
            
            if (valid === 1'b1) begin
                drv_ap.write(item); // Write into scoreboard
            end
            @(posedge alu_intf.clk);
        end
    end
    endtask : monitor_inputs

    virtual task monitor_outputs( );
    ALUSequenceItem item;
    logic           valid;
    begin
        item = ALUSequenceItem::type_id::create("output_item");
        forever begin
            valid = 1'b0;
            @(posedge alu_intf.clk);
            alu_intf.capture_outputs(
                .o_GPR_a_dat(item.GPR_a_dat),
                .o_GPR_a_val(item.GPR_a_val),
                .o_GPR_b_dat(item.GPR_b_dat),
                .o_GPR_b_val(item.GPR_b_val),
                .o_GPR_c_dat(item.GPR_c_dat),
                .o_GPR_c_val(item.GPR_c_val),
                .o_SPR_h_dat(item.SPR_h_dat),
                .o_SPR_h_val(item.SPR_h_val),
                .o_SPR_l_dat(item.SPR_l_dat),
                .o_SPR_l_val(item.SPR_l_val),
                .o_SPR_o_val(item.SPR_o_val),
                .o_SPR_z_val(item.SPR_z_val),
                .o_valid    (valid         )
            );

            if (valid === 1'b1) begin
                mon_ap.write(item);
            end
        end
    end
    endtask : monitor_outputs

 endclass :  ALUMonitor
 `endif // __ALUMONITOR__SVH