`timescale 1ns/1ns

module bus_tb;


reg [7:0]   code_in=8'b zzzzzzzz;
reg [7:0]   data_in=8'b zzzzzzzz;

wire  [7:0] data_out;
wire  [7:0] code_addr_out;



initial begin
    #50  data_in=8'b11110000;
    #50  code_in=8'b 00_111_000;  //从输入赋予寄存器0

    #50  code_in=8'b 00_111_011;
    #50  data_in=8'b11110001;

    #50  code_in=8'b 11_000_000; //never
    #50  code_in=8'b 11_000_100; //always

    #50  code_in=8'b 11_000_110; //>=
    #50  code_in=8'b 11_000_010; //<




    
 
end




bus bus_my(
    .code_in    (code_in),
    .data_in    (data_in),
    .data_out   (data_out),
    .code_addr_out (code_addr_out)
);

endmodule