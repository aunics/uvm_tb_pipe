class random_sequence extends uvm_sequence #(transfer);
  `uvm_sequence_utils(random_sequence,pipe_sequencer)
   function new(string name = "random_sequence");
      super.new(name);
   endfunction: new
   task body();
     for (int i = 0; i < 4; i++) begin
       `uvm_do(req);
     end
   endtask: body
   
endclass: random_sequence
