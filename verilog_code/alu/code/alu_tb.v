`timescale 1ns/1ns
module alu_tb;

reg alu_sel_r;
reg [7:0] reg_1;
reg [7:0] reg_2;
reg [2:0] alu_order;
wire alu_out;

wire [7:0] reg_1_w;
wire [7:0] reg_2_w;
wire alu_sel_w;
wire [2:0] alu_order_w;
assign reg_1_w = reg_1;
assign reg_2_w = reg_2;
assign alu_sel_w = alu_sel_r;
assign alu_order_w = alu_order;

initial begin
    
   alu_sel_r=1'b0;
   alu_order=3'b000;
   reg_1=8'b11110000;
   reg_2=8'b00001111;
   #50 alu_sel_r=1'b1;

   #50 alu_order=3'b001;
   #50 alu_order=3'b010;
   #50 alu_order=3'b011;
   #50 alu_order=3'b100;
   #50 alu_order=3'b101;
   #50 alu_order=3'b110;
end

alu alu_my( .alu_sel(alu_sel_w),
        .alu_order(alu_order_w),
        .reg_1(reg_1_w),
        .reg_2(reg_2_w),
        .alu_out(alu_out) ); 



endmodule
