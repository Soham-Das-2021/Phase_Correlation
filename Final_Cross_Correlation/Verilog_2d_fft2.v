 
  
`timescale 1ns / 1ps

module test_design2_128x128(clk,temp5_r,temp5_i,temp6_r,temp6_i,temp7_r,temp7_i,temp8_r,temp8_i);
output reg [15:0] temp5_r ;
output reg [15:0] temp5_i ;
output reg [15:0] temp6_r ;
output reg [15:0] temp6_i ;
output reg [15:0] temp7_r ;
output reg [15:0] temp7_i ;
output reg [15:0] temp8_r ;
output reg [15:0] temp8_i ;
 
input clk;


integer i,i1,i2,i3, i4,i5,i6,i7, i8,i9,i10,i11, i12,i13,i14,i15, j, a, b;
integer add ;
reg [60:0] count;

reg [11:0] addra1=0;
wire [15:0] douta5, douta6, douta7, douta8;

initial 
begin
     
     j = 0; 
     i=0; i4=0; i8=0; i12=0;
     i1=32; i5=32; i9=32; i13=32;
     i2=64; i6=64; i10=64; i14=64;
     i3=96; i7=96; i11=96; i15=96;
     a=0; b=0;
     add = 0;
     count =0;
end




reg [15:0] FFT_real[0:4095];
reg [15:0] FFT_img[0:4095];
reg [15:0] FFT_real1[0:4095];
reg [15:0] FFT_img1[0:4095];
reg [15:0] FFT_real2[0:4095];
reg [15:0] FFT_img2[0:4095];
reg [15:0] FFT_real3[0:4095];
reg [15:0] FFT_img3[0:4095];



reg [15:0] s_axis_config_tdata_8=16'h1;
reg s_axis_config_tvalid_8=0;
wire s_axis_config_tready_8;
wire [31:0] s_axis_data_tdata_8;
reg s_axis_data_tvalid_8=0;
wire s_axis_data_tready_8;
reg s_axis_data_tlast_8=0;
wire [31:0] m_axis_data_tdata_8;
wire m_axis_data_tvalid_8;
wire m_axis_data_tlast_8;
wire event_frame_started_8;
wire event_tlast_unexpected_8;
wire event_tlast_missing_8;
wire event_data_in_channel_halt_8;
wire  [15:0] out_im_8;
wire [15:0] out_re_8;
wire [15:0] in_im_8;
wire [15:0] in_re_8;

//assign out and in data to wires
assign out_im_8 = m_axis_data_tdata_8[31:16];  //imagenory 1d_fft output
assign out_re_8 = m_axis_data_tdata_8[15:0];   // real 1d_fft output
assign in_im_8 = s_axis_data_tdata_8[31:16];   //imagenory 1d_fft input
assign in_re_8 = s_axis_data_tdata_8[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_8[31:16]=0;   //imagenory input
assign s_axis_data_tdata_8[15:0]=douta5;  //real input ... read from block rom

wire event_status_channel_halt_8;
wire event_data_out_channel_halt_8;

// instantiate fft1
xfft_2 fft_8 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_8),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_8),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_8),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_8),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_8),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_8),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_8),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_8),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_8),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_8),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_8),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_8),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_8),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_8),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_8),    // outpu0t wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_8)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_8=1;
addra1=0;
s_axis_config_tvalid_8=0;
s_axis_data_tvalid_8=1;
end



reg [15:0] s_axis_config_tdata_9=16'h1;
reg s_axis_config_tvalid_9=0;
wire s_axis_config_tready_9;
wire [31:0] s_axis_data_tdata_9;
reg s_axis_data_tvalid_9=0;
wire s_axis_data_tready_9;
reg s_axis_data_tlast_9=0;
wire [31:0] m_axis_data_tdata_9;
wire m_axis_data_tvalid_9;
wire m_axis_data_tlast_9;
wire event_frame_started_9;
wire event_tlast_unexpected_9;
wire event_tlast_missing_9;
wire event_data_in_channel_halt_9;
wire  [15:0] out_im_9;
wire [15:0] out_re_9;
wire [15:0] in_im_9;
wire [15:0] in_re_9;

//assign out and in data to wires
assign out_im_9 = m_axis_data_tdata_9[31:16];  //imagenory 1d_fft output
assign out_re_9 = m_axis_data_tdata_9[15:0];   // real 1d_fft output
assign in_im_9 = s_axis_data_tdata_9[31:16];   //imagenory 1d_fft input
assign in_re_9 = s_axis_data_tdata_9[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_9[31:16]=0;   //imagenory input
assign s_axis_data_tdata_9[15:0]=douta6;  //real input ... read from block rom

wire event_status_channel_halt_9;
wire event_data_out_channel_halt_9;

// instantiate fft1
xfft_2 fft_9 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_9),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_9),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_9),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_9),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_9),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_9),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_9),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_9),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_9),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_9),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_9),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_9),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_9),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_9),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_9),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_9)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_9=1;
//addra1=0;0
s_axis_config_tvalid_9=0;
s_axis_data_tvalid_9=1;
end


reg [15:0] s_axis_config_tdata_10=16'h1;
reg s_axis_config_tvalid_10=0;
wire s_axis_config_tready_10;
wire [31:0] s_axis_data_tdata_10;
reg s_axis_data_tvalid_10=0;
wire s_axis_data_tready_10;
reg s_axis_data_tlast_10=0;
wire [31:0] m_axis_data_tdata_10;
wire m_axis_data_tvalid_10;
wire m_axis_data_tlast_10;
wire event_frame_started_10;
wire event_tlast_unexpected_10;
wire event_tlast_missing_10;
wire event_data_in_channel_halt_10;
wire  [15:0] out_im_10;
wire [15:0] out_re_10;
wire [15:0] in_im_10;
wire [15:0] in_re_10;

//assign out and in data to wires
assign out_im_10 = m_axis_data_tdata_10[31:16];  //imagenory 1d_fft output
assign out_re_10 = m_axis_data_tdata_10[15:0];   // real 1d_fft output
assign in_im_10 = s_axis_data_tdata_10[31:16];   //imagenory 1d_fft input
assign in_re_10 = s_axis_data_tdata_10[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_10[31:16]=0;   //imagenory input
assign s_axis_data_tdata_10[15:0]=douta7;  //real input ... read from block rom

wire event_status_channel_halt_10;
wire event_data_out_channel_halt_10;

// instantiate fft1
xfft_2 fft_10 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_10),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_10),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_10),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_10),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_10),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_10),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_10),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_10),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_10),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_10),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_10),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_10),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_10),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_10),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_10),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_10)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_10=1;
//addra1=0;
s_axis_config_tvalid_10=0;
s_axis_data_tvalid_10=1;
end


reg [15:0] s_axis_config_tdata_11=16'h1;
reg s_axis_config_tvalid_11=0;
wire s_axis_config_tready_11;
wire [31:0] s_axis_data_tdata_11;
reg s_axis_data_tvalid_11=0;
wire s_axis_data_tready_11;
reg s_axis_data_tlast_11=0;
wire [31:0] m_axis_data_tdata_11;
wire m_axis_data_tvalid_11;
wire m_axis_data_tlast_11;
wire event_frame_started_11;
wire event_tlast_unexpected_11;
wire event_tlast_missing_11;
wire event_data_in_channel_halt_11;
wire  [15:0] out_im_11;
wire [15:0] out_re_11;
wire [15:0] in_im_11;
wire [15:0] in_re_11;

//assign out and in data to wires
assign out_im_11 = m_axis_data_tdata_11[31:16];  //imagenory 1d_fft output
assign out_re_11 = m_axis_data_tdata_11[15:0];   // real 1d_fft output
assign in_im_11 = s_axis_data_tdata_11[31:16];   //imagenory 1d_fft input
assign in_re_11 = s_axis_data_tdata_11[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_11[31:16]=0;   //imagenory input
assign s_axis_data_tdata_11[15:0]=douta8;  //real input ... read from block rom

wire event_status_channel_halt_11;
wire event_data_out_channel_halt_11;

// instantiate fft1
xfft_2 fft_11 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_11),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_11),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_11),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_11),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_11),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_11),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_11),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_11),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_11),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_11),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_11),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_11),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_11),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_11),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_11),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_11)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_11=1;
//addra1=0;
s_axis_config_tvalid_11=0;
s_axis_data_tvalid_11=1;
end

//instantiate blockrom
blk_mem_gen_4 rom4 (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta5)  // output wire [31 : 0] douta
);

blk_mem_gen_5 rom5 (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta6)  // output wire [31 : 0] douta
);

blk_mem_gen_6 rom6 (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta7)  // output wire [31 : 0] douta
);

blk_mem_gen_7 rom7 (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta8)  // output wire [31 : 0] douta
);

//reading data from block rom at each clk cycle
always@(posedge clk && (addra1 <= 4094)  )
    begin
    addra1 = addra1+1;
    end

always@(posedge clk)
count = count+10;

   
// storing 1d output to memory
always@(posedge clk )
begin
     if((count>=3470) && (a<4096))
       
           begin
              FFT_real[a]=out_re_8;
              FFT_img[a]=out_im_8;
              FFT_real1[a]=out_re_9;
              FFT_img1[a]=out_im_9;
              FFT_real2[a]=out_re_10;
              FFT_img2[a]=out_im_10;
              FFT_real3[a]=out_re_11;
              FFT_img3[a]=out_im_11;
              a=a+1; 
           end
          
end                
               
                

    
reg [15:0] s_axis_config_tdata_12=16'h1;
reg s_axis_config_tvalid_12=0;
wire s_axis_config_tready_12;
reg [31:0] s_axis_data_tdata_12;
reg s_axis_data_tvalid_12=0;
wire s_axis_data_tready_12;
reg s_axis_data_tlast_12=0;
wire [31:0] m_axis_data_tdata_12;
wire m_axis_data_tvalid_12;
wire m_axis_data_tlast_12;
wire event_frame_started_12;
wire event_tlast_unexpected_12;
wire event_tlast_missing_12;
wire event_data_in_channel_halt_12;
wire event_status_channel_halt_12;
wire event_data_out_channel_halt_12;
wire  [15:0] out_im_12;
wire [15:0] out_re_12;
wire [15:0] in_im_12;
wire [15:0] in_re_12;

 always@(posedge clk)
begin
temp5_r <= out_re_12;   
temp5_i <= out_im_12;
end
	

assign out_im_12 = m_axis_data_tdata_12[31:16];  //imagenory 2d_fft output
assign out_re_12 = m_axis_data_tdata_12[15:0];  // real 2d_fft  output
assign in_im_12 = s_axis_data_tdata_12[31:16];  // imagenory 2d_fft input
assign in_re_12 = s_axis_data_tdata_12[15:0];   // real 2d_fft input


always@(posedge clk && (count  == 44500 ))
    begin
        s_axis_config_tvalid_12=1;
        s_axis_config_tvalid_12=0;
        s_axis_data_tvalid_12 =1;
        //m = 0;
    end


// instantiate fft2
xfft_3 fft_12 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_12),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_12),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_12),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_12),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_12),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_12),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_12),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_12),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_12),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_12),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_12),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_12),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_12),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_12),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_12),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_12)  // output wire event_data_out_channel_halt
);


reg [15:0] s_axis_config_tdata_13=16'h1;
reg s_axis_config_tvalid_13=0;
wire s_axis_config_tready_13;
reg [31:0] s_axis_data_tdata_13;
reg s_axis_data_tvalid_13=0;
wire s_axis_data_tready_13;
reg s_axis_data_tlast_13=0;
wire [31:0] m_axis_data_tdata_13;
wire m_axis_data_tvalid_13;
wire m_axis_data_tlast_13;
wire event_frame_started_13;
wire event_tlast_unexpected_13;
wire event_tlast_missing_13;
wire event_data_in_channel_halt_13;
wire event_status_channel_halt_13;
wire event_data_out_channel_halt_13;
wire  [15:0] out_im_13;
wire [15:0] out_re_13;
wire [15:0] in_im_13;
wire [15:0] in_re_13;

always@(posedge clk)
begin
temp6_r <= out_re_13;   
temp6_i <= out_im_13;
end
	

assign out_im_13 = m_axis_data_tdata_13[31:16];  //imagenory 2d_fft output
assign out_re_13 = m_axis_data_tdata_13[15:0];  // real 2d_fft  output
assign in_im_13 = s_axis_data_tdata_13[31:16];  // imagenory 2d_fft input
assign in_re_13 = s_axis_data_tdata_13[15:0];   // real 2d_fft input


always@(posedge clk && (count  == 44500 ))
    begin
        s_axis_config_tvalid_13=1;
        s_axis_config_tvalid_13=0;
        s_axis_data_tvalid_13 =1;
        //m = 0;
    end


// instantiate fft2
xfft_3 fft_13 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_13),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_13),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_13),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_13),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_13),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_13),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_13),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_13),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_13),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_13),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_13),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_13),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_13),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_13),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_13),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_13)  // output wire event_data_out_channel_halt
);


reg [15:0] s_axis_config_tdata_14=16'h1;
reg s_axis_config_tvalid_14=0;
wire s_axis_config_tready_14;
reg [31:0] s_axis_data_tdata_14;
reg s_axis_data_tvalid_14=0;
wire s_axis_data_tready_14;
reg s_axis_data_tlast_14=0;
wire [31:0] m_axis_data_tdata_14;
wire m_axis_data_tvalid_14;
wire m_axis_data_tlast_14;
wire event_frame_started_14;
wire event_tlast_unexpected_14;
wire event_tlast_missing_14;
wire event_data_in_channel_halt_14;
wire event_status_channel_halt_14;
wire event_data_out_channel_halt_14;
wire  [15:0] out_im_14;
wire [15:0] out_re_14;
wire [15:0] in_im_14;
wire [15:0] in_re_14;

always@(posedge clk)
begin
temp7_r <= out_re_14;   
temp7_i <= out_im_14;
end
	

assign out_im_14 = m_axis_data_tdata_14[31:16];  //imagenory 2d_fft output
assign out_re_14 = m_axis_data_tdata_14[15:0];  // real 2d_fft  output
assign in_im_14 = s_axis_data_tdata_14[31:16];  // imagenory 2d_fft input
assign in_re_14 = s_axis_data_tdata_14[15:0];   // real 2d_fft input


always@(posedge clk && (count  == 44500 ))
    begin
        s_axis_config_tvalid_14=1;
        s_axis_config_tvalid_14=0;
        s_axis_data_tvalid_14 =1;
        //m = 0;
    end


// instantiate fft2
xfft_3 fft_14 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_14),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_14),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_14),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_14),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_14),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_14),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_14),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_14),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_14),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_14),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_14),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_14),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_14),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_14),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_14),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_14)  // output wire event_data_out_channel_halt
);


reg [15:0] s_axis_config_tdata_15=16'h1;
reg s_axis_config_tvalid_15=0;
wire s_axis_config_tready_15;
reg [31:0] s_axis_data_tdata_15;
reg s_axis_data_tvalid_15=0;
wire s_axis_data_tready_15;
reg s_axis_data_tlast_15=0;
wire [31:0] m_axis_data_tdata_15;
wire m_axis_data_tvalid_15;
wire m_axis_data_tlast_15;
wire event_frame_started_15;
wire event_tlast_unexpected_15;
wire event_tlast_missing_15;
wire event_data_in_channel_halt_15;
wire event_status_channel_halt_15;
wire event_data_out_channel_halt_15;
wire  [15:0] out_im_15;
wire [15:0] out_re_15;
wire [15:0] in_im_15;
wire [15:0] in_re_15;

always@(posedge clk)
begin
temp8_r <= out_re_15;   
temp8_i <= out_im_15;
end
	

assign out_im_15 = m_axis_data_tdata_15[31:16];  //imagenory 2d_fft output
assign out_re_15 = m_axis_data_tdata_15[15:0];  // real 2d_fft  output
assign in_im_15 = s_axis_data_tdata_15[31:16];  // imagenory 2d_fft input
assign in_re_15 = s_axis_data_tdata_15[15:0];   // real 2d_fft input


always@(posedge clk && (count  == 44500 ))
    begin
        s_axis_config_tvalid_15=1;
        s_axis_config_tvalid_15=0;
        s_axis_data_tvalid_15 =1;
        //m = 0;
    end


// instantiate fft2
xfft_3 fft_15 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_15),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_15),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_15),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_15),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_15),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_15),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_15),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_15),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_15),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_15),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_15),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_15),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_15),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_15),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_15),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_15)  // output wire event_data_out_channel_halt
);


// input to fft2--> output of 1d_fft stored in memory as column wise
always@(posedge clk &&(count  >= 44500 ))
begin
     if(j<=31)
         begin
            if((i<=4095) && (i1<=4095) && (i2<=4095) && (i3<=4095))
              begin
                 s_axis_data_tdata_12[15:0] <= FFT_real[i];
                 s_axis_data_tdata_12[31:16] <= FFT_img[i];
                 s_axis_data_tdata_13[15:0] <= FFT_real[i1];
                 s_axis_data_tdata_13[31:16] <= FFT_img[i1];
                 s_axis_data_tdata_14[15:0] <= FFT_real[i2];
                 s_axis_data_tdata_14[31:16] <= FFT_img[i2];
                 s_axis_data_tdata_15[15:0] <= FFT_real[i3];
                 s_axis_data_tdata_15[31:16] <= FFT_img[i3];
                 i<=i+128; i1<=i1+128; i2<=i2+128; i3<=i3+128;
              end
            if((i>=4096) && (i4<4096) && (i5<4096) && (i6<4096) && (i7<4096))
              begin
                 s_axis_data_tdata_12[15:0] <= FFT_real1[i4];
                 s_axis_data_tdata_12[31:16] <= FFT_img1[i4];
                 s_axis_data_tdata_13[15:0] <= FFT_real1[i5];
                 s_axis_data_tdata_13[31:16] <= FFT_img1[i5];
                 s_axis_data_tdata_14[15:0] <= FFT_real1[i6];
                 s_axis_data_tdata_14[31:16] <= FFT_img1[i6];
                 s_axis_data_tdata_15[15:0] <= FFT_real1[i7];
                 s_axis_data_tdata_15[31:16] <= FFT_img1[i7];
                 i4<=i4+128; i5<=i5+128; i6<=i6+128; i7<=i7+128;
              end  
            if((i4>=4096) && (i8<4096) && (i9<4096) && (i10<4096) && (i11<4096))
              begin
                 s_axis_data_tdata_12[15:0] <= FFT_real2[i8];
                 s_axis_data_tdata_12[31:16] <= FFT_img2[i8];
                 s_axis_data_tdata_13[15:0] <= FFT_real2[i9];
                 s_axis_data_tdata_13[31:16] <= FFT_img2[i9];
                 s_axis_data_tdata_14[15:0] <= FFT_real2[i10];
                 s_axis_data_tdata_14[31:16] <= FFT_img2[i10];
                 s_axis_data_tdata_15[15:0] <= FFT_real2[i11];
                 s_axis_data_tdata_15[31:16] <= FFT_img2[i11];
                 i8<=i8+128; i9<=i9+128; i10<=i10+128; i11<=i11+128;
              end  
            if((i8>=4096) && (i12<4096) && (i13<4096) && (i14<4096) && (i15<4096))
              begin
                 s_axis_data_tdata_12[15:0] <= FFT_real3[i12];
                 s_axis_data_tdata_12[31:16] <= FFT_img3[i12];
                 s_axis_data_tdata_13[15:0] <= FFT_real3[i13];
                 s_axis_data_tdata_13[31:16] <= FFT_img3[i13];
                 s_axis_data_tdata_14[15:0] <= FFT_real3[i14];
                 s_axis_data_tdata_14[31:16] <= FFT_img3[i14];
                 s_axis_data_tdata_15[15:0] <= FFT_real3[i15];
                 s_axis_data_tdata_15[31:16] <= FFT_img3[i15];
                 i12<=i12+128; i13<=i13+128; i14<=i14+128; i15<=i15+128;
              end  
              if(i12==(4096+j))
                begin
                  j=j+1; 
                  i=j; i4=j; i8=j; i12=j;
                  i1=32+j; i5=32+j; i9=32+j; i13=32+j;
                  i2=64+j; i6=32+j; i10=32+j; i14=32+j;
                  i3=96+j; i7=32+j; i11=32+j; i15=32+j;
                end
         end
     
end




endmodule 


 