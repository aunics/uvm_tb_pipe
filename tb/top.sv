`include "pipe_if.sv"
//`include "design.sv"
module top;
   import uvm_pkg::*;
   import pipe_pkg::*;
   
   bit clk;
   bit rst_n;
   
   pipe_if vif_in(.clk(clk), .rst_n(rst_n));
   pipe_if vif_out(.clk(clk), .rst_n(rst_n));

   pipe pipe_top(.clk    (clk    ),        
                 .rst_n  (rst_n  ), 	     
                 .i_cf   (vif_in.cf   ), 	     
                 .i_en   (vif_in.enable ), 	     
                 .i_data0(vif_in.i_data0), 
                 .i_data1(vif_in.i_data1), 
                 .o_data0(vif_out.o_data0), 	     
                 .o_data1(vif_out.o_data1));

   //Clock generation
   always #5 clk = ~clk;

   initial begin
      #5 rst_n  = 1'b0;
      #25 rst_n = 1'b1;
   end

   assign vif_out.enable = vif_in.enable;

   initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
   end
   initial begin
     uvm_config_db#(virtual pipe_if)::set(uvm_root::get(),"*.agent.*", "in_intf", vif_in);
     uvm_config_db#(virtual pipe_if)::set(uvm_root::get(),"*.monitor", "monitor_if",vif_out);
     run_test("random_test");
   end
endmodule // top