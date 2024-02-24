module arbiter (
    input reg [7:0] reg_0,
    input reg [7:0] reg_3,
    input reg [2:0] arbiter_order,
    input reg       arbiter_sel,
    
    output    [7:0] arbiter_out,
    output          pc_sel
);

parameter never =3'b000;
parameter value_zeros=3'b001;
parameter value_small_zero=3'b010;
parameter value_small_or_zero=3'b011;
parameter Always = 3'b100;
parameter value_not_equal_zero=3'b101;
parameter value_big_or_zero=3'b110;
parameter value_big_zero=3'b111;

reg [7:0] arbiter_out_r;
reg pc_sel_r;
assign arbiter_out=arbiter_out_r;
assign pc_sel=pc_sel_r;
always @(arbiter_order or arbiter_sel )begin
    if (arbiter_sel==1'b0) begin
        arbiter_out_r<=8'b zzzzzzzz;
        pc_sel_r<=1'b0;
   end
   else if (arbiter_sel==1'b1) begin
        case(arbiter_order)
            never:  begin
                arbiter_out_r<=8'b zzzzzzzz;
                pc_sel_r<=1'b0;
            end
            value_zeros: begin
                if (reg_3==3'b000) begin
                    arbiter_out_r<=reg_0;
                    pc_sel_r<=1'b1;
                end
                else begin
                    arbiter_out_r<=8'b zzzzzzzz;
                    pc_sel_r<=1'b0;
                end
            end
            value_small_zero:  begin
                if (reg_3<3'b000) begin
                    arbiter_out_r<=reg_0;
                    pc_sel_r<=1'b1;
                 end
                else begin
                    arbiter_out_r<=8'b zzzzzzzz;
                    pc_sel_r<=1'b0;
                end
            end
            value_small_or_zero: begin
                if (reg_3<=3'b000) begin
                    arbiter_out_r<=reg_0;
                    pc_sel_r<=1'b1;
                end
                else begin
                    arbiter_out_r<=8'b zzzzzzzz;
                    pc_sel_r<=1'b0;
                end
            end
            Always: begin
                arbiter_out_r<=reg_0;
                pc_sel_r<=1'b1;
            end
            value_not_equal_zero: begin
                if (reg_3!=3'b000) begin
                    arbiter_out_r<=reg_0;
                    pc_sel_r<=1'b1;
                end
                else begin
                    arbiter_out_r<=8'b zzzzzzzz;
                    pc_sel_r<=1'b0;
                end
             end
            value_big_or_zero: begin
                if (reg_3>=3'b000) begin
                    arbiter_out_r<=reg_0;
                    pc_sel_r<=1'b1;
                end
                else begin
                    arbiter_out_r<=8'b zzzzzzzz;
                    pc_sel_r<=1'b0;
                end
            end
            value_big_zero: begin
                if (reg_3>3'b000) begin
                    arbiter_out_r<=reg_0;
                    pc_sel_r<=1'b1;
                end             
                else begin
                    arbiter_out_r<=8'b zzzzzzzz;
                    pc_sel_r<=1'b0;
                end
            end
        endcase
    end
end
endmodule
