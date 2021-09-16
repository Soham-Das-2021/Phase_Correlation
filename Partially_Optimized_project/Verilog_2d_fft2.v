
  
`timescale 1ns / 1ps

module test_design2_128x128(clk  , temp2_r , temp2_i );
output reg [15:0] temp2_r ;
output reg [15:0] temp2_i ;
 
input clk;



integer i , j, a, a1, a2, a3, b;
integer add ;
reg [60:0] count;

reg [11:0] addra1=0;
wire [15:0] douta5,douta6,douta7,douta8;

initial 
begin
     j = 0; i=0; a=0; a1=4096; a2=8192; a3=12288; b=0;
     add = 0;
     count =0;
end

reg [15:0] s_axis_config_tdata_5=16'h1;

reg [15:0] FFT_real[0:16383];
reg [15:0] FFT_img[0:16383];
reg s_axis_config_tvalid_5=0;
wire s_axis_config_tready_5;
wire [31:0] s_axis_data_tdata_5;
reg s_axis_data_tvalid_5=0;
wire s_axis_data_tready_5;
reg s_axis_data_tlast_5=0;
wire [31:0] m_axis_data_tdata_5;
wire m_axis_data_tvalid_5;
wire m_axis_data_tlast_5;
wire event_frame_started_5;
wire event_tlast_unexpected_5;
wire event_tlast_missing_5;
wire event_data_in_channel_halt_5;
wire  [15:0] out_im_5;
wire [15:0] out_re_5;
wire [15:0] in_im_5;
wire [15:0] in_re_5;
	


//assign out and in data to registers 
assign out_im_5 = m_axis_data_tdata_5[31:16];  //imagenory 1d_fft output
assign out_re_5 = m_axis_data_tdata_5[15:0];   // real 1d_fft output
assign in_im_5 = s_axis_data_tdata_5[31:16];   //imagenory 1d_fft input
assign in_re_5 = s_axis_data_tdata_5[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_5[31:16]=0;   //imagenory input
assign s_axis_data_tdata_5[15:0]=douta5;  //real input ... read from block rom

wire event_status_channel_halt_5;
wire event_data_out_channel_halt_5;

// instantiate fft1
xfft_2 fft_5 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_5),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_5),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_5),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_5),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_5),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_5),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_5),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_5),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_5),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_5),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_5),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_5),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_5),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_5),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_5),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_5)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_5=1;
addra1=0;
s_axis_config_tvalid_5=0;
s_axis_data_tvalid_5=1;
end


reg [15:0] s_axis_config_tdata_6=16'h1;
reg s_axis_config_tvalid_6=0;
wire s_axis_config_tready_6;
wire [31:0] s_axis_data_tdata_6;
reg s_axis_data_tvalid_6=0;
wire s_axis_data_tready_6;
reg s_axis_data_tlast_6=0;
wire [31:0] m_axis_data_tdata_6;
wire m_axis_data_tvalid_6;
wire m_axis_data_tlast_6;
wire event_frame_started_6;
wire event_tlast_unexpected_6;
wire event_tlast_missing_6;
wire event_data_in_channel_halt_6;
wire  [15:0] out_im_6;
wire [15:0] out_re_6;
wire [15:0] in_im_6;
wire [15:0] in_re_6;
	


//assign out and in data to registers 
assign out_im_6 = m_axis_data_tdata_6[31:16];  //imagenory 1d_fft output
assign out_re_6 = m_axis_data_tdata_6[15:0];   // real 1d_fft output
assign in_im_6 = s_axis_data_tdata_6[31:16];   //imagenory 1d_fft input
assign in_re_6 = s_axis_data_tdata_6[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_6[31:16]=0;   //imagenory input
assign s_axis_data_tdata_6[15:0]=douta6;  //real input ... read from block rom

wire event_status_channel_halt_6;
wire event_data_out_channel_halt_6;

// instantiate fft1
xfft_2 fft_6 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_6),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_6),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_6),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_6),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_6),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_6),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_6),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_6),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_6),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_6),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_6),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_6),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_6),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_6),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_6),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_6)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_6=1;
//addra1=0;
s_axis_config_tvalid_6=0;
s_axis_data_tvalid_6=1;
end
                            

reg [15:0] s_axis_config_tdata_7=16'h1;
reg s_axis_config_tvalid_7=0;
wire s_axis_config_tready_7;
wire [31:0] s_axis_data_tdata_7;
reg s_axis_data_tvalid_7=0;
wire s_axis_data_tready_7;
reg s_axis_data_tlast_7=0;
wire [31:0] m_axis_data_tdata_7;
wire m_axis_data_tvalid_7;
wire m_axis_data_tlast_7;
wire event_frame_started_7;
wire event_tlast_unexpected_7;
wire event_tlast_missing_7;
wire event_data_in_channel_halt_7;
wire  [15:0] out_im_7;
wire [15:0] out_re_7;
wire [15:0] in_im_7;
wire [15:0] in_re_7;
	


//assign out and in data to registers 
assign out_im_7 = m_axis_data_tdata_7[31:16];  //imagenory 1d_fft output
assign out_re_7 = m_axis_data_tdata_7[15:0];   // real 1d_fft output
assign in_im_7 = s_axis_data_tdata_7[31:16];   //imagenory 1d_fft input
assign in_re_7 = s_axis_data_tdata_7[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_7[31:16]=0;   //imagenory input
assign s_axis_data_tdata_7[15:0]=douta7;  //real input ... read from block rom

wire event_status_channel_halt_7;
wire event_data_out_channel_halt_7;

// instantiate fft10
xfft_2 fft_7 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_7),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_7),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_7),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_7),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_7),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_7),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_7),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_7),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_7),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_7),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_7),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_7),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_7),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_7),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_7),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_7)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_7=1;
//addra1=0;
s_axis_config_tvalid_7=0;
s_axis_data_tvalid_7=1;
end


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
	


//assign out and in data to registers 
assign out_im_8 = m_axis_data_tdata_8[31:16];  //imagenory 1d_fft output
assign out_re_8 = m_axis_data_tdata_8[15:0];   // real 1d_fft output
assign in_im_8 = s_axis_data_tdata_8[31:16];   //imagenory 1d_fft input
assign in_re_8 = s_axis_data_tdata_8[15:0];   // real 1d_fft input


//data is read from block rom and given as input to 1d_fft
assign s_axis_data_tdata_8[31:16]=0;   //imagenory input
assign s_axis_data_tdata_8[15:0]=douta8;  //real input ... read from block rom

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
  .event_data_in_channel_halt(event_data_in_channel_halt_8),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_8)  // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid_8=1;
//addra1=0;
s_axis_config_tvalid_8=0;
s_axis_data_tvalid_8=1;
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

always@(posedge clk)
begin
      if((count>=3470) && (a<4096) && (a1<8192) && (a2<12288) && (a3<16384))
       
           begin
              FFT_real[a]=out_re_5;
              FFT_img[a]=out_im_5;
              FFT_real[a1]=out_re_6;
              FFT_img[a1]=out_im_6;
              FFT_real[a2]=out_re_7;
              FFT_img[a2]=out_im_7;
              FFT_real[a3]=out_re_8;
              FFT_img[a3]=out_im_8;
              a=a+1; a1=a1+1; a2=a2+1; a3=a3+1;
           end
     
end       
        
               
               
                
     

 
 

reg [15:0] s_axis_config_tdata_9=16'h1;
reg s_axis_config_tvalid_9=0;
wire s_axis_config_tready_9;
reg [31:0] s_axis_data_tdata_9;
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
wire event_status_channel_halt_9;
wire event_data_out_channel_halt_9;
wire  [15:0] out_im_9;
wire [15:0] out_re_9;
wire [15:0] in_im_9;
wire [15:0] in_re_9;
	
always@(posedge clk)
begin
temp2_r <= out_re_9;   
temp2_i <= out_im_9;
end

assign out_im_9 = m_axis_data_tdata_9[31:16];  //imagenory 2d_fft output
assign out_re_9 = m_axis_data_tdata_9[15:0];  // real 2d_fft  output
assign in_im_9 = s_axis_data_tdata_9[31:16];  // imagenory 2d_fft input
assign in_re_9 = s_axis_data_tdata_9[15:0];   // real 2d_fft input





always@(posedge clk && (count  == 44500 ))
    begin
        s_axis_config_tvalid_9=1;
        s_axis_config_tvalid_9=0;
        s_axis_data_tvalid_9 =1;
        //m = 0;
    end

// input to fft2--> output of 1d_fft stored in memory as column wise
always@(posedge clk &&(count  >= 44500 ))
begin
        if(j<=128)
         begin
            if(i<16384)
              begin
                 s_axis_data_tdata_9[15:0] = FFT_real[i];
                 s_axis_data_tdata_9[31:16] = FFT_img[i];
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
xfft_3 fft_9 (
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

endmodule 



 
