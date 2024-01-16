module alu (
  input       alu_sel,  //是否启用alu
  input [2:0] alu_order, //alu指令
  input [7:0] reg_1,  
  input [7:0] reg_2,
  output [7:0] alu_out    
);
 

parameter alu_or = 3'b 000;
parameter alu_nand = 3'b 001;
parameter alu_nor = 3'b 010;
parameter alu_and = 3'b 011;
parameter alu_add = 3'b 100;
parameter alu_sub = 3'b 101;

reg [7:0]  alu_out_r;
assign alu_out=alu_out_r;
always @(alu_sel or alu_order ) begin //当启用位于alu变动时进行下列操作 （一般情况不会出现两条同样的指令）
    if (alu_sel==1'b0) begin
        alu_out_r=8'b zzzzzzz;
    end
    else if (alu_sel==1'b1) begin
        case (alu_order)
            alu_or: 
                 alu_out_r=reg_1|reg_2;
            alu_nand:
                 alu_out_r=~(reg_1&reg_2);
            alu_nor:
                 alu_out_r=~(reg_1|reg_2);
            alu_and:
                 alu_out_r=reg_1&reg_2;
            alu_add:
                 alu_out_r=reg_1+reg_2;
            alu_sub:
                 alu_out_r=reg_1-reg_2;
            default: 
                 alu_out_r=8'b zzzzzzz;
        endcase

    end
end
endmodule
