module decoder_2to4 (
    input   reg [1:0]   in,
    input   reg         en,
    output      [3:0]   out
);
reg [3:0]   out_r=4'b0000;

assign out = out_r;
always @(in or en) begin
    if (!en)
        out_r=8'b zzzzzzzz;
    else begin
        case(in)
            2'b00: out_r = 4'b0001;
            2'b01: out_r = 4'b0010;
            2'b10: out_r = 4'b0100;
            2'b11: out_r = 4'b1000;
        endcase
    end
end


endmodule