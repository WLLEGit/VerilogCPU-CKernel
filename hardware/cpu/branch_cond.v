module branch_cond (
    input less,
    input zero,
    input [2:0]branch,
    output reg PCAsrc,
    output reg PCBsrc
);

always @(*) begin
    case (branch)
        3'b000: begin
            PCAsrc<=1'b0; PCBsrc<=1'b0;
        end 3'b001: begin
            PCAsrc<=1'b1; PCBsrc<=1'b0;
        end 3'b010: begin
            PCAsrc<=1'b1; PCBsrc<=1'b1;
        end 3'b100: begin
            PCAsrc<=zero; PCBsrc<=1'b0;
        end 3'b101: begin
            PCAsrc<=~zero; PCBsrc<=1'b0;
        end 3'b110: begin
            PCAsrc<=less; PCBsrc<=1'b0;
        end 3'b111: begin
            PCAsrc<=~less; PCBsrc<=1'b0;
        end 
        default: begin PCAsrc<=1'b0; PCBsrc<=1'b1; end
    endcase
end

    
endmodule