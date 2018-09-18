`timescale 1ns / 1ps
module InstructionMemory(clk,reset,address,instruction);  
	parameter BITS=32;
	input logic clk,reset;
	input logic [BITS-1:0] address; 
	output logic [BITS-1:0] instruction;
	
always_ff @(posedge clk) 
begin
	if(reset) instruction <= 32'bx;
	else 
	begin
		case(address)
			32'd0: instruction  <= 32'H0000000F;
			32'd4: instruction  <= 32'H000000FF;
			32'd8: instruction  <= 32'H00000FFF;
			default: instruction <= 32'bx;
		endcase
	end
end
endmodule