class pipe_driver extends uvm_driver #(transfer);
   virtual pipe_if vif;

   `uvm_component_utils(pipe_driver)

   function new(string name, uvm_component parent);
     super.new(name,parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(virtual pipe_if)::get(this, "", "in_intf",vif))
	`uvm_fatal("NOVIF", {"Virtual interface must be set for: ",get_full_name( ), ".vif"})
      `uvm_info(get_full_name( ), "Build stage complete.", UVM_LOW)
   endfunction // build_phase

   virtual task run_phase(uvm_phase phase);
      fork
	 reset();
	 get_and_drive();
      join
   endtask // run_phase

   virtual task reset();
      forever begin
	 @(negedge vif.rst_n);
	 `uvm_info(get_type_name(), " Resetting signals ", UVM_LOW)
	 vif.cf = 2'b0;
     vif.i_data0 = 16'b0;
	 vif.i_data1 = 16'b0;
	 vif.enable   = 1'b0;
      end
    endtask // reset

   virtual task get_and_drive() ;
      forever begin
	 @(posedge vif.rst_n);
	 while(vif.rst_n != 1'b0) begin
	    seq_item_port.get_next_item(req);
	    drive_packet(req);
	    seq_item_port.item_done(req);
	 end
      end
   endtask // get_and_drive

   virtual task drive_packet(transfer pkt);
      vif.enable = 1'b0;
      repeat (pkt.delay) @(posedge vif.clk);
     pkt.displayAll();
      vif.enable    = pkt.enable;
      vif.i_data0  = pkt.data_in0;
      vif.i_data1 = pkt.data_in1;
      vif.cf = pkt.cf;
      @(posedge vif.clk);
      vif.enable = 1'b0;
   endtask // drive_packet
endclass // pipe_driver