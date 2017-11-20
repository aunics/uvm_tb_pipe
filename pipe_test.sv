class base_test extends uvm_test;
  
   dut_env env;
   uvm_table_printer printer;
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase); 
    super.build_phase(phase);
    env = dut_env::type_id::create("env",this);
    printer = new();
    printer.knobs.depth = 5;
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Printing the test topology: \n%s",this.sprint(printer)), UVM_LOW)
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.phase_done.set_drain_time(this, 1500);
  endtask
endclass

class random_test extends base_test;
  `uvm_component_utils(random_test)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    random_sequence seq;
    super.run_phase(phase);
    phase.raise_objection(this);
     seq = random_sequence::type_id::create("seq");
     seq.start(env.pipe_in.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass



