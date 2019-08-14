module pipe( clk, 
             rst_n,
             i_cf,
             i_en,
             i_data0,i_data1,
             o_data0,
             o_data1
           );

   input        clk;
   input        rst_n;
   input [1:0]  i_cf;
   input        i_en;
   input [15:0] i_data0;
   input [15:0] i_data1;

   output [15:0] o_data0;
   output [15:0] o_data1;
    
   wire        clk;
   wire        rst_n;
   wire [1:0]  i_cf;
   wire        i_en;
   wire [15:0] i_data0;
   wire [15:0] i_data1;

  reg [15:0]   o_data0;
   reg [15:0]  o_data1;
   
   always @(posedge clk) begin
      if (!rst_n) begin
	     o_data0 <= 16'h0000;
         o_data1 <= 16'h0000;
      end
      else begin
	 if (i_en) begin
	    if (i_data0 == 16'h0000 || i_data0 == 16'hFFFF) begin
	       o_data0 <= i_data0;
	    end
	    else
	      o_data0 <= i_data0 * i_cf;
	 end
	 if (i_en) begin
	    if (i_data1 == 16'h0000 || i_data1 == 16'hFFFF) begin
	       o_data1 <= i_data1;
	    end
	    else begin
	       o_data1 <= i_data1 * i_cf;
	    end
	 end
      end // else: !if(!rst_n)
   end // always @ (posedge clk)

   always @(posedge clk) begin
      o_data0 <= o_data0;
      o_data1 <= o_data1;
   end
  
endmodule
