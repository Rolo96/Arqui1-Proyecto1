`timescale 1ns/1ps

module Decoder( instruction,aluOperation,rd,rn,rm,immediate,conditionFlags,
		loadStoreSignals,regSrc,cntrlImmExt,cntrlCondFlags,cntrlBranch,cntrlPcSrc,cntrlAluSrc,
		cntrlRegWrite,cntrlMemWrite,cntrlMemtoReg);
	
	input logic [31:0] instruction;
	
	output logic [3:0] aluOperation; //operacion que hace la alu = OpCode
	output logic [3:0] rd; //registro
	output logic [3:0] rn; //registro
	output logic [3:0] rm; //registro
	output logic [23:0] immediate; //inmediato
	
	output logic [3:0] conditionFlags;
	output logic [4:0] loadStoreSignals; //bits P-U-B-W-L del load store
	output logic [1:0] regSrc; //
	output logic [1:0] cntrlImmExt;
	output logic cntrlCondFlags; //cambiar banderas condicionales
	output logic cntrlBranch;
	output logic cntrlPcSrc;
	output logic cntrlAluSrc;
	output logic cntrlRegWrite;
	output logic cntrlMemWrite;
	output logic cntrlMemtoReg;
	
	bit cntrlUseAlu; //si la alu es usada
	logic cntrlCondFlagsTemp; //
	
	logic [1:0] instrucType;//tipo de instruccion
	logic [3:0] opCode;//OpCode
	logic s;//variable I de la instrccion
	logic i;//variable S de la instruccion
	logic [9:0] cntrlSignals; //senales de control
	
	//outputs temporales
	logic [3:0] aluOperationTemp;
	logic [23:0] immediateTemp;
	logic [3:0] rdTemp;
	logic [3:0] rnTemp;
	logic [3:0] rmTemp;
	logic [4:0] loadStoreSignalsTemp;
	
	always_ff @(*) begin	
		instrucType = instruction[27:26];
		s = instruction[20]; 
		i = instruction[25]; 
		
		//branch
		if(instrucType == 2'b10) begin
			cntrlSignals = 10'b0110100010;
			immediateTemp = instruction[23:0]; //offset del branch
			
		//load store
		end else if (instrucType == 2'b01) begin
			cntrlSignals = (s) ? 10'b0001111000 : 10'b1001110100; // load/store
			rnTemp = instruction[19:16];
			rdTemp = instruction[15:12];
			loadStoreSignalsTemp = instruction[24:20];
			if(i) begin
				immediateTemp = instruction[23:0];
			end else begin
				rmTemp = instruction[3:0];
			end
			
		//procesamiento de datos	
		end else if (instrucType == 2'b00) begin
			cntrlSignals = (i) ? 10'b0000101001 : 10'b0000001001; // Inmediato/Registro
			opCode = instruction[24:21];
			rnTemp = instruction[19:16];
			rdTemp = instruction[15:12];
			if(i) begin
				immediateTemp = instruction[23:0];
			end else begin
				rmTemp = instruction[3:0];
			end
			
		end else begin
			cntrlSignals = 10'bx;
		end
		
	end
	
	assign {regSrc,cntrlImmExt, cntrlAluSrc, cntrlMemtoReg, 
		cntrlRegWrite, cntrlMemWrite, cntrlBranch, cntrlUseAlu} = cntrlSignals;
		
	always_ff @(*) begin
		if(cntrlUseAlu) begin
			aluOperationTemp = opCode;
			cntrlCondFlagsTemp = s;
		
		end else begin
			aluOperationTemp = 3'b0000; //add
			cntrlCondFlagsTemp = 1'b0;
		end	
	end
	

	assign rd = rdTemp;
	assign rn = rnTemp;
	assign rm = rmTemp;
	assign aluOperation = aluOperationTemp;
	assign immediate = immediateTemp;
	assign cntrlCondFlags = cntrlCondFlagsTemp;	
	assign loadStoreSignals = loadStoreSignalsTemp;
	assign cntrlPcSrc = ((rd==4'b1111) & cntrlRegWrite) | cntrlBranch;
	assign conditionFlags = instruction[31:28];
	

endmodule
