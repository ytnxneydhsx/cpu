`timescale 1ns / 1ps

module ram_8bit_tb;

reg clk;
reg rst;
reg we;
reg [7:0] data_in;
reg [7:0] addr;
wire [7:0] data_out;

// 实例化ram_8bit模块
ram_8bit uut (
    .clk(clk),
    .rst(rst),
    .we(we),
    .data_in(data_in),
    .addr(addr),
    .data_out(data_out)
);

// 产生时钟信号
always #10 clk = ~clk; // 产生50MHz的时钟信号

// 测试过程
initial begin
    // 初始化信号
    clk = 0;
    rst = 1;
    we = 0;
    data_in = 0;
    addr = 0;

    // 复位RAM
    #20;
    rst = 0; // 释放复位

    // 写入数据到RAM的地址0
    #20;
    we = 1;
    data_in = 8'hA5;
    addr = 8'h00;
    #20;
    we = 0;

    // 读取数据从RAM的地址0
    #20;
    addr = 8'h00;

    // 写入并读取另一个地址的数据
    #20;
    we = 1;
    data_in = 8'h5A;
    addr = 8'h01;
    #20;
    we = 0;
    addr = 8'h01;

    // 观察结果
    #100;
    
    // 结束测试

end

endmodule