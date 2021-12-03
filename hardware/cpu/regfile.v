module regfile (
    input [4:0] ra,
    input [4:0] rb,
    input [4:0] rw,
    input [31:0] busW,
    input wren,
    input clk,
    output [31:0] busA,
    output [31:0] busB
);

reg [31:0] regs[31:0];

assign busA = regs[ra];
assign busB = regs[rb];

integer tmp;
initial begin
    for(tmp=0; tmp<32; tmp=tmp+1) begin
        regs[tmp] = 0;
    end
end

always @(posedge clk) begin
    if(wren) begin
        regs[rw] <= busW;
    end
    regs[0] <= 32'd0;
end
    
endmodule