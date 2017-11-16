interface pipe_if(input clk, rst_n);
   logic [1:0]  cf;
   logic        enable;
   logic [15:0] i_data0;
   logic [15:0] i_data1;
   logic [15:0] o_data0;
   logic [15:0] o_data1;
endinterface: pipe_if
