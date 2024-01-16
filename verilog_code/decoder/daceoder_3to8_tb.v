module  decoder_3to8_tb;


reg [2:0]   in=3'b000;
reg         en=1'b0;

wire [7:0]  out;
initial begin
    #50 in=3'b000;
    #50 en=1'b1;
        in=3'b001;
    #50 in=3'b010;
    #50 in=3'b011;
    #50 in=3'b100;
    #50 in=3'b101;
    #50 in=3'b110;
    #50 in=3'b111;
end

decoder_3to8 decoder_3to8_my(
    .in(in),
    .en(en),
    .out(out)
);
endmodule


