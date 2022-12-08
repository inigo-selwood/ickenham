module AccessStage(
	clockIn,
	resetIn,
	
	instructionIn,
	addressIn,
	startIn,
	
	sourceAddressOut,
	sourceValueOut,
	sourceLoadOut,
	sourceStoreOut,
	sourceValueIn,
	sourceReadyIn,
	
	operandsIn,
	resultsIn,
	
	operandsOut,
	resultsOut,
	valueOut,
	
	instructionOut,
	addressOut,
	readyOut
);
	
	input clockIn;
	input resetIn;
	
	input [31:0] instructionIn;
	input [31:0] addressIn;
	input        startIn;
	
	output logic [31:0] sourceAddressOut;
	output logic [31:0] sourceValueOut;
	output logic        sourceLoadOut;
	output logic        sourceStoreOut;
	input        [31:0] sourceValueIn;
	input               sourceReadyIn;
	
	input [31:0] operandsIn [4];
	input [31:0] resultsIn [2];
	
	output logic [31:0] operandsOut [4];
	output logic [31:0] resultsOut [2];
	output logic [31:0] valueOut;
	
	output logic [31:0] instructionOut;
	output logic [31:0] addressOut;
	output logic        readyOut;

endmodule