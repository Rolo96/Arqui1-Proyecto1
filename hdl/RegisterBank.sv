`timescale 1ns / 1ps

module RegisterBank(
	input logic clk,
	input writeEnabled, //1 -> escribir en registro
	input logic [3:0] regAddress1, //direccion de registro 1
	input logic [3:0] regAddress2, //direccion de registro 2
	input logic [3:0] writeAddress, //en caso de escribir, direccion donde se hara
	input logic [31:0] writeData, //dato a escribir
	input logic [31:0] pc, 
	output logic [31:0] dataOut1, //dato leido en RegAddress1
	output logic [31:0] dataOut2 //dato leido en RegAddress2
);

	logic [31:0] regs [15:0];

	always @(negedge clk) 
		begin
			if(writeEnabled) begin
				regs[writeAddress] = writeData; //se escribe
			end
		end
		
	assign dataOut1 = (regAddress1 == 4'b1111) ? pc : regs[regAddress1]; //dato leido
	assign dataOut2 = (regAddress2 == 4'b1111) ? pc : regs[regAddress2]; //dato leido

endmodule
