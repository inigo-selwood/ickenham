module Ickenham(
	clockIn,
	resetIn,
	
	addressOut,
	valueOut,
	loadOut,
	storeOut,
	
	valueIn,
	readyIn
);

	input clockIn;
	input resetIn;
	
	output [31:0] addressOut;
	output [31:0] valueOut;
	output 		  loadOut;
	output 		  storeOut;
	
	input [31:0] valueIn;
	input        readyIn;
	
	Pipeline pipeline(
		.clockIn(clockIn),
		.resetIn(resetIn),
		
		.sourceAddressOut(addressOut),
		.sourceValueOut(valueOut),
		.sourceLoadOut(loadOut),
		.sourceStoreOut(storeOut),
		.sourceValueIn(valueIn),
		.sourceReadyIn(readyIn)
	);

endmodule