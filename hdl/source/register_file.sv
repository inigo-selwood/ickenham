module RegisterFile(
	clockIn,
	resetIn,
	
	loadIndicesIn,
	reserveIndicesIn,
	storeIndicesIn,
	
	loadValuesOut,
	storeValuesIn,
	
	loadLatchIn,
	storeLatchIn,
	
	readyOut
);

	input clockIn;
	input resetIn;
	
	input [4:0] loadIndicesIn    [4];
	input [4:0] reserveIndicesIn [2];
	input [4:0] storeIndicesIn   [2];
	
	output logic [31:0] loadValuesOut [4];
	input        [31:0] storeValuesIn [2];
	
	input loadLatchIn;
	input storeLatchIn;
	
	output logic readyOut;
		
endmodule