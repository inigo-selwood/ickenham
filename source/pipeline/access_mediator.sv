module AccessMediator(
    clockIn,
    resetIn,
    
    addressOut,
    valueOut,
    loadOut,
    storeOut,
    valueIn,
    readyIn,
    
    addressesIn,
    valuesOutIn,
    loadBitsIn,
    storeBitsIn,
    valuesInOut,
    readyBitsOut
);
    
    parameter WAYS = 2;
    
    input clockIn;
    input resetIn;
    
    output logic [31:0] addressOut;
    output logic [31:0] valueOut;
    output logic        loadOut;
    output logic        storeOut;
    input        [31:0] valueIn;
    input               readyIn;
    
    input        [31:0] addressesIn  [WAYS];
    input        [31:0] valuesOutIn  [WAYS];
    input               loadBitsIn   [WAYS];
    input               storeBitsIn  [WAYS];
    output logic [31:0] valuesInOut  [WAYS];
    output logic        readyBitsOut [WAYS];
    
endmodule