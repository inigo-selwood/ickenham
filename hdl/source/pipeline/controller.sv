module Controller(
	clockIn,
	resetIn,

	jumpLatchIn,
	
	readyBitsIn,
	
	startBitsOut,
	resetBitsOut
);

	input clockIn;
	input resetIn;

	input jumpLatchIn;
	
	input readyBitsIn [5];
	
	output logic startBitsOut [5];
	output logic resetBitsOut [5];

	logic ready;

	always_ff @(posedge clockIn, posedge resetIn) begin
		for(int index = 0; index < 5; index += 1) begin
			resetBitsOut[index] <= resetIn;
			startBitsOut[index] <= resetIn ? 0 : ready;
		end
	end

	always_comb begin
		ready = resetIn 
				? 0 
				: (readyBitsIn[0] 
					&& readyBitsIn[1]
					&& readyBitsIn[2]
					&& readyBitsIn[3]
					&& readyBitsIn[4]);
	end

endmodule