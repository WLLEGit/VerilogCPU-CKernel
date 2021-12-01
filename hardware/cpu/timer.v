`include "define.v"

module timer_device (
    input clr,
    input clk,
    input global_int_en,
    output irq_pin
);

integer i;
parameter MS500 = 25000000, MS250=12500000, MS1000=500;
assign irq_pin = global_int_en && ((i&32'hfffffff8)==32'h0);
always @(posedge clk) begin
    if(clr) begin
        i <= 0;
    end else begin
        if(i >= MS1000) begin
            i <= 0;
        end else begin
            i <= i + 1;
        end
    end
end
    
endmodule