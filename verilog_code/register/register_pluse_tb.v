`timescale 1ns/1ns
module register_pluse_tb;

reg           save_en=1'b 0;
reg           load_en=1'b 0;
reg [7:0]     data_in=8'b 00000000;

wire    [7:0]   data_out;
wire    [7:0]   data_out_always;

initial begin
    #50 data_in=8'b 00000001;
        save_en=1'b 1;
    #50 save_en=1'b0;

    #50 load_en=1'b1;
    #50 load_en=1'b0;

    #50 data_in=8'b 00000011;
        save_en=1'b 1;
    #50 save_en=1'b0;

    #50 load_en=1'b1;
    #50 load_en=1'b0;
end

register_pluse register_pluse_my(
    .save_en(save_en),
    .load_en(load_en),
    .data_in(data_in),

    .data_out(data_out),
    .data_out_always(data_out_always)
);

endmodule
