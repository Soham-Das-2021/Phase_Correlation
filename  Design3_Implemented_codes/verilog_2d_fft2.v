 
  
`timescale 1ns / 1ps

module test_design2_128x128(clk,reset,temp2_r,temp2_i );
output reg [15:0] temp2_r ;
output reg [15:0] temp2_i ;
 
input clk,reset;

//Instantiating FFT IP for 1D-FFT
reg [15:0] s_axis_config_tdata=16'h1;
 
(* dont_touch = "yes" *) reg [15:0] FFT_real[0:16383];
(* dont_touch = "yes" *) reg [15:0] FFT_img[0:16383];
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
(* dont_touch = "yes" *) wire  [15:0] out_im2;
(* dont_touch = "yes" *) wire [15:0] out_re2;
(* dont_touch = "yes" *) wire [15:0] in_im2;
(* dont_touch = "yes" *) wire [15:0] in_re2;
	
(* dont_touch = "yes" *) integer i=0 , j=0, a=0, b=0;
  
(* dont_touch = "yes" *) reg [60:0] count=0;     //used to dtermine as to when to capture data and enable the IPs
(* dont_touch = "yes" *) reg flag=0;
/*initial 
begin
     j = 0; i=0; a=0; b=0;
     add = 0;
     count =0;
end*/

//assign out and in data to registers 
assign out_im2 = m_axis_data_tdata[31:16];  //imagenory 1d_fft output
assign out_re2 = m_axis_data_tdata[15:0];   // real 1d_fft output
assign in_im2 = s_axis_data_tdata[31:16];   //imagenory 1d_fft input
assign in_re2 = s_axis_data_tdata[15:0];   // real 1d_fft input


reg [13:0] addra1=0;
wire [15:0] douta1;

//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata[31:16]=0;   //imagenory input
assign s_axis_data_tdata[15:0]=douta1;  //real input ... read from block rom

wire event_status_channel_halt;
wire event_data_out_channel_halt;

 
xfft_2 fft_2 (
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

always@(posedge clk)
begin
    if (count==20)
    begin
    s_axis_config_tvalid=1;
    //addra1=0;
    s_axis_config_tvalid=0;
    s_axis_data_tvalid=1;
    end
end    

//instantiate blockrom
 blk_mem_gen_1 rom1 (
  .clka(clk),    // input wire clka
  .addra(addra1),  // input wire [13 : 0] addra
  .douta(douta1)  // output wire [31 : 0] douta
);

//reading data from block rom at each clk cycle
always@(posedge clk && (addra1 <= 16383)  )
    begin
       if (count>=10)
          addra1 = addra1+1;
    end
    
always@(posedge clk)
begin
  if(reset)
    count = count+10;    
end

always@(posedge clk)
begin
      if((count>=3470) && (a<=16383))
       
           begin
              FFT_real[a]=out_re2;
              FFT_img[a]=out_im2;
              a=a+1;
           end
     
end       
        
               
               
//Instantiating FFT IP for 2D-FFT

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
(* dont_touch = "yes" *) wire  [15:0] out_im_2;
(* dont_touch = "yes" *) wire [15:0] out_re_2;
(* dont_touch = "yes" *) wire [15:0] in_im_2;
(* dont_touch = "yes" *) wire [15:0] in_re_2;
	
always@(posedge clk)
begin
temp2_r <= out_re_2;   
temp2_i <= out_im_2;
end

assign out_im_2 = m_axis_data_tdata_1[31:16];  //imagenory 2d_fft output
assign out_re_2 = m_axis_data_tdata_1[15:0];  // real 2d_fft  output
assign in_im_2 = s_axis_data_tdata_1[31:16];  // imagenory 2d_fft input
assign in_re_2 = s_axis_data_tdata_1[15:0];   // real 2d_fft input


always@(posedge clk && (count  == 167400 ))
    begin
        flag=1;
    end


always@(posedge clk && (count  == 167410 ))
    begin
        s_axis_config_tvalid_1=1;
        s_axis_config_tvalid_1=0;
        s_axis_data_tvalid_1=1;
    end

// taking transpose of 1D-FFT--> to give input to 2D-FFT 
always@(posedge clk &&(count >= 167400 ))
begin
   if(flag)
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
end

 
xfft_3 fft_3 (
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
