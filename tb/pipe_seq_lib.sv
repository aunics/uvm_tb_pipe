class random_sequence extends uvm_sequence #(transfer);
   `uvm_sequence_utils(random_sequence,pipe_sequencer)
   function new(string name = "random_sequence");
      super.new(name);
   endfunction: new
   task body();
      `uvm_do(req);
   endtask: body
   
endclass: random_sequence

   
//class data0_sequence extends uvm_sequence #(transfer);
//   `uvm_sequence_utils(data0_sequence
   
   
