`timescale 1ns / 1ps
module InstructionMemory_tb();
	parameter BITS=32;
	logic clk,reset;
   logic [BITS-1:0] address,instruction;
   InstructionMemory DUT(clk,reset,address,instruction);
	initial 
	begin
		clk = 1'b0;
		forever begin
			#2.5;
			clk = ~clk;
		end
	end

	initial 
	begin
		clk = 0;
		reset = 1;
		address = 32'd0;
		#5;
		reset = 0;
		for ( int i = 0 ; i < 5 ; i++ ) 
		begin
			address = address + 32'd4;
			#5;
		end
	end
endmodule
