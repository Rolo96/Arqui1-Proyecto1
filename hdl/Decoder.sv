`timescale 1ns/1ps

module Decoder( instruction,aluOperation,rd,rn,rm,immediate,conditionFlags,
		loadStoreSignals,cntrlRegSrc,cntrlImmExt,cntrlCondFlags,cntrlBranch,cntrlPcSrc,cntrlAluSrc,
		cntrlRegWrite,cntrlMemWrite,cntrlMemtoReg);
	
	input logic [31:0] instruction; //instruccion a decodificar
	
	output logic [3:0] rd; //registro
	output logic [3:0] rn; //registro
	output logic [3:0] rm; //registro
	output logic [23:0] immediate; //inmediato
	
	output logic [3:0] aluOperation; //operacion que hace la alu = OpCode
	output logic [1:0] cntrlCondFlags; //modificar banderas condicionales
	output logic [3:0] conditionFlags;  //banderas condicionales
	output logic [4:0] loadStoreSignals; //bits P-U-B-W-L del load store
	output logic cntrlPcSrc; //Escribir en reg PC
	output logic cntrlRegWrite; //Escribir en registro
	output logic cntrlMemWrite; //Escribir en memoria
	output logic cntrlMemtoReg;
	output logic cntrlAluSrc; 
	output logic [1:0] cntrlImmExt; //Tipo ext de signo segun instruccion
	output logic [1:0] cntrlRegSrc; //
	output logic cntrlBranch;	
	//output logic cntrlNoWrite; //si es un CMP, indicar que no escriba en registro

	
	bit cntrlUseAlu; //si la alu es usada
	logic [1:0] cntrlCondFlagsTemp; //
	
	logic [1:0] instrucType;//tipo de instruccion
	logic [3:0] opCode;//OpCode
	logic s;//variable I de la instrccion
	logic i;//variable S de la instruccion
	logic [9:0] cntrlSignals; //senales de control
	
	//outputs temporales
	//logic cntrlNoWriteTemp;
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
			//cntrlNoWriteTemp = (opCode == 4'b0100); //si es CMP => 1
			if(i) begin
				immediateTemp = instruction[23:0];
			end else begin
				rmTemp = instruction[3:0];
			end
			
		end else begin
			cntrlSignals = 10'bx;
		end
		
	end
	
	assign {cntrlRegSrc,cntrlImmExt, cntrlAluSrc, cntrlMemtoReg, 
		cntrlRegWrite, cntrlMemWrite, cntrlBranch, cntrlUseAlu} = cntrlSignals;
		
	always_ff @(*) begin
		if(cntrlUseAlu) begin //data process
			aluOperationTemp = opCode;
			cntrlCondFlagsTemp[1] = s;              //ADD              //SUBB 
			cntrlCondFlagsTemp[0] = s & (opCode == 4'b0000 | opCode == 4'b0001);
		
		end else begin
			aluOperationTemp = 3'b0000; //add
			cntrlCondFlagsTemp = 2'b00; //no se modifican las condicionales
		end	
	end
	

	assign rd = rdTemp;
	assign rn = rnTemp;
	assign rm = rmTemp;
	assign aluOperation = aluOperationTemp;
	assign immediate = immediateTemp;
	//assign cntrlNoWrite = cntrlNoWriteTemp;
	assign cntrlCondFlags = cntrlCondFlagsTemp;	
	assign loadStoreSignals = loadStoreSignalsTemp;
	assign cntrlPcSrc = ((rd==4'b1111) & cntrlRegWrite) | cntrlBranch; //si es un write a PC o un branch 
	assign conditionFlags = instruction[31:28];
	

endmodule
