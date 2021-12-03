`include "define.v"

module timer_device (
    input clr,
    input clk,
    input global_int_en,
    output irq_pin
);

integer i;
integer inner_sys_time = 0;
parameter MS1 = 50000, US10 = 500;
assign irq_pin = global_int_en && ((i&32'hfffffff8)==32'h0);
always @(posedge clk) begin
    if(clr) begin
        i <= 0;
    end else begin
        if(i >= MS1) begin
            i <= 0;
            inner_sys_time <= inner_sys_time + 1;
        end else begin
            i <= i + 1;
        end
    end
end
    
endmodule