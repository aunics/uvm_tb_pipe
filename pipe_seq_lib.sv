class random_sequence extends uvm_sequence #(transfer);
   `uvm_object_utils(random_sequence)
   function new(string name = "random_sequence");
      super.new(name);
   endfunction: new
   task body();
      `uvm_do(req);
   endtask: body
   
endclass: random_sequence
