module immediate(
    input reg [5:0] count_in,
    input reg  count_sel,

    output  [7:0] count_out
);

reg [7:0] count_out_r=8'b 00000000;
assign count_out = count_out_r;

always @(count_in or count_sel) begin
    if(count_sel==1'b1)
        count_out_r = {2'b00,count_in};
    else
        count_out_r = 8'bzzzzzzzz;
end
endmodule
