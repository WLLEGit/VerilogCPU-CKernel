module clkgen (
    input clkin,
    input rst,
    input en,
    output reg out
);
parameter clk_f = 1;
parameter countlimit = 25000000/clk_f; //original freq = 50MHz

integer cnt;
always @(posedge clkin) begin
    if(rst) begin
        cnt <= 0;
        out <= 0;
    end else begin
       if(en) begin
           cnt <= cnt + 1'b1;
           if(cnt >= countlimit) begin
               cnt <= 0;
               out <= ~out;
           end else begin
               out <= out;
           end
       end else begin
           cnt <= cnt;
           out <= out;
       end
    end
end

endmodule