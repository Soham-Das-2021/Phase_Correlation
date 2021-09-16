 
  
`timescale 1ns / 1ps

module test_design_128x128(clk,temp1_r,temp1_i);
output reg [15:0] temp1_r ;
output reg [15:0] temp1_i ;
 
input clk;
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
	
 integer i , j, a, b;
 integer add ;
reg [60:0] count;

initial 
begin
     
     j = 0; i=0; a=0; b=0;
     add = 0;
     count =0;
end

//assign out and in data to wires
assign out_im = m_axis_data_tdata[31:16];  //imagenory 1d_fft output
assign out_re = m_axis_data_tdata[15:0];   // real 1d_fft output
assign in_im = s_axis_data_tdata[31:16];   //imagenory 1d_fft input
assign in_re = s_axis_data_tdata[15:0];   // real 1d_fft input


reg [13:0] addra1=0;
wire [15:0] douta1;

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
  .event_data_in_channel_halt(event_data_in_channel_halt),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid=1;
addra1=0;
s_axis_config_tvalid=0;
s_axis_data_tvalid=1;
end

//instantiate blockrom
blk_mem_gen_0 rom (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta1)  // output wire [31 : 0] douta
);

//reading data from block rom at each clk cycle
always@(posedge clk && (addra1 <= 16382)  )
    begin
    addra1 = addra1+1;
    end

always@(posedge clk)
count = count+10;

// storing 1d output to memory
always@(posedge clk )
begin
     if((count>=3470) && (a<=16384))
       
           begin
              FFT_real[a]=out_re;
              FFT_img[a]=out_im;
              a=a+1;
           end
          
end       
        
               
               
                
     
 
 

reg [15:0] s_axis_config_tdata_1=16'h1;
reg s_axis_config_tvalid_1=0;
wire s_axis_config_tready_1;
reg [31:0] s_axis_data_tdata_1;
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
wire event_status_channel_halt_1;
wire event_data_out_channel_halt_1;
wire  [15:0] out_im_1;
wire [15:0] out_re_1;
wire [15:0] in_im_1;
wire [15:0] in_re_1;
	
always@(posedge clk)
begin
temp1_r <= out_re_1;   
temp1_i <= out_im_1;
end

assign out_im_1 = m_axis_data_tdata_1[31:16];  //imagenory 2d_fft output
assign out_re_1 = m_axis_data_tdata_1[15:0];  // real 2d_fft  output
assign in_im_1 = s_axis_data_tdata_1[31:16];  // imagenory 2d_fft input
assign in_re_1 = s_axis_data_tdata_1[15:0];   // real 2d_fft input





always@(posedge clk && (count  == 167400 ))
    begin
        s_axis_config_tvalid_1=1;
        s_axis_config_tvalid_1=0;
        s_axis_data_tvalid_1 =1;
        //m = 0;
    end

// input to fft2--> output of 1d_fft stored in memory as column wise
always@(posedge clk &&(count  >= 167400 ))
begin
     if(j<=128)
         begin
            if(i<16384)
              begin
                 s_axis_data_tdata_1[15:0] = FFT_real[i];
                 s_axis_data_tdata_1[31:16] = FFT_img[i];
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
xfft_1 fft_1 (
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


endmodule 


 
