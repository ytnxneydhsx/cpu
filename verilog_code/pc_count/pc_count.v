module pc_counter(
    input reg clk,          // 时钟信号线，决定了CPU的频率
    input reg reset,        // 复位信号，高脉冲后计数器归零
    input reg model_sel,    // 模式选择，0为步进模式，1为擦写模式
    input reg [7:0] load_value, // 擦写模式时载入的值
    output reg [7:0] pc     // 向RAM输出的地址
);

// 在时钟上升沿和/或复位信号的上升沿发生时，根据模式选择信号更新PC的值
always @(posedge clk or posedge reset) begin
    if (reset) begin
        pc <= 8'b0;  // 复位信号激活时，PC归零
    end else if (model_sel) begin
        pc <= load_value; // 如果处于擦写模式，PC更新为load_value
    end else begin
        pc <= pc + 1; // 步进模式，PC按顺序递增
    end
end
endmodule