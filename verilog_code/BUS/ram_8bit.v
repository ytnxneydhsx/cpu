module ram_8bit(
    input wire clk, // 时钟信号
    input wire rst, // 复位信号
    input wire we,  // 写使能信号，高电平有效
    input wire [7:0] data_in, // 数据输入
    input wire [7:0] addr,    // 地址总线
    
    output reg [7:0] data_out // 数据输出
);

// 定义一个256x8位的RAM存储空间
reg [7:0] ram[255:0];

integer i; // 用于复位过程中的循环变量

// 同步读写操作，添加异步复位逻辑
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // 异步复位，将RAM的每个位置清零
        for (i = 0; i < 256; i = i + 1) begin
            ram[i] <= 8'b0;
        end
    end else begin
        if (we) begin
            // 写操作
            ram[addr] <= data_in;
            data_out <= 8'bzzzzzzzz; // 写模式时，输出设置为高阻态
        end else begin
            // 读操作
            data_out <= ram[addr];
        end
    end
end

endmodule