`timescale 1ns/1ns

module bus_tb;

reg         data_in=8'b0;
reg         clk=1'b0;
reg         rst=1'b0;
reg         ram_we=1'bz;
reg [7:0]   ram_data_in=8'b 00000000;
reg         pc_recount=1'b0;




wire  [7:0] data_out;


initial begin
    //从ram输入指令 写操作

    #1   rst=1'b1;
    #1   rst=1'b0;
         ram_we=1'b1;

    #10  ram_data_in=8'b 00_111_000; // 从输入赋予寄存器0       ram地址0
    #10  ram_data_in=8'b10_000_001;  //  复制寄存器0的值到寄存器1  ram地址1
    #10  ram_data_in=8'b 11_000_011; //  复制寄存器0的值到寄存器3  ram地址2
    #10  ram_data_in=8'b 00_000_000; //  从输入赋予寄存器0       ram地址3
    #10  ram_data_in=8'b 11_000_100; //  跳转回ram地址处0

    //从ram读取指令 读操作
    #10  ram_we=1'b0;
        pc_recount=1'b1;
    #10  pc_recount=1'b0;



end

always #5 clk=~clk;


bus bus_my(
    .data_in        (data_in),  //外界输入
    .clk            (clk),
    .rst            (rst),   
    .ram_we         (ram_we),
    .ram_data_in    (ram_data_in),
    .pc_recount     (pc_recount),

    .data_out       (data_out)//输出

);

endmodule