`timescale 1ns / 1ps
module DataMemory(clk,writeEnabled,address,writeData,readData);
	parameter BITS=32;
   input logic clk, writeEnabled;
	input logic [BITS-1:0] address, writeData;
	output logic [BITS-1:0] readData;

	logic [BITS-1:0] ram[63:0];

	always_ff @ (posedge clk) begin
		if (writeEnabled) ram[address[BITS-1:2]] <= writeData; 
		readData<=ram[address[BITS-1:2]];
	end
endmodule