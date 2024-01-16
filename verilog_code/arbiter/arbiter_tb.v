`timescale 1ns/1ns
module  arbiter_tb;

reg [7:0] reg_0;
reg [7:0] reg_3;
reg [2:0] arbiter_order;
reg       arbiter_sel;

wire [7:0] arbiter_out;


initial begin
    reg_0=8'b11110000;
    reg_3=8'b00000001;
    arbiter_sel=1'b0;
    arbiter_order=3'b000;
    #50 arbiter_sel=1'b1;
    #50 arbiter_order=3'b001;
    #50 arbiter_order=3'b010;
    #50 arbiter_order=3'b011;
    #50 arbiter_order=3'b100;
    #50 arbiter_order=3'b101;
    #50 arbiter_order=3'b110;
    #50 arbiter_order=3'b111;
end


arbiter arbiter_my(
    .reg_0 (reg_0),
    .reg_3 (reg_3),
    .arbiter_order (arbiter_order),
    .arbiter_sel (arbiter_sel),
    .arbiter_out (arbiter_out)
);

endmodule













