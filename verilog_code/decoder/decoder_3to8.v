module decoder_3to8 (
    input   reg [2:0]   in,
    input   reg         en,
    output      [7:0]   out
);
reg [7:0]   out_r=8'b0000000;

assign out = out_r;
always @(in or en) begin
    if (!en)
        out_r=8'b zzzzzzzz;
    else begin
        case(in)
            3'b000: out_r = 8'b0000_0001;
            3'b001: out_r = 8'b0000_0010;
            3'b010: out_r = 8'b0000_0100;
            3'b011: out_r = 8'b0000_1000;
            3'b100: out_r = 8'b0001_0000;
            3'b101: out_r = 8'b0010_0000;
            3'b110: out_r = 8'b0100_0000;
            3'b111: out_r = 8'b1000_0000;
        endcase
    end
end


endmodule