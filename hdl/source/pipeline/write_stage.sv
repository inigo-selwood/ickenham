module WriteStage(
	clockIn,
	resetIn,
	
	startIn,
	instructionIn,
	addressIn,
	
	operandsIn,
	resultsIn,
	valueIn,
	
	fileStoreIndicesOut,
	fileStoreValuesOut,
	fileStoreLatchOut,
	
	jumpAddressOut,
	jumpLatchOut,
	
	readyOut
);

	input clockIn;
	input resetIn;
	
	input startIn;
	input [31:0] instructionIn;
	input [31:0] addressIn;
	
	input [31:0] operandsIn [4];
	input [31:0] resultsIn [2];
	input [31:0] valueIn;
	
	output logic [4:0]  fileStoreIndicesOut [2];
	output logic [31:0] fileStoreValuesOut  [2];
	output logic        fileStoreLatchOut;
	
	output logic [31:0] jumpAddressOut;
	output logic        jumpLatchOut;
	
	output logic readyOut;

endmodule