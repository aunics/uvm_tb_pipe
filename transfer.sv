class transfer extends uvm_sequence_item;
   rand bit [1:0]  cf;
   rand bit        enable;
   rand bit [15:0] data_in0;
   rand bit [15:0] data_in1;
   rand bit [15:0] data_out0;
   rand bit [15:0] data_out1;
   rand int        delay;

  constraint add_delay { delay inside {[5:10]};}
  constraint c_en {enable == 1;}
  constraint c_cf {cf != 0;}
   `uvm_object_utils_begin(transfer)
       `uvm_field_int( cf       ,UVM_DEFAULT)
       `uvm_field_int( enable   ,UVM_DEFAULT)
       `uvm_field_int( data_in0 ,UVM_DEFAULT)
       `uvm_field_int( data_in1 ,UVM_DEFAULT)
       `uvm_field_int( data_out0,UVM_DEFAULT)
       `uvm_field_int( data_out1,UVM_DEFAULT)
       `uvm_field_int( delay    ,UVM_DEFAULT)
    `uvm_object_utils_end

   function new(string name="data_packet");
      super.new(name);
   endfunction: new

   virtual task displayAll();
     `uvm_info("DP",$sformatf("cf=%0h enable=%0b data_in0=%0h data_in1=%0h data_out0=%0h data_out1=%0h delay=%0d",cf,enable, data_in0, data_in1,  data_out0, data_out1,delay), UVM_LOW);
   endtask : displayAll

endclass // transfer