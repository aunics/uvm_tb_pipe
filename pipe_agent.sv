class pipe_agent extends uvm_agent;
   pipe_monitor monitor;
   pipe_driver driver;
   pipe_sequencer sequencer;

   uvm_active_passive_enum is_active;
   
   `uvm_component_utils_begin(pipe_agent)
     `uvm_field_enum(uvm_active_passive_enum,is_active, UVM_ALL_ON)
    `uvm_component_utils_end	

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(is_active == UVM_ACTIVE) begin
	 driver    = pipe_driver::type_id::create("driver",this);
	 sequencer = pipe_sequencer::type_id::create("sequencer",this);
      end
      monitor = pipe_monitor::type_id::create("monitor",this);
      `uvm_info(get_full_name, " Build phase done.", UVM_LOW)      
   endfunction // build_phase

   function void connect_phase(uvm_phase phase);
     if (is_active == UVM_ACTIVE) begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
     end
    `uvm_info(get_full_name," Connect phase done",UVM_LOW)
   endfunction // connect_phase
endclass // pipe_agent