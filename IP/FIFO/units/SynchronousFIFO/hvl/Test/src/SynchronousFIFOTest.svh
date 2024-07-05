`ifndef __SYNCHRONOUSFIFOTEST__SVH
    `define __SYNCHRONOUSFIFOTEST__SVH
//-----------------------------------------------------------------------------
// Company:         It's All Digital To Me
// Engineer:        Kyle D. Gilsdorf
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// UVM Configuration
//-----------------------------------------------------------------------------
class SynchronousFIFOConfig extends uvm_object;
    typedef SynchronousFIFOConfig this_type_t;
    `uvm_object_utils(SynchronousFIFOConfig);

    //---------------------------------------------------------------------------------------------
    // Class Parametrs
    //---------------------------------------------------------------------------------------------   
    parameter string  DUT = "SynchronousFIFO";  // Name of DUT
    parameter integer N   = 32;                 // Data path bit width   
    //---------------------------------------------------------------------------------------------
    // Class Methods
    //---------------------------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "SynchronousFIFOConfig");
        super.new(name);
    endfunction : new

endclass : SynchronousFIFOConfig

//-----------------------------------------------------------------------------
// UVM Sequence Item
//-----------------------------------------------------------------------------
class SynchronousFIFOSequenceItem extends uvm_sequence_item;
    typedef SynchronousFIFOSequenceItem this_type_t;
    
    //---------------------------------------------------------------------------------------------
    // Class Parameters
    //---------------------------------------------------------------------------------------------
    parameter integer N = 32;
    //---------------------------------------------------------------------------------------------
    // Class Attributes
    //---------------------------------------------------------------------------------------------
    rand logic         push;
    logic              full;
    rand logic [N-1:0] pushData;
    logic              empty;
    rand logic         pop;
    rand logic [N-1:0] popData;

    `uvm_object_utils_begin(SynchronousFIFOSequenceItem)
        `uvm_field_int(push,     UVM_ALL_ON)
        `uvm_field_int(full,     UVM_ALL_ON)
        `uvm_field_int(pushData, UVM_ALL_ON)
        `uvm_field_int(pop,      UVM_ALL_ON)
        `uvm_field_int(popData,  UVM_ALL_ON)
        `uvm_field_int(empty,    UVM_ALL_ON)
    `uvm_object_utils_end

    //---------------------------------------------------------------------------------------------
    // Class Methods
    //---------------------------------------------------------------------------------------------
    // Constructor
    function new(string name = "SynchronousFIFOSequenceItem");
        super.new(name);
    endfunction: new

    //---------------------------------------------------------------------------------------------
    // UVM Utility Functions                                            
    //---------------------------------------------------------------------------------------------
    // Always implement do_compare(), do_copy(), do_print(), do_pack(), do_unpack(), do_record() 
    // and convert2string()

    // Description: The do_copy() method is used to copy all the properties of a ALUSequenceItem object.
    virtual function void do_copy(uvm_object rhs);
        //---------------------------------------------------------------------------------------------
        // Local Function Variables
        SynchronousFIFOSequenceItem item;
        begin
            if(!$cast(item, rhs))
                `uvm_fatal(get_type_name(), "Illegal rhs argument")
            super.do_copy(rhs);

            this.push     = item.push;
            this.pushData = item.pushData;
            this.full     = item.full;
            this.pop      = item.pop;
            this.popData  = item.popData;
            this.empty    = item.empty;
        end
        endfunction : do_copy
        
        // Description: The do_compare() is used to compare each property of the ALUSequenceItem 
        // object. The do_compare() returns 1 if the comparison succeeds, and returns 0 if the 
        // comparison fails.
        virtual function bit do_compare;
        input uvm_object   rhs;
        input uvm_comparer comparer;
        //---------------------------------------------------------------------------------------------
        // Local Function Variables
        SynchronousFIFOSequenceItem item;
        begin
            do_compare = super.do_compare(rhs, comparer);
            if (!$cast(item,rhs)) begin
                `uvm_fatal("COMPARE", "$cast failed...")
                return FAILURE;
            end
            else begin
                do_compare &= comparer.compare_field_int("data", this.push,     item.push,     1);
                do_compare &= comparer.compare_field_int("data", this.pushData, item.pushData, N);
                do_compare &= comparer.compare_field_int("data", this.full,     item.full,     1);
                do_compare &= comparer.compare_field_int("data", this.pop,      item.pop,      1);
                do_compare &= comparer.compare_field_int("data", this.popData,  item.popData,  N);
                do_compare &= comparer.compare_field_int("data", this.empty,    item.empty,    1);
            end
        end
        endfunction : do_compare
    
        virtual function string convert2string();
        //---------------------------------------------------------------------------------------------
        // Local Function Variables
        string returnString;
        begin
            returnString = super.convert2string(); // Start with base object.
            returnString = {returnString, $psprintf(":-------------------+----------------.\n")};
            returnString = {returnString, $psprintf("| push     %01b     | pop=%1b\       |\n", push, pop)};
            returnString = {returnString, $psprintf("| pushData %08x | popData=%08x       |\n", pushData, popData)};
            returnString = {returnString, $psprintf("| full     %01b     | empty=%1b      |\n", full, empty)};
            returnString = {returnString, $psprintf("'-------------------'----------------'\n")};
            
            return returnString;
        end
        endfunction : convert2string

        virtual function void do_pack(uvm_packer packer);
        begin
            super.do_pack(packer);
            packer.pack_field_int(push,     1);
            packer.pack_field_int(pushData, N);
            packer.pack_field_int(full,     1);
            packer.pack_field_int(pop,      1);
            packer.pack_field_int(popData,  N);
            packer.pack_field_int(empty,    1);
        end
        endfunction : do_pack
        
        virtual function void do_unpack(uvm_packer packer);
        begin
            push     = packer.unpack_field_int(1);
            pushData = packer.unpack_field_int(N);
            full     = packer.unpack_field_int(1);
            pop      = packer.unpack_field_int(1);
            popData  = packer.unpack_field_int(N);
            empty    = packer.unpack_field_int(1);
        end    
        endfunction : do_unpack
    
        // Description: do_record function is the user-definable hook called by the record function of
        // uvm_object which records the object properties
        virtual function void do_record(uvm_recorder recorder);
            super.do_record(recorder);
            `uvm_record_int("push",    push,     1, UVM_NORADIX)
            `uvm_record_int("pushData",pushData, N, UVM_NORADIX)
            `uvm_record_int("full",    full,     1, UVM_NORADIX)
            `uvm_record_int("push",    push,     1, UVM_NORADIX)
            `uvm_record_int("popData", popData,  N, UVM_NORADIX)
            `uvm_record_int("empty",   empty,    1, UVM_NORADIX)
        endfunction : do_record
    
        // sprint() calls do_print() and returns the string.
        // print() calls do_print() and then prints with $display().
        virtual function void do_print(uvm_printer printer);
            printer.m_string = this.convert2string();
        endfunction : do_print
    
endclass : SynchronousFIFOSequenceItem

//-----------------------------------------------------------------------------
// UVM Sequence
//-----------------------------------------------------------------------------
class SynchronousFIFOSequence extends uvm_sequence #(SynchronousFIFOSequenceItem);
    typedef SynchronousFIFOSequence this_type_t;
    `uvm_object_utils(SynchronousFIFOSequence);

    //-------------------------------------------------------------------------
    //  Group: Variables
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    //  Group: Constraints
    //-------------------------------------------------------------------------

    //-------------------------------------------------------------------------
    //  Group: Functions
    //-------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "SynchronousFIFOSequence");
        super.new(name);
    endfunction: new

    // Task: body
    // This is the user-defined task where the main sequence code resides.
    task body();
    SynchronousFIFOSequenceItem item;
    begin
        super.body();
        item =  SynchronousFIFOSequenceItem::type_id::create("item"); // Construct the sequence item. 
        repeat(20) begin
            start_item(item);
            assert(item.randomize());
            finish_item(item);
        end
    end
    endtask: body
    
endclass: SynchronousFIFOSequence

//-----------------------------------------------------------------------------
// UVM Sequencer
// · Sends handles of transactions
// · Arbitrates transactions from multiple sequences.
//-----------------------------------------------------------------------------
typedef uvm_sequencer #(SynchronousFIFOSequenceItem) SynchronousFIFOSequencer;

//-----------------------------------------------------------------------------
// UVM Monitor
// · Collects transactions from the DUT and broadcasts them for analysis.
//-----------------------------------------------------------------------------
class SynchronousFIFOMonitor extends uvm_monitor;
    typedef  SynchronousFIFOMonitor this_type_t;
    `uvm_component_utils(SynchronousFIFOMonitor)

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    virtual SynchronousFIFOInterface sync_fifo_intf;
    SynchronousFIFOConfig            sync_fifo_cfg;
    // The monitor is a publisher as it broadcasts the ouput of the dut. 
    uvm_analysis_port #(SynchronousFIFOSequenceItem) mon_ap;
    uvm_analysis_port #(SynchronousFIFOSequenceItem) drv_ap;
 
    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------    
    function new(string name="SynchronousFIFOMonitor", uvm_component parent);
        super.new(name, parent);
        mon_ap = new("mon_ap", this);
        drv_ap = new("drv_ap", this);
    endfunction : new
 
    function void build_phase(uvm_phase phase);
       super.build_phase(phase);
 
        if (!uvm_config_db#(virtual SynchronousFIFOInterface)::get(this, "", "sync_fifo_intf", sync_fifo_intf))
            `uvm_fatal ("SynchronousFIFOMonitor", {"Virtual interface must be set for ", get_full_name( ), ".sync_fifo_intf" });
        if (!uvm_config_db#(SynchronousFIFOConfig)::get(this, "", "sync_fifo_cfg", sync_fifo_cfg))
            `uvm_fatal ("SynchronousFIFOMonitor", {"Configuration object must be set for ", get_full_name( ), ".sync_fifo_cfg" });
    endfunction : build_phase

    task run_phase(uvm_phase phase);
    begin
        wait(sync_fifo_intf.rstn === 1'b1);
        @(posedge sync_fifo_intf.clk);
        fork
            monitor_inputs( );
            monitor_outputs( );
        join
    end
    endtask : run_phase
 
    virtual task monitor_inputs( );
    SynchronousFIFOSequenceItem input_item;
    begin
        input_item = SynchronousFIFOSequenceItem::type_id::create("input_item");
        forever begin
            sync_fifo_intf.capture_inputs(input_item);
            drv_ap.write(input_item); // Write into scoreboard
        end
    end
    endtask : monitor_inputs

    virtual task monitor_outputs( );
    SynchronousFIFOSequenceItem output_item;
    begin
        output_item = SynchronousFIFOSequenceItem::type_id::create("output_item");
        forever begin
            // sync_fifo_intf.capture_outputs(output_item);
            mon_ap.write(output_item); // Write into scoreboard
        end
    end
    endtask : monitor_outputs

endclass : SynchronousFIFOMonitor

//-----------------------------------------------------------------------------
// UVM Driver
// · Receives transactions from the Sequencer.
// · Sends transactions to the interface.
//-----------------------------------------------------------------------------
class SynchronousFIFODriver extends uvm_driver #(SynchronousFIFOSequenceItem);
    typedef  SynchronousFIFODriver this_type_t;
    `uvm_component_utils(SynchronousFIFODriver)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------    
    virtual  SynchronousFIFOInterface                sync_fifo_intf;
    SynchronousFIFOConfig                            sync_fifo_cfg; 
    uvm_analysis_port #(SynchronousFIFOSequenceItem) drv_ap;

    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new(string name = "SynchronousFIFODriver", uvm_component parent);
        super.new(name, parent);
        //
        drv_ap = new("drv_ap", this);
     endfunction : new
  
     function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual SynchronousFIFOInterface)::get(this, "", "sync_fifo_intf", sync_fifo_intf))
            `uvm_fatal("SynchronousFIFODriver", {"Virtual interface must be set for ", get_full_name ( ), "sync_fifo_intf"})
        if (!uvm_config_db#(SynchronousFIFOConfig)::get(this, "", "sync_fifo_cfg", sync_fifo_cfg))
            `uvm_fatal("SynchronousFIFODriver", {"Configuration Object be set for ", get_full_name ( ), "sync_fifo_cfg"})
     endfunction : build_phase
 
    task run_phase(uvm_phase phase);
        wait(sync_fifo_intf.rstn === 1'b1);
        @(posedge sync_fifo_intf.clk); // Wait until the next clock edge to do synchronous stuffs.
        drive( );
    endtask : run_phase
  
    virtual task drive( );
    // Local Task Variables
    logic full;
    SynchronousFIFOSequenceItem item; // Declare a sequence_item handle.
    begin
        forever begin
            // Requence a new transaction.
            seq_item_port.get_next_item(item); 
            // Send transaction to DUT.
            #1 sync_fifo_intf.drive_inputs(item);
            // Driver is done with this handle.
            seq_item_port.item_done();
            drv_ap.write(item);
            @(posedge sync_fifo_intf.clk);
        end
    end         
    endtask : drive

endclass : SynchronousFIFODriver


class SynchronousFIFOAgentConfig extends uvm_object;
    bit active;
    typedef SynchronousFIFOAgentConfig this_type_t;
    `uvm_object_utils(SynchronousFIFOAgentConfig);

    //---------------------------------------------------------------------------------------------
    // Class Attributes
    //---------------------------------------------------------------------------------------------   
    // uvm_active_passive_enum active = UVM_ACTIVE;
    
    // Agent Include Functional Coverage Monitor
    bit has_functional_coverage = 0;
    /// Agent Include Scoreboard
    bit has_scoreboard = 0;
    //---------------------------------------------------------------------------------------------
    // Class Methods
    //---------------------------------------------------------------------------------------------
    //  Constructor: new
    function new(string name = "SynchronousFIFOAgentConfig");
        super.new(name);
    endfunction : new

endclass : SynchronousFIFOAgentConfig

//-----------------------------------------------------------------------------
// UVM Agent
// · 
//-----------------------------------------------------------------------------
class SynchronousFIFOAgent extends uvm_agent;
     typedef SynchronousFIFOAgent this_type_t;
     `uvm_component_utils(SynchronousFIFOAgent)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    SynchronousFIFOSequencer                         sync_fifo_sqr;
    SynchronousFIFOMonitor                           sync_fifo_mon;
    SynchronousFIFODriver                            sync_fifo_drv;
    uvm_analysis_port #(SynchronousFIFOSequenceItem) input_port;
    uvm_analysis_port #(SynchronousFIFOSequenceItem) output_port;
    SynchronousFIFOAgentConfig                       sync_fifo_agt_cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new(string name = "SynchronousFIFOAgent", uvm_component parent);
        super.new(name, parent);
    endfunction : new
  
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // The driver and, sequencer and monitor are created during the build 
        // phase. Create the sequencer with new() and not the factory. This is 
        // because we are not making any change to the Sequencer.
        sync_fifo_sqr = new("sync_fifo_sqr", this); 
        sync_fifo_mon = SynchronousFIFOMonitor::type_id::create("sync_fifo_mon", this);
        sync_fifo_drv = SynchronousFIFODriver::type_id::create("sync_fifo_drv", this);
        input_port    = new("input_port", this);
        output_port   = new("output_port", this);
        sync_fifo_agt_cfg = SynchronousFIFOAgentConfig::type_id::create("sync_fifo_agt_cfg", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sync_fifo_mon.drv_ap.connect(input_port);
        sync_fifo_mon.mon_ap.connect(output_port);
        // The driver port and sequencer export are connected during the connect phase.
        if (sync_fifo_agt_cfg.active == UVM_ACTIVE)
            sync_fifo_drv.seq_item_port.connect(sync_fifo_sqr.seq_item_export);

    endfunction : connect_phase
 
endclass : SynchronousFIFOAgent

//-----------------------------------------------------------------------------
// UVM ScoreBoard
// · 
//-----------------------------------------------------------------------------
`uvm_analysis_imp_decl(_monitor)
`uvm_analysis_imp_decl(_driver)
class SynchronousFIFOScoreBoard extends uvm_scoreboard;
    typedef  SynchronousFIFOScoreBoard this_type_t;
    `uvm_component_utils(SynchronousFIFOScoreBoard)

    parameter N = 32;
    parameter O = $clog2(N);
    //---------------------------------------------------------------------------------------------
    // Class Attributes
    //---------------------------------------------------------------------------------------------
    uvm_analysis_imp_monitor #(SynchronousFIFOSequenceItem, SynchronousFIFOScoreBoard) AnalysisOut;
    uvm_analysis_imp_driver  #(SynchronousFIFOSequenceItem, SynchronousFIFOScoreBoard) AnalysisIn;
    SynchronousFIFOSequenceItem seq_item_queue[$];  //
    SynchronousFIFOConfig       sync_fifo_cfg;      //
    uvm_packer                  sync_fifo_pkr;      //
    bit                         m_bits[];           //
    int                         m_number_of_bits;   //

    //---------------------------------------------------------------------------------------------
    // Coverage
    //---------------------------------------------------------------------------------------------

    
    //---------------------------------------------------------------------------------------------
    // Class Attributes
    //---------------------------------------------------------------------------------------------
    function new(string name, uvm_component parent);
        super.new(name, parent);
        // Create cover groups
        // Instruction_cg = new ( );
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Creating analysis port
        AnalysisOut = new("AnalysisOut", this);
        AnalysisIn = new("AnalysisIn", this);
        if (!uvm_config_db#(SynchronousFIFOConfig)::get(this, "", "sync_fifo_cfg", sync_fifo_cfg))
            `uvm_fatal ("SynchronousFIFOScoreBoard", {"Configuration object must be set for ", get_full_name(), ".sync_fifo_cfg"});
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

  	virtual function void write_driver(input SynchronousFIFOSequenceItem input_item);
		seq_item_queue.push_front(input_item);
   	endfunction : write_driver

    virtual function void write_monitor(input SynchronousFIFOSequenceItem output_item);
        SynchronousFIFOSequenceItem input_item;  //
        SynchronousFIFOSequenceItem expect_item; // A complete representation of the Input the C-Model output.
        begin
            input_item = seq_item_queue.pop_back( );

            if (output_item.compare(input_item)) begin
                // Never call using do_compare()
                `uvm_info(get_type_name(), $psprintf("PASSED"), UVM_LOW)
            end else begin
                `uvm_info("input_item", input_item.convert2string(), UVM_LOW)
                `uvm_info("output_item", output_item.convert2string(), UVM_LOW)
            end
        end
    endfunction : write_monitor

    virtual function void report ( );
        uvm_report_info(get_type_name(), $psprintf("Scoreboard Report %s", this.sprint()), UVM_LOW);
    endfunction : report
endclass : SynchronousFIFOScoreBoard


//-----------------------------------------------------------------------------
// UVM Environment
// · 
//-----------------------------------------------------------------------------
class SynchronousFIFOEnvironment extends uvm_env;
    typedef SynchronousFIFOEnvironment this_type_t;
    `uvm_component_utils(SynchronousFIFOEnvironment);

    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    SynchronousFIFOAgent      sync_fifo_agt;
    SynchronousFIFOScoreBoard sync_fifo_sbd;
    SynchronousFIFOConfig     sync_fifo_cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //------------------------------------------------------------------------- 
    function new(string name = "SynchronousFIFOEnvironment", uvm_component parent);
    begin
        super.new(name, parent);
    end
    endfunction : new
  
    function void build_phase(uvm_phase phase);
    begin
        super.build_phase(phase);
        sync_fifo_agt = SynchronousFIFOAgent::type_id::create ("sync_fifo_agt", this );
        sync_fifo_sbd = SynchronousFIFOScoreBoard::type_id::create ("sync_fifo_sbd", this );
        if (!uvm_config_db#(SynchronousFIFOConfig)::get(this, "", "sync_fifo_cfg", sync_fifo_cfg))
            `uvm_fatal (" SynchronousFIFOEnvironment", {"Configuration object must be set for ", get_full_name(), ".sync_fifo_cfg" });
    end
    endfunction : build_phase
  
     function void connect_phase (uvm_phase phase);
         super.connect_phase(phase);
         // Connect all subscribers to monitor
         sync_fifo_agt.sync_fifo_mon.mon_ap.connect(sync_fifo_sbd.AnalysisOut);
         // Connect all subscribers to driver
         sync_fifo_agt.sync_fifo_drv.drv_ap.connect(sync_fifo_sbd.AnalysisIn);
     endfunction : connect_phase

endclass : SynchronousFIFOEnvironment

//-----------------------------------------------------------------------------
// UVM Test
// · Maps a seqeunce to the sequencer.
// · Starts the sequences.
//-----------------------------------------------------------------------------
class SynchronousFIFOTest extends uvm_test;
    typedef SynchronousFIFOTest this_type_t;
    `uvm_component_utils(SynchronousFIFOTest)
 
    //-------------------------------------------------------------------------
    // Class Attributes
    //-------------------------------------------------------------------------
    SynchronousFIFOEnvironment sync_fifo_env;
    SynchronousFIFOConfig      sync_fifo_cfg;

    //-------------------------------------------------------------------------
    // Class Methods
    //-------------------------------------------------------------------------
    function new(string name = "SynchronousFIFOTest", uvm_component parent);
       super.new(name, parent);
    endfunction : new
 
    function void build_phase(uvm_phase phase);
    begin
        super.build_phase(phase);
        sync_fifo_env = SynchronousFIFOEnvironment::type_id::create("sync_fifo_env", this);
        uvm_config_db#(SynchronousFIFOEnvironment)::set(.cntxt(this), .inst_name("sync_fifo_env"), .field_name("sync_fifo_env"), .value(sync_fifo_env)); 

        if (!uvm_config_db#(SynchronousFIFOConfig)::get(this, "", "sync_fifo_cfg", sync_fifo_cfg))
            `uvm_fatal ("SynchronousFIFOTest", {"Configuration object must be set for ", get_full_name(), ".sync_fifo_cfg"});
    end
    endfunction : build_phase

    task run_phase(uvm_phase phase);
    // Local Task variables.
    SynchronousFIFOSequence rseq; // Declare a handle to sequence.
    begin    
        phase.raise_objection(.obj(this));
        rseq = SynchronousFIFOSequence::type_id::create("rseq", this);
        rseq.start(sync_fifo_env.sync_fifo_agt.sync_fifo_sqr);
        phase.drop_objection(.obj(this));
    end
    endtask : run_phase

endclass : SynchronousFIFOTest
`endif // __SYNCHRONOUSFIFOTEST__SVH
