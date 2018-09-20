module Decoder_tb();
	logic [3:0] RN;
	logic [3:0] RD;
	logic [3:0] RM;
	logic [7:0] IMM8;
	logic [11:0] IMM12;
	logic [23:0] IMM24;
	logic [3:0] OPCODE;
	logic [4:0] LDSTRSNLS;
	logic [1:0] INSTYPE;
	logic [3:0] CONDI;
	logic S;
	logic I;
	
	logic [31:0] instruction;
	
	logic [3:0] aluOperation; //operacion que hace la alu
	logic [3:0] rd; //registro
	logic [3:0] rn; //registro
	logic [3:0] rm; //registro
	logic [23:0] immediate; //inmediato
	logic [3:0] conditionFlags;
	
	logic [4:0] loadStoreSignals; //bits P-U-B-W-L del load store
	logic [1:0] regSrc; //
	logic [1:0] cntrlImmExt;
	logic cntrlCondFlags;
	logic cntrlBranch;
	logic cntrlPcSrc;
	logic cntrlAluSrc;
	logic cntrlRegWrite;
	logic cntrlMemWrite;
	logic cntrlMemtoReg;
	
	Decoder DUT(
		.instruction(instruction),
		.aluOperation(aluOperation),
		.rd(rd),
		.rn(rn),
		.rm(rm),
		.immediate(immediate),
		.conditionFlags(conditionFlags),
		
		.loadStoreSignals(loadStoreSignals),
		.regSrc(regSrc),
		.cntrlImmExt(cntrlImmExt),
		.cntrlCondFlags(cntrlCondFlags),
		.cntrlBranch(cntrlBranch),
		.cntrlPcSrc(cntrlPcSrc),
		.cntrlAluSrc(cntrlAluSrc),
		.cntrlRegWrite(cntrlRegWrite),
		.cntrlMemWrite(cntrlMemWrite),
		.cntrlMemtoReg(cntrlMemtoReg)
	);
	
	initial begin
		//data proccessing registro (ADD) no activa S
		CONDI = 4'b0000; INSTYPE = 2'b00; I = 1'b0; OPCODE = 4'b0000; S = 1'b0; RN = 4'b1010; RD = 4'b1011; RM = 4'b1101;
		//instruction = 32'b00000000000010101011000000001101;
		instruction = {CONDI,INSTYPE,I,OPCODE,S,RN,RD,8'b00000000,RM}; #5;
		
		//data proccessing inmediato (SUB) activa S
		CONDI = 4'b0000; INSTYPE = 2'b00; I = 1'b1; OPCODE = 4'b0001; S = 1'b1; RN = 4'b1010; RD = 4'b1011; IMM8 = 8'b11111111;
		//instruction = 32'b00000010001110101011000011111111;
		instruction = {CONDI,INSTYPE,I,OPCODE,S,RN,RD,4'b0000,IMM8}; #5;
		
		//load inmediato
		CONDI = 4'b0000; INSTYPE = 2'b01; I = 1'b1; LDSTRSNLS = 5'b00001; RN = 4'b1010; RD = 4'b1011; IMM12 = 12'b111110001111;
		instruction = {CONDI,INSTYPE,I,LDSTRSNLS,RN,RD,IMM12}; #5;
		
		//store
		CONDI = 4'b0000; INSTYPE = 2'b01; I = 1'b0; LDSTRSNLS = 5'b00000; RN = 4'b1010; RD = 4'b1011; RM = 4'b0010;
		instruction = {CONDI,INSTYPE,I,LDSTRSNLS,RN,RD,8'b00000000,RM}; #5;
		
		//branch
		CONDI = 4'b0000; INSTYPE = 2'b10; IMM24 = 24'b100110011111101110111000;
		instruction = {CONDI,INSTYPE,2'b00,IMM24}; #5;
	end
endmodule
