class pipe_env extends uvm_env;
   pipe_agent agent;

   `uvm_component_utils(pipe_env)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.new(phase);
      agent = pipe_agent::type_id::create("agent", this);
      `uvm_info(get_full_name, " Build phase done." , UVM_LOW)
   endfunction // build_phase

endclass // pipe_env
