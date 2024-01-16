module bus(
    input   reg [7:0]   code_in,
    input   reg [7:0]   data_in,  //外界输入



    output      [7:0]   data_out,//输出
    output      [7:0]   code_addr_out
    
);


wire [7:0]   data_save_en;
wire [7:0]   data_load_en;
wire [7:0]   bus_line_w;
wire [3:0]   function_sel_w;
wire [7:0]   reg_0_always_out_w;
wire [7:0]   reg_1_always_out_w;
wire [7:0]   reg_2_always_out_w;
wire [7:0]   reg_3_always_out_w;


reg en =1'b1;
reg [7:0]   bus_line = 8'b00000000;
reg [7:0]   data_load_en_r=8'b00000000;
reg [7:0]   data_save_en_r=8'b00000000;
reg [3:0]   function_sel=2'b00;
reg         reg_3_en=1'b0;
reg         reg_0_en=1'b0;
reg [7:0]   reg_0_always_out;
reg [7:0]   reg_3_always_out;




//最高两位为具体功能 第六位位数据位或地址位
always @(data_save_en or data_load_en or bus_line_w) begin
    data_save_en_r<=data_save_en;
    data_load_en_r<=data_load_en;
    function_sel<=function_sel_w;
    bus_line<=bus_line_w;

    reg_0_always_out<=reg_0_always_out_w;
    reg_3_always_out<=reg_3_always_out_w;
end
//尝试高组态与运算是否为竞争冒险原因 data_save_en_r[3] || function_sel[1]
always @(data_save_en_r[3] or function_sel[1])begin
    if(data_save_en_r[3]==1'b1 ||  function_sel[1]==1'b1)
        reg_3_en=1'b1;
    else
        reg_3_en=1'b0;
end

always @(data_save_en_r[0] or function_sel[2])begin
    if(data_save_en_r[0]==1'b1 ||  function_sel[2]==1'b1)
        reg_0_en=1'b1;
    else
        reg_0_en=1'b0;
end




//功能解码位
decoder_2to4 decoder_2to4_sel(
    .in  (code_in[7:6])   ,
    .en  (en),
    .out (function_sel_w)
);







//寄存器解码
decoder_3to8  decoder_3to8_save(
   .in  (code_in[2:0])   ,
   .en  (function_sel_w[0])        ,

   .out (data_save_en)
);



decoder_3to8  decoder_3to8_load(
   .in  (code_in[5:3])   ,
   .en  (function_sel_w[0])        ,

   .out (data_load_en)
);


//计算单元alu

alu alu_my(
    .alu_sel    (function_sel_w[1]),
    .alu_order    (code_in[2:0]),
    .reg_1   (reg_1_always_out_w),
    .reg_2   (reg_2_always_out_w),

    .alu_out(bus_line_w)
    

);


//立即数模块
immediate immediate_my(
    .count_in(code_in[5:0]),
    .count_sel(function_sel_w[2]),

    .count_out(bus_line_w)

);

arbiter arbiter_my(
    .reg_0  (reg_0_always_out),
    .reg_3  (reg_3_always_out),
    .arbiter_order(code_in[2:0]),
    .arbiter_sel(function_sel_w[3]),

    .arbiter_out       (code_addr_out)

);



//寄存器挂载

register_pluse  register_pluser_0(
    .save_en            (reg_0_en),
    .load_en            (data_load_en_r[0]),
    .data_in            (bus_line)       ,

    .data_out           (bus_line_w) ,
    .data_out_always    (reg_0_always_out_w)
);

register_pluse  register_pluser_1(
    .save_en            (data_save_en_r[1]),
    .load_en            (data_load_en_r[1]),
    .data_in            (bus_line)       ,

    .data_out           (bus_line_w) ,
    .data_out_always    (reg_1_always_out_w)
);

register_pluse  register_pluser_2(
    .save_en            (data_save_en_r[2]),
    .load_en            (data_load_en_r[2]),
    .data_in            (bus_line)       ,
    .data_out           (bus_line_w) ,
    .data_out_always    (reg_2_always_out_w)
);

register_pluse  register_pluser_3(
    .save_en            (reg_3_en),
    .load_en            (data_load_en_r[3]),
    .data_in            (bus_line)       ,
    .data_out           (bus_line_w) ,
    .data_out_always    (reg_3_always_out_w)
);

register_pluse  register_pluser_4(
    .save_en            (data_save_en_r[4]),
    .load_en            (data_load_en_r[4]),
    .data_in            (bus_line)       ,
    .data_out           (bus_line_w) ,
    .data_out_always    ()
);

register_pluse  register_pluser_5(
    .save_en            (data_save_en_r[5]),
    .load_en            (data_load_en_r[5]),
    .data_in            (bus_line)       ,
    .data_out           (bus_line_w) ,
    .data_out_always    ()
);

register_pluse  register_pluser_6(
    .save_en            (data_save_en_r[6]),
    .load_en            (data_load_en_r[6]),
    .data_in            (bus_line)       ,
    .data_out           (bus_line_w) ,
    .data_out_always    ()
);


//输入口
register_pluse  register_pluser_in(
    .save_en            (en),
    .load_en            (data_load_en_r[7]),
    .data_in            (data_in)       ,
    .data_out           (bus_line_w) ,
    .data_out_always    ()
);

//输出口
register_pluse  register_pluser_out(
    .save_en            (data_save_en_r[7]),
    .load_en            (en),
    .data_in            (bus_line)       ,

    .data_out           (data_out) ,
    .data_out_always    ()
);







endmodule




