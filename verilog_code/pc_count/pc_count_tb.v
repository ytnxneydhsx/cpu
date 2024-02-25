`timescale 1ns / 1ps

module pc_counter_tb;

// Inputs
reg clk;
reg reset;
reg model_sel;
reg [7:0] load_value;
reg en;

// Output
wire [7:0] pc;

initial begin
    // 初始化
    clk = 0;
    en=1;
    reset = 0;
    model_sel = 0;
    load_value = 0;

    // 模拟复位
    #10 reset = 1; #10 reset = 0;

    // 步进模式测试
    #20 model_sel = 0;
    
    // 模拟几个时钟周期
    #100;

    // 擦写模式测试，载入值为55
    #10 model_sel = 1; load_value = 8'd55;
    #10 model_sel = 0; // 切换回步进模式
    
    // 继续模拟时钟周期
    #100;
    
    // 模拟结束
    #10 $finish;
end

// 产生时钟信号
always #5 clk = !clk;

endmodule

// 实例化PC计数器模块
pc_counter uut (
    .clk(clk), 
    .reset(reset), 
    .model_sel(model_sel), 
    .load_value(load_value), 
    .en  (en),
    .pc(pc)
);