module Adder_tb();
	parameter BITS=32;
	logic[BITS-1:0] operandA,operandB,result;
	Adder DUT(operandA,operandB,result);
	initial
	begin
		operandA=32'd10; operandB=32'd10;	#10;
		operandB=32'd5;							#10;			
		operandA=32'd5;  operandB=32'd7;		#10;			
		operandB=32'd4;							#10;						
	end
endmodule