`timescale 1ns / 1ps
module Adder(operandA,operandB,result);
	parameter BITS=32;
	input logic[BITS-1:0] operandA,operandB;
	output logic[BITS-1:0] result;
	assign result = operandA + operandB;
endmodule
