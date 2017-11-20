class dut_env extends uvm_env;
   pipe_env pipe_in;
   pipe_env pipe_out;
   pipe_scoreboard scbd;

   `uvm_component_utils(dut_env)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      uvm_config_db#(uvm_active_passive_enum)::set(this,"pipe_in.agent", "is_active",UVM_ACTIVE);
      uvm_config_db#(uvm_active_passive_enum)::set(this,"pipe_out.agent", "is_active", UVM_PASSIVE);
      pipe_in = pipe_env::type_id::create("pipe_in",this);
      pipe_out = pipe_env::type_id::create("pipe_out", this);
      scbd = pipe_scoreboard::type_id::create("scbd",this);

      `uvm_info(get_full_name(), " Build phase done. ", UVM_LOW)
   endfunction // build

   function void connect_phase(uvm_phase phase);
      pipe_in.agent.monitor.collected_port.connect(scbd.input_items_fifo.analysis_export);
      pipe_out.agent.monitor.collected_port.connect(scbd.output_items_fifo.analysis_export);
      `uvm_info(get_full_name(), " Connect Phase Done. " , UVM_LOW)
   endfunction // connect_phase

endclass // dut_env