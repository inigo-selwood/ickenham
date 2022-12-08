module ExecuteStage(
	clockIn,
	resetIn,
	
	startIn,
	instructionIn,
	addressIn,
	
	operandsIn,
	
	operandsOut,
	
	resultsOut,
	
	instructionOut,
	addressOut,
	readyOut
);

	input clockIn;
	input resetIn;
	
	input startIn;
	input [31:0] instructionIn;
	input [31:0] addressIn;
	
	input [31:0] operandsIn [4];
	
	output logic [31:0] operandsOut [4];
	output logic [31:0] resultsOut  [2];
	
	output logic [31:0] instructionOut;
	output logic [31:0] addressOut;
	output logic    	  readyOut;

endmodule