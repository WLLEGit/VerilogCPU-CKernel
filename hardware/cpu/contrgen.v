module contr_gen (
    input [31:0]instr,
    output reg [2:0] extop,
    output reg regwr,
    output reg ALUAsrc,
    output reg [1:0] ALUBsrc,
    output reg [3:0] ALUctr,
    output reg [2:0] branch,
    output reg MemtoReg,
    output reg memwr,
    output reg [2:0] memop
);

wire [6:0]op_ = instr[6:0];
wire [2:0]func3 = instr[14:12];
wire [6:0]func7_ = instr[31:25];

wire [4:0]op = op_[6:2];
wire func7 = func7_[5];

always @(*) begin
    if(op==5'b01101 || op==5'b00101)
        extop <= 3'b001;
    else if(op==5'b01000)
        extop <= 3'b010;
    else if(op==5'b11000)
        extop <= 3'b011;
    else if(op==5'b11011)
        extop <= 3'b100;
    else
        extop <= 3'b000;
end

always @(*) begin
    if(op==5'b11000 || op==5'b01000)
        regwr<=1'b0;
    else
        regwr<=1'b1;
end

always @(*) begin
    if(op==5'b11011)
        branch<=3'b001;
    else if(op==5'b11001)
        branch<=3'b010;
    else if(op==5'b11000) begin
        case (func3)
            3'b000: branch<=3'b100;
            3'b001: branch<=3'b101; 
            3'b100: branch<=3'b110; 
            3'b101: branch<=3'b111; 
            3'b110: branch<=3'b110; 
            3'b111: branch<=3'b111; 
            default: branch<=3'b000;
        endcase
    end else
        branch<=3'b000;
end

always @(*) begin
    MemtoReg<=(op==5'b00000);
end

always @(*) begin
    memwr <= (op==5'b01000);
end

always @(*) begin
    if(op==5'b00000) begin
        case (func3)
            3'b000: memop<=3'b000; 
            3'b001: memop<=3'b001; 
            3'b010: memop<=3'b010; 
            3'b100: memop<=3'b100; 
            3'b101: memop<=3'b101; 
            default: memop<=3'b000;
        endcase
    end else if(op==5'b01000) begin
        case (func3)
            3'b000: memop<=3'b000; 
            3'b001: memop<=3'b001; 
            3'b010: memop<=3'b010; 
            default: memop <= 3'b000;
        endcase
    end else
        memop <= 3'b000;
end

always @(*) begin
    if(op==5'b00101 || op==5'b11011 || op==5'b11001)
        ALUAsrc<=1'b1;
    else
        ALUAsrc<=1'b0;
end

always @(*) begin
    if(op==5'b01101 || op==5'b00101 || op==5'b00100 || op==5'b00000 || op==5'b01000)
        ALUBsrc<=2'b01;
    else if(op==5'b11011 || op==5'b11001)
        ALUBsrc<=2'b10;
    else
        ALUBsrc<=2'b00;
end

always @(*) begin
    if(op==5'b01101) ALUctr <= 4'b0011;
    else if(op==5'b00101) ALUctr <= 4'b0000;
    else if(op==5'b00100 && func3==3'b000) ALUctr <= 4'b0000;
    else if(op==5'b00100 && func3==3'b010) ALUctr <= 4'b0010;
    else if(op==5'b00100 && func3==3'b011) ALUctr <= 4'b1010;
    else if(op==5'b00100 && func3==3'b100) ALUctr <= 4'b0100;
    else if(op==5'b00100 && func3==3'b110) ALUctr <= 4'b0110;
    else if(op==5'b00100 && func3==3'b111) ALUctr <= 4'b0111;
    else if(op==5'b00100 && func3==3'b001 && func7 == 1'b0) ALUctr <= 4'b0001;
    else if(op==5'b00100 && func3==3'b101 && func7 == 1'b0) ALUctr <= 4'b0101;
    else if(op==5'b00100 && func3==3'b101 && func7 == 1'b1) ALUctr <= 4'b1101;
    else if(op==5'b01100 && func3==3'b000 && func7 == 1'b0) ALUctr <= 4'b0000;
    else if(op==5'b01100 && func3==3'b000 && func7 == 1'b1) ALUctr <= 4'b1000;
    else if(op==5'b01100 && func3==3'b001 && func7 == 1'b0) ALUctr <= 4'b0001;
    else if(op==5'b01100 && func3==3'b010 && func7 == 1'b0) ALUctr <= 4'b0010;
    else if(op==5'b01100 && func3==3'b011 && func7 == 1'b0) ALUctr <= 4'b1010;
    else if(op==5'b01100 && func3==3'b100 && func7 == 1'b0) ALUctr <= 4'b0100;
    else if(op==5'b01100 && func3==3'b101 && func7 == 1'b0) ALUctr <= 4'b0101;
    else if(op==5'b01100 && func3==3'b101 && func7 == 1'b1) ALUctr <= 4'b1101;
    else if(op==5'b01100 && func3==3'b110 && func7 == 1'b0) ALUctr <= 4'b0110;
    else if(op==5'b01100 && func3==3'b111 && func7 == 1'b0) ALUctr <= 4'b0111;
    else if(op==5'b11011) ALUctr <= 4'b0000;
    else if(op==5'b11001 && func3==3'b000) ALUctr <= 4'b0000;
    else if(op==5'b11000 && func3==3'b000) ALUctr <= 4'b0010;
    else if(op==5'b11000 && func3==3'b001) ALUctr <= 4'b0010;
    else if(op==5'b11000 && func3==3'b100) ALUctr <= 4'b0010;
    else if(op==5'b11000 && func3==3'b101) ALUctr <= 4'b0010;
    else if(op==5'b11000 && func3==3'b110) ALUctr <= 4'b1010;
    else if(op==5'b11000 && func3==3'b111) ALUctr <= 4'b1010;
    else if(op==5'b00000 && func3==3'b000) ALUctr <= 4'b0000;
    else if(op==5'b00000 && func3==3'b001) ALUctr <= 4'b0000;
    else if(op==5'b00000 && func3==3'b010) ALUctr <= 4'b0000;
    else if(op==5'b00000 && func3==3'b100) ALUctr <= 4'b0000;
    else if(op==5'b00000 && func3==3'b101) ALUctr <= 4'b0000;
    else if(op==5'b01000 && func3==3'b000) ALUctr <= 4'b0000;
    else if(op==5'b01000 && func3==3'b001) ALUctr <= 4'b0000;
    else if(op==5'b01000 && func3==3'b010) ALUctr <= 4'b0000;
    else ALUctr<=4'b0000;
end
    
endmodule