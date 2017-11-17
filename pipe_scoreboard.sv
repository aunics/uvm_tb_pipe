class pipe_scoreboard extends uvm_scoreboard;
   uvm_tlm_analysis_fifo #(transfer) input_items_fifo;
   uvm_tlm_analysis_fifo #(transfer) output_items_fifo;

   transfer input_item;
   transfer output_item;

   `uvm_component_utils(pipe_scoreboard)

   function new(string name, uvm_component parent);
      super.new(name,parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      input_items_fifo = new("input_items_fifo", this);
      output_items_fifo = new("output_items_fifo", this);

      input_item = transfer::type_id::create("input_item");
      output_item = transfer::type_id::create("output_item");

      `uvm_info(get_full_name, " Build phase done. ", UVM_LOW)
   endfunction // build_phase


   virtual task run_phase(uvm_phase phase);
      watcher();
   endtask // run_phase

   virtual task watcher();
      forever begin
	 input_items_fifo.get(input_item);
	 output_items_fifo.get(output_item);
	 compare_data();
      end
   endtask // watcher
   
   virtual task compare_data();
      bit [15:0] exp_data0;
      bit [15:0] exp_data1;
      if ((input_item.data_in0 == 16'h0000) || (input_item.data_in0 == 16'hFFFF)) begin
         exp_data0 = input_item.data_in0;
      end
      else begin
	 exp_data0 = input_item.data_in0 * cf;
      end
      
      if ((input_item.data_in1 == 16'h0000) || (input_item.data_in1 == 16'hFFFF)) begin
         exp_data1 = input_item.data_in1;
      end
      else begin
	 exp_data1 = input_item.data_in1 * cf;
      end

      if (exp_data0 != output_item.data_in0)
	 `uvm_error(get_type_name, $sformatf("Actual output data: %0h does not match expected data: %0h", output_item.data_in0,exp_data0)  
     
      if (exp_data1 != output_item.data_in1)
	 `uvm_error(get_type_name, $sformatf("Actual output data: %0h does not match expected data: %0h", output_item.data_in1,exp_data1)  
  endtask // compare_data
endclass // pipe_scoreboard
