module DecodeStage(
	clockIn,
	resetIn,
	
	startIn,
	instructionIn,
	addressIn,
	
	fileLoadIndicesOut,
	fileReserveIndicesOut,
	fileLoadValuesIn,
	fileLoadLatchOut,
	fileReadyIn,
	
	operandsOut,
	
	instructionOut,
	addressOut,
	readyOut
);

	input clockIn;
	input resetIn;
	
	input 		 startIn;
	input [31:0] instructionIn;
	input [31:0] addressIn;
	
	output logic [4:0]  fileLoadIndicesOut    [4];
	output logic [4:0]  fileReserveIndicesOut [2];
	input        [31:0] fileLoadValuesIn      [4];
	output logic        fileLoadLatchOut;
	input               fileReadyIn;
	
	output logic [31:0] operandsOut [4];
	
	output logic [31:0] instructionOut;
	output logic [31:0] addressOut;
	output logic        readyOut;

endmodule