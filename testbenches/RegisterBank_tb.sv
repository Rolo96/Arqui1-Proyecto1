module RegisterBank_tb();
	// Inputs
	bit clk;
	bit writeEnabled;
	logic [3:0] regAddress1;
	logic [3:0] regAddress2;
	logic [3:0] writeAddress;
	logic [31:0] writeData;
	logic [31:0] pc;
	
	//Outputs
	logic [31:0] dataOut1;
	logic [31:0] dataOut2;

	//Instancia del Device Under Test (DUT)
	RegisterBank DUT( .clk( clk ),
					.writeEnabled( writeEnabled ),
					.regAddress1( regAddress1 ),
					.regAddress2( regAddress2 ),
					.writeAddress( writeAddress ),
					.writeData( writeData ),
					.pc( pc ),
					.dataOut1( dataOut1 ),
					.dataOut2( dataOut2 ) );

   //Inicializa clock
	initial begin
		clk = 1'b1;
		forever begin
			#5;
			clk = ~clk;
		end
	end

	initial begin
		// Inicializa Inputs
		regAddress1 = 4'bxxxx;
		regAddress2 = 4'bxxxx;
		writeAddress = 4'bxxxx;
		writeData = 4'bxxxx;
		pc = 4'bxxxx;
		
		//Valores iniciales para guardar en registros
		writeAddress = 4'b0000;
		writeEnabled = 1'b1;
		writeData = 32'd4;
		
		//loop para guardar un dato diferente en diferente direccion de memoria
      for( int i=0; i<16; i++ ) 
			begin
				#10;
				writeAddress = writeAddress + 1'b1;    
				writeData = writeData + 32'd4;
			end

		//se cierran los imputs
		writeEnabled = 1'b0;
		writeAddress = 4'bxxxx;
		writeData = 32'bx;
		
		#10;
		
		//se inicializan las direcciones de salidas
		regAddress1 = 4'b0000;
		regAddress2 = 4'b0001;
		//loop para leer los registros 
		for( int j=0; j<8; j++ ) 
			begin
				#10;
            regAddress1 = regAddress1 + 2'b10;
            regAddress2 = regAddress2 + 2'b10;
			end
		$stop;
	end
endmodule