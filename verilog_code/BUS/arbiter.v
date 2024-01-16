module arbiter (
    input reg [7:0] reg_0,
    input reg [7:0] reg_3,
    input reg [2:0] arbiter_order,
    input reg       arbiter_sel,
    output    [7:0] arbiter_out
);

parameter never =3'b000;
parameter value_zeros=3'b001;
parameter value_small_zero=3'b010;
parameter value_small_or_zero=3'b011;
parameter Always = 3'b100;
parameter value_not_equal_zero=3'b101;
parameter value_big_or_zero=3'b110;
parameter value_big_zero=3'b111;


parameter anchoring_number=8'b11110000;

reg [7:0] arbiter_out_r;
assign arbiter_out=arbiter_out_r;

always @(arbiter_order or arbiter_sel   )begin
    if (arbiter_sel==1'b0)
        arbiter_out_r=8'b zzzzzzzz;
    else if (arbiter_sel==1'b1) begin
        case(arbiter_order)
            never: 
                arbiter_out_r=8'b zzzzzzzz;
            value_zeros:
                if (reg_3==anchoring_number)
                    arbiter_out_r=reg_0;
                else
                    arbiter_out_r=8'b zzzzzzzz;
            value_small_zero:
                if (reg_3<anchoring_number)
                    arbiter_out_r=reg_0;
                else
                    arbiter_out_r=8'b zzzzzzzz;
            value_small_or_zero:
                if (reg_3<=anchoring_number)
                    arbiter_out_r=reg_0;
                else
                    arbiter_out_r=8'b zzzzzzzz;
            Always:
                arbiter_out_r=reg_0;
            value_not_equal_zero:
                if (reg_3!=anchoring_number)
                    arbiter_out_r=reg_0;
                else
                    arbiter_out_r=8'b zzzzzzzz;
            value_big_or_zero:
                if (reg_3>=anchoring_number)
                    arbiter_out_r=reg_0;
                else
                    arbiter_out_r=8'b zzzzzzzz;
            value_big_zero:
                if (reg_3>anchoring_number)
                    arbiter_out_r=reg_0;
                else
                    arbiter_out_r=8'b zzzzzzzz;
        endcase
    end
end







    
endmodule