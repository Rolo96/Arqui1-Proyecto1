`timescale 1ns / 1ps
module DataMemory_tb();
   parameter BITS = 32;
   parameter MIN = 0;
   parameter MAX = 16;
	
	bit clk;
   bit writeEnabled;
   logic [BITS-1:0] address, writeData,readData;

   DataMemory DUT(clk,writeEnabled,address,writeData,readData);

	initial 
	begin
		clk = 1'b0;
		forever begin
			#5;
			clk = ~clk;
		end
	end

	initial 
	begin
		writeEnabled = 1'bx;
      address = 32'bx;
      writeData = 32'bx;    
		#5
      writeEnabled = 1'b1;
      for(int i=MIN; i < MAX; i+=4 ) 
		begin
			address = i;
         writeData = i;
         #10;
      end

      writeEnabled = 1'b0;
      address = 32'dx;
      writeData = 32'dx;
      #10;

      for(int i=MIN; i <= MAX; i+=4 ) 
		begin
			address = i;
         #10;
      end
      $stop;
	end
endmodule