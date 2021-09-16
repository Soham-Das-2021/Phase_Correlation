
  
`timescale 1ns / 1ps

module test_design_128x128(clk,temp1_r,temp1_i);
output reg [15:0] temp1_r ;
output reg [15:0] temp1_i ;
 
input clk;


integer i , j, a, a1, a2, a3, b;
integer add ;
reg [60:0] count;

reg [11:0] addra1=0;
wire [15:0] douta1, douta2, douta3, douta4;

initial 
begin
     
     j = 0; i=0; a=0; a1=4096; a2=8192; a3=12288; b=0;
     add = 0;
     count =0;
end


reg [15:0] s_axis_config_tdata=16'h1;

reg [15:0] FFT_real[0:16383];
reg [15:0] FFT_img[0:16383];
reg s_axis_config_tvalid=0;
wire s_axis_config_tready;
wire [31:0] s_axis_data_tdata;
reg s_axis_data_tvalid=0;
wire s_axis_data_tready;
reg s_axis_data_tlast=0;
wire [31:0] m_axis_data_tdata;
wire m_axis_data_tvalid;
wire m_axis_data_tlast;
wire event_frame_started;
wire event_tlast_unexpected;
wire event_tlast_missing;
wire event_data_in_channel_halt;
wire  [15:0] out_im;
wire [15:0] out_re;
wire [15:0] in_im;
wire [15:0] in_re;

//assign out and in data to wires
assign out_im = m_axis_data_tdata[31:16];  //imagenory 1d_fft output
assign out_re = m_axis_data_tdata[15:0];   // real 1d_fft output
assign in_im = s_axis_data_tdata[31:16];   //imagenory 1d_fft input
assign in_re = s_axis_data_tdata[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata[31:16]=0;   //imagenory input
assign s_axis_data_tdata[15:0]=douta1;  //real input ... read from block rom

wire event_status_channel_halt;
wire event_data_out_channel_halt;

// instantiate fft1
xfft_0 fft_0 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt),    // outpu0t wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid=1;
addra1=0;
s_axis_config_tvalid=0;
s_axis_data_tvalid=1;
end



reg [15:0] s_axis_config_tdata_1=16'h1;
reg s_axis_config_tvalid_1=0;
wire s_axis_config_tready_1;
wire [31:0] s_axis_data_tdata_1;
reg s_axis_data_tvalid_1=0;
wire s_axis_data_tready_1;
reg s_axis_data_tlast_1=0;
wire [31:0] m_axis_data_tdata_1;
wire m_axis_data_tvalid_1;
wire m_axis_data_tlast_1;
wire event_frame_started_1;
wire event_tlast_unexpected_1;
wire event_tlast_missing_1;
wire event_data_in_channel_halt_1;
wire  [15:0] out_im_1;
wire [15:0] out_re_1;
wire [15:0] in_im_1;
wire [15:0] in_re_1;

//assign out and in data to wires
assign out_im_1 = m_axis_data_tdata_1[31:16];  //imagenory 1d_fft output
assign out_re_1 = m_axis_data_tdata_1[15:0];   // real 1d_fft output
assign in_im_1 = s_axis_data_tdata_1[31:16];   //imagenory 1d_fft input
assign in_re_1 = s_axis_data_tdata_1[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_1[31:16]=0;   //imagenory input
assign s_axis_data_tdata_1[15:0]=douta2;  //real input ... read from block rom

wire event_status_channel_halt_1;
wire event_data_out_channel_halt_1;

// instantiate fft1
xfft_0 fft_1 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_1),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_1),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_1),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_1),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_1),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_1),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_1),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_1),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_1),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_1),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_1),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_1),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_1),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_1),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_1),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_1)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_1=1;
//addra1=0;0
s_axis_config_tvalid_1=0;
s_axis_data_tvalid_1=1;
end


reg [15:0] s_axis_config_tdata_2=16'h1;
reg s_axis_config_tvalid_2=0;
wire s_axis_config_tready_2;
wire [31:0] s_axis_data_tdata_2;
reg s_axis_data_tvalid_2=0;
wire s_axis_data_tready_2;
reg s_axis_data_tlast_2=0;
wire [31:0] m_axis_data_tdata_2;
wire m_axis_data_tvalid_2;
wire m_axis_data_tlast_2;
wire event_frame_started_2;
wire event_tlast_unexpected_2;
wire event_tlast_missing_2;
wire event_data_in_channel_halt_2;
wire  [15:0] out_im_2;
wire [15:0] out_re_2;
wire [15:0] in_im_2;
wire [15:0] in_re_2;

//assign out and in data to wires
assign out_im_2 = m_axis_data_tdata_2[31:16];  //imagenory 1d_fft output
assign out_re_2 = m_axis_data_tdata_2[15:0];   // real 1d_fft output
assign in_im_2 = s_axis_data_tdata_2[31:16];   //imagenory 1d_fft input
assign in_re_2 = s_axis_data_tdata_2[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_2[31:16]=0;   //imagenory input
assign s_axis_data_tdata_2[15:0]=douta3;  //real input ... read from block rom

wire event_status_channel_halt_2;
wire event_data_out_channel_halt_2;

// instantiate fft1
xfft_0 fft_2 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_2),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_2),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_2),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_2),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_2),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_2),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_2),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_2),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_2),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_2),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_2),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_2),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_2),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_2),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_2),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_2)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_2=1;
//addra1=0;
s_axis_config_tvalid_2=0;
s_axis_data_tvalid_2=1;
end


reg [15:0] s_axis_config_tdata_3=16'h1;
reg s_axis_config_tvalid_3=0;
wire s_axis_config_tready_3;
wire [31:0] s_axis_data_tdata_3;
reg s_axis_data_tvalid_3=0;
wire s_axis_data_tready_3;
reg s_axis_data_tlast_3=0;
wire [31:0] m_axis_data_tdata_3;
wire m_axis_data_tvalid_3;
wire m_axis_data_tlast_3;
wire event_frame_started_3;
wire event_tlast_unexpected_3;
wire event_tlast_missing_3;
wire event_data_in_channel_halt_3;
wire  [15:0] out_im_3;
wire [15:0] out_re_3;
wire [15:0] in_im_3;
wire [15:0] in_re_3;

//assign out and in data to wires
assign out_im_3 = m_axis_data_tdata_3[31:16];  //imagenory 1d_fft output
assign out_re_3 = m_axis_data_tdata_3[15:0];   // real 1d_fft output
assign in_im_3 = s_axis_data_tdata_3[31:16];   //imagenory 1d_fft input
assign in_re_3 = s_axis_data_tdata_3[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_3[31:16]=0;   //imagenory input
assign s_axis_data_tdata_3[15:0]=douta4;  //real input ... read from block rom

wire event_status_channel_halt_3;
wire event_data_out_channel_halt_3;

// instantiate fft1
xfft_0 fft_3 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_3),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_3),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_3),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_3),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_3),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_3),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_3),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_3),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_3),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_3),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_3),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_3),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_3),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_3),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_3),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_3)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_3=1;
//addra1=0;
s_axis_config_tvalid_3=0;
s_axis_data_tvalid_3=1;
end

//instantiate blockrom
blk_mem_gen_0 rom (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta1)  // output wire [31 : 0] douta
);

blk_mem_gen_1 rom1 (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta2)  // output wire [31 : 0] douta
);

blk_mem_gen_2 rom2 (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta3)  // output wire [31 : 0] douta
);

blk_mem_gen_3 rom3 (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta4)  // output wire [31 : 0] douta
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
     if((count>=3470) && (a<4096) && (a1<8192) && (a2<12288) && (a3<16384))
       
           begin
              FFT_real[a]=out_re;
              FFT_img[a]=out_im;
              FFT_real[a1]=out_re_1;
              FFT_img[a1]=out_im_1;
              FFT_real[a2]=out_re_2;
              FFT_img[a2]=out_im_2;
              FFT_real[a3]=out_re_3;
              FFT_img[a3]=out_im_3;
              a=a+1; a1=a1+1; a2=a2+1; a3=a3+1;
           end
          
end       
        
               
               
                
     
 
 

reg [15:0] s_axis_config_tdata_4=16'h1;
reg s_axis_config_tvalid_4=0;
wire s_axis_config_tready_4;
reg [31:0] s_axis_data_tdata_4;
reg s_axis_data_tvalid_4=0;
wire s_axis_data_tready_4;
reg s_axis_data_tlast_4=0;
wire [31:0] m_axis_data_tdata_4;
wire m_axis_data_tvalid_4;
wire m_axis_data_tlast_4;
wire event_frame_started_4;
wire event_tlast_unexpected_4;
wire event_tlast_missing_4;
wire event_data_in_channel_halt_4;
wire event_status_channel_halt_4;
wire event_data_out_channel_halt_4;
wire  [15:0] out_im_4;
wire [15:0] out_re_4;
wire [15:0] in_im_4;
wire [15:0] in_re_4;
	
always@(posedge clk)
begin
temp1_r <= out_re_4;   
temp1_i <= out_im_4;
end

assign out_im_4 = m_axis_data_tdata_4[31:16];  //imagenory 2d_fft output
assign out_re_4 = m_axis_data_tdata_4[15:0];  // real 2d_fft  output
assign in_im_4 = s_axis_data_tdata_4[31:16];  // imagenory 2d_fft input
assign in_re_4 = s_axis_data_tdata_4[15:0];   // real 2d_fft input





always@(posedge clk && (count  == 44500 ))
    begin
        s_axis_config_tvalid_4=1;
        s_axis_config_tvalid_4=0;
        s_axis_data_tvalid_4 =1;
        //m = 0;
    end

// input to fft2--> output of 1d_fft stored in memory as column wise
always@(posedge clk &&(count  >= 44500 ))
begin
     if(j<=128)
         begin
            if(i<16384)
              begin
                 s_axis_data_tdata_4[15:0] = FFT_real[i];
                 s_axis_data_tdata_4[31:16] = FFT_img[i];
                 i=i+128;
              end
              if(i==(16384+j))
                begin
                  j=j+1;
                  i=j;
                end
         end
     
end

// instantiate fft2
xfft_1 fft_4 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_4),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_4),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_4),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_4),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_4),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_4),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_4),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_4),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_4),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_4),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_4),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_4),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_4),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_4),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_4),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_4)  // output wire event_data_out_channel_halt
);


endmodule 


 