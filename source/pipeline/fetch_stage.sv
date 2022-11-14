module FetchStage(
    clockIn,
    resetIn,
    
    startIn,
    
    jumpAddressIn,
    jumpLatchIn,
    
    sourceAddressOut,
    sourceLoadOut,
    sourceValueIn,
    sourceReadyIn,
    
    instructionOut,
    addressOut,
    readyOut
);

    input clockIn;
    input resetIn;
    
    input startIn;
    
    input [31:0] jumpAddressIn;
    input        jumpLatchIn;

    output logic [31:0] sourceAddressOut;
    output logic        sourceLoadOut;
    input        [31:0] sourceValueIn;
    input               sourceReadyIn;
    
    output logic [31:0] instructionOut;
    output logic [31:0] addressOut;
    output logic        readyOut;

    typedef enum bit [1:0] {
        STATE_NONE,
        STATE_RESET,
        STATE_LOAD
    } State;

    State state;
    State stateNext;

    logic [31:0] address;
    logic [31:0] addressNext;
    logic        hold;

    always @(posedge clockIn, 
            posedge resetIn, 
            posedge startIn, 
            posedge jumpLatchIn) begin
            
        if(resetIn) begin
            state <= STATE_RESET;
            hold  <= 0;
        end

        else if(startIn) begin
            state <= STATE_LOAD;

            address     <= addressNext;
            addressNext <= addressNext + 1;
            hold        <= 1;
        end

        else begin
            state <= stateNext;
            hold  <= 0;
        end

        if(jumpLatchIn)
            addressNext <= jumpAddressIn;
    end

    always @(state, hold, address) begin
        stateNext = state;

        case(state) 
        STATE_RESET: begin
            sourceAddressOut = 0;
            sourceLoadOut    = 0;

            instructionOut = 0;
            readyOut       = 1;

            stateNext = STATE_NONE;
        end

        STATE_LOAD: begin
            sourceAddressOut = 0;
            sourceLoadOut    = 0;
            if(hold) begin
                sourceAddressOut = address;
                sourceLoadOut    = 1;
            end

            instructionOut = 0;
            readyOut       = 0;
            if(sourceReadyIn) begin
                instructionOut = sourceValueIn;
                readyOut       = 1;

                stateNext = STATE_NONE;
            end
        end
        endcase
    end
    
endmodule