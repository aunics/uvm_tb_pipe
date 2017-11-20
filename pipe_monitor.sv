class pipe_monitor extends uvm_monitor;
   virtual pipe_if vif;
   int 	   num_pkts;

   //Collected item related changes
   uvm_analysis_port #(transfer) collected_port;
   transfer item_sent;
   transfer item_returned;

   `uvm_component_utils(pipe_monitor)

   function new(string name, uvm_component parent);
      super.new(name,parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if (!uvm_config_db#(virtual pipe_if)::get(this,"","monitor_if",vif)) begin
	 `uvm_fatal("NOVIF", {"Virtual interface must be set for: ", get_full_name(), ".vif"})
      end 
      collected_port = new("collected_port", this);
      item_sent      = transfer::type_id::create("item_sent");
      item_returned  = transfer::type_id::create("item_returned");

      `uvm_info(get_full_name(), " Build stage complete.",UVM_LOW)
   endfunction // build_phase

  virtual task run_phase(uvm_phase phase);
      collect_data();
   endtask // run_phase

   virtual task collect_data();
      forever begin
	 wait(vif.enable);
	 item_sent.cf = vif.cf;
	 item_sent.data_in0 = vif.i_data0;
	 item_sent.data_in1 = vif.i_data1;
        $display("cf=%0h", vif.cf);
        item_sent.displayAll();
	 repeat(3) @(posedge vif.clk);
	 item_sent.data_out0 = vif.o_data0;
	 item_sent.data_out1 = vif.o_data1;

	 $cast(item_returned, item_sent.clone());
      
      item_returned.displayAll();
	 collected_port.write(item_returned);
	 num_pkts++;
      end
     endtask // collect_data
 
   virtual function void report_phase(uvm_phase phase);
      `uvm_info(get_full_name, $sformatf("REPORT: Collected Packets : %d", num_pkts), UVM_LOW)      
   endfunction // report_phase
     
endclass // pipe_monitor