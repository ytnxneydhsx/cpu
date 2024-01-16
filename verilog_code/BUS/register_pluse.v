module register_pluse (
    input reg         save_en,
    input reg         load_en,
    input reg   [7:0] data_in,

    output      [7:0] data_out,
    output      [7:0] data_out_always
);


reg [7:0] data_reg=8'b 00000000;  //寄存器内储存的值
reg [7:0] data_out_reg=8'b 00000000;  //输出值
assign data_out_always=data_reg;
assign data_out=data_out_reg;

always  @(save_en or load_en or data_in)   begin
    if(save_en) begin
        data_reg=data_in;
    end
    else begin
        data_reg=data_reg;
    end
    
    if (load_en) begin
        data_out_reg=data_reg;
    end
    else begin
        data_out_reg=8'b zzzzzzzz;
    end
end

endmodule