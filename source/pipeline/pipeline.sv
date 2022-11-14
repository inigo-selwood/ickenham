module Pipeline(
    clockIn,
    resetIn,

    sourceAddressOut,
    sourceValueOut,
    sourceLoadOut,
    sourceStoreOut,
    sourceValueIn,
    sourceReadyIn
);

    input clockIn;
    input resetIn;

    output [31:0] sourceAddressOut;
    output [31:0] sourceValueOut;
    output        sourceLoadOut;
    output        sourceStoreOut;
    input  [31:0] sourceValueIn;
    input         sourceReadyIn;

    localparam INDEX_FETCH   = 0;
    localparam INDEX_DECODE  = 1;
    localparam INDEX_EXECUTE = 2;
    localparam INDEX_ACCESS  = 3;
    localparam INDEX_WRITE   = 4;

    wire [31:0] jumpAddress;
    wire        jumpLatch;

    wire readyBits [5];
    wire startBits [5];
    wire resetBits [5];

    Controller controller(
        .clockIn(clockIn),
        .resetIn(resetIn),

        .jumpLatchIn(jumpLatch),

        .readyBitsIn(readyBits),

        .startBitsOut(startBits),
        .resetBitsOut(resetBits)
    );

    logic [31:0] sourceAddresses [2];
    logic [31:0] sourceValuesOut [2];
    logic        sourceLoadBits  [2];
    logic        sourceStoreBits [2];
    logic [31:0] sourceValuesIn  [2];
    logic        sourceReadyBits [2];

    AccessMediator #(.WAYS(2)) accessMediator(
        .clockIn(clockIn),
        .resetIn(resetIn),

        .addressOut(sourceAddressOut),
        .valueOut(sourceValueOut),
        .loadOut(sourceLoadOut),
        .storeOut(sourceStoreOut),
        .valueIn(sourceValueIn),
        .readyIn(sourceReadyIn),

        .addressesIn(sourceAddresses),
        .valuesOutIn(sourceValuesOut),
        .loadBitsIn(sourceLoadBits),
        .storeBitsIn(sourceStoreBits),
        .valuesInOut(sourceValuesIn),
        .readyBitsOut(sourceReadyBits)
    );

    wire [4:0] fileLoadIndices    [4];
    wire [4:0] fileReserveIndices [2];
    wire [3:0] fileStoreIndices   [2];

    wire [31:0] fileLoadValues  [4];
    wire [31:0] fileStoreValues [2];

    wire fileLoadLatch;
    wire fileStoreLatch;

    wire fileReady;

    RegisterFile registerFile(
        .clockIn(clockIn),
        .resetIn(resetIn),

        .loadIndicesIn(fileLoadIndices),
        .reserveIndicesIn(fileReserveIndices),
        .storeIndicesIn(fileStoreIndices),

        .loadValuesOut(fileLoadValues),
        .storeValuesIn(fileStoreValues),

        .loadLatchIn(fileLoadLatch),
        .storeLatchIn(fileStoreLatch),

        .readyOut(fileReady)
    );

    wire [31:0] instructions [4];
    wire [31:0] addresses    [4];

    FetchStage fetchStage(
        .clockIn(clockIn),
        .resetIn(resetBits[INDEX_FETCH]),

        .startIn(startBits[INDEX_FETCH]),

        .jumpAddressIn(jumpAddress),
        .jumpLatchIn(jumpLatch),

        .sourceAddressOut(sourceAddresses[0]),
        .sourceLoadOut(sourceLoadBits[0]),
        .sourceValueIn(sourceValuesIn[0]),
        .sourceReadyIn(sourceReadyBits[0]),

        .instructionOut(instructions[INDEX_FETCH]),
        .addressOut(addresses[INDEX_FETCH]),
        .readyOut(readyBits[INDEX_FETCH])
    );

    // Unused
    assign sourceValuesOut[0] = 0;
    assign sourceStoreBits[0] = 0;

    wire [31:0] operands [INDEX_WRITE:INDEX_DECODE][4];

    DecodeStage decodeStage(
        .clockIn(clockIn),
        .resetIn(resetBits[INDEX_DECODE]),

        .startIn(startBits[INDEX_DECODE]),
        .instructionIn(instructions[INDEX_FETCH]),
        .addressIn(addresses[INDEX_FETCH]),

        .fileLoadIndicesOut(fileLoadIndices),
        .fileReserveIndicesOut(fileReserveIndices),
        .fileLoadValuesIn(fileLoadValues),
        .fileLoadLatchOut(fileLoadLatch),
        .fileReadyIn(fileReady),

        .operandsOut(operands[INDEX_DECODE]),
        
        .instructionOut(instructions[INDEX_DECODE]),
        .addressOut(addresses[INDEX_DECODE]),
        .readyOut(readyBits[INDEX_DECODE])

    );

    wire [31:0] results [INDEX_WRITE:INDEX_EXECUTE][2];

    ExecuteStage executeStage(
        .clockIn(clockIn),
        .resetIn(resetBits[INDEX_EXECUTE]),

        .startIn(startBits[INDEX_EXECUTE]),
        .instructionIn(instructions[INDEX_DECODE]),
        .addressIn(addresses[INDEX_DECODE]),

        .operandsIn(operands[INDEX_DECODE]),

        .operandsOut(operands[INDEX_EXECUTE]),
        .resultsOut(results[INDEX_EXECUTE]),

        .instructionOut(instructions[INDEX_EXECUTE]),
        .addressOut(addresses[INDEX_EXECUTE]),
        .readyOut(readyBits[INDEX_EXECUTE])
    );

    wire [31:0] accessValue;

    AccessStage accessStage(
        .clockIn(clockIn),
        .resetIn(resetBits[INDEX_ACCESS]),

        .startIn(startBits[INDEX_ACCESS]),
        .instructionIn(instructions[INDEX_EXECUTE]),
        .addressIn(addresses[INDEX_EXECUTE]),

        .sourceAddressOut(sourceAddresses[1]),
        .sourceValueOut(sourceValuesOut[1]),
        .sourceLoadOut(sourceLoadBits[1]),
        .sourceStoreOut(sourceStoreBits[1]),
        .sourceValueIn(sourceValuesIn[1]),
        .sourceReadyIn(sourceReadyBits[1]),

        .operandsIn(operands[INDEX_EXECUTE]),
        .resultsIn(results[INDEX_EXECUTE]),

        .operandsOut(operands[INDEX_ACCESS]),
        .resultsOut(results[INDEX_ACCESS]),
        .valueOut(accessValue),

        .instructionOut(instructions[INDEX_ACCESS]),
        .addressOut(addresses[INDEX_ACCESS]),
        .readyOut(readyBits[INDEX_ACCESS])
    );

    WriteStage writeStage(
        .clockIn(clockIn),
        .resetIn(resetBits[INDEX_WRITE]),

        .startIn(startBits[INDEX_WRITE]),
        .instructionIn(instructions[INDEX_ACCESS]),
        .addressIn(addresses[INDEX_ACCESS]),

        .operandsIn(operands[INDEX_ACCESS]),
        .resultsIn(results[INDEX_ACCESS]),
        .valueIn(accessValue),

        .fileStoreIndicesOut(fileStoreIndices),
        .fileStoreValuesOut(fileStoreValues),
        .fileStoreLatchOut(fileStoreLatch),

        .jumpAddressOut(jumpAddress),
        .jumpLatchOut(jumpLatch),

        .readyOut(readyBits[INDEX_WRITE])
    );

endmodule