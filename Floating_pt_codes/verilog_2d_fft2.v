//2D_FFT of the Shifted Image--- 128 X 128 matrix
  
`timescale 1ns / 1ps

module test_design2_128x128(clk  , temp2_r , temp2_i );
output reg [31:0] temp2_r ;                  //Real part of the 2D_FFT
output reg [31:0] temp2_i ;                  //Imaginary part of the 2D_FFT 
 
input clk;                                   //Clock signal
reg [15:0] s_axis_config_tdata=16'h1;        //Config signal for FFT IP is kept '1' for a FFT operation & '0' for IFFT operation
 
reg [31:0] FFT_real[0:16383];                //To store real part of the 1D_FFT
reg [31:0] FFT_img[0:16383];                 //To store imaginary part of the 1D_FFT 
reg s_axis_config_tvalid=0;
wire s_axis_config_tready;
wire [63:0] s_axis_data_tdata;
reg s_axis_data_tvalid=0;
wire s_axis_data_tready;
reg s_axis_data_tlast=0;
wire [63:0] m_axis_data_tdata;
wire m_axis_data_tvalid;
wire m_axis_data_tlast;
wire event_frame_started;
wire event_tlast_unexpected;
wire event_tlast_missing;
wire event_data_in_channel_halt;
wire  [31:0] out_im2;                       //Wire with the 1D_FFT imaginary part of the output
wire [31:0] out_re2;                        //Wire with the 1D_FFT real part of the output
wire [31:0] in_im2;                         //Wire with the imaginary part of the input to the 1st FFT IP
wire [31:0] in_re2;                         //Wire with the real part of the input to the 1st FFT IP
	 
 integer i , j, a, b;
 integer add ;
reg [60:0] count;                           //Counter to keep track as to when the FFT IPs start to give outputs--- needed to start storing data from the right time

initial 
begin
     j = 0; i=0; a=0; b=0;
     add = 0;
     count =0;
end

//assign out and in data to registers 
assign out_im2 = m_axis_data_tdata[63:32];         //assign imaginary part of 1d_fft output to wire
assign out_re2 = m_axis_data_tdata[31:0];          //assign real part of 1d_fft output to wire
assign in_im2 = s_axis_data_tdata[63:32];          //assign imaginary part of 1d_fft input to wire
assign in_re2 = s_axis_data_tdata[31:0];           //assign real part of 1d_fft input to wire


reg [13:0] addra1=0;
wire [31:0] douta1;

//128 X 128 Shifted Image's data is read from block rom and given as input to FFT IP
assign s_axis_data_tdata[63:32]=0;   //imaginary part of input=0 as all input Image data are purely real
assign s_axis_data_tdata[31:0]=douta1;  //real part of input ... read from block rom

wire event_status_channel_halt;
wire event_data_out_channel_halt;

// instantiate FFT IP for 1D_FFT--- along x- direction
xfft_2 fft_2 (
  .aclk(clk),                                                 // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                                     // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt)   // output wire event_data_out_channel_halt
);

initial begin
s_axis_config_tvalid=1;
addra1=0;
s_axis_config_tvalid=0;
s_axis_data_tvalid=1;
end

//instantiate blockrom
 blk_mem_gen_1 rom1 (
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

// storing 1d output to regsiters
always@(posedge clk)
begin
      if((count>=5010) && (a<=16384))        //1st FFT IP starts giving output from count=5010
       
           begin
              FFT_real[a]=out_re2;
              FFT_img[a]=out_im2;
              a=a+1;
           end
     
end       
        
               
               
                
     

 
 

reg [15:0] s_axis_config_tdata_1=16'h1;
reg s_axis_config_tvalid_1=0;
wire s_axis_config_tready_1;
reg [63:0] s_axis_data_tdata_1;
reg s_axis_data_tvalid_1=0;
wire s_axis_data_tready_1;
reg s_axis_data_tlast_1=0;
wire [63:0] m_axis_data_tdata_1;
wire m_axis_data_tvalid_1;
wire m_axis_data_tlast_1;
wire event_frame_started_1;
wire event_tlast_unexpected_1;
wire event_tlast_missing_1;
wire event_data_in_channel_halt_1;
wire event_status_channel_halt_1;
wire event_data_out_channel_halt_1;
wire  [31:0] out_im_2;                    //Wire with the 2D_FFT imaginary part of the output
wire [31:0] out_re_2;                     //Wire with the 2D_FFT real part of the output
wire [31:0] in_im_2;                      //Wire with the imaginary part of the input to the 2nd FFT IP
wire [31:0] in_re_2;                      //Wire with the real part of the input to the 2nd FFT IP
	
always@(posedge clk)
begin
temp2_r <= out_re_2;   
temp2_i <= out_im_2;
end

assign out_im_2 = m_axis_data_tdata_1[63:32];        //assign imaginary part of 2d_fft output to wire
assign out_re_2 = m_axis_data_tdata_1[31:0];         //assign real part of 2d_fft  output to wire
assign in_im_2 = s_axis_data_tdata_1[63:32];         //assign imaginary part of 2d_fft input to wire
assign in_re_2 = s_axis_data_tdata_1[31:0];          //assign real part of 2d_fft input to wire





always@(posedge clk && (count  == 169000 ))
    begin
        s_axis_config_tvalid_1=1;
        s_axis_config_tvalid_1=0;
        s_axis_data_tvalid_1 =1;
        //m = 0;
    end

// input to fft2--> transpose of the 1D_FFT matrix
always@(posedge clk &&(count  >= 169000 ))
begin
        if(j<=128)
         begin
            if(i<16384)
              begin
                 s_axis_data_tdata_1[31:0] = FFT_real[i];
                 s_axis_data_tdata_1[63:32] = FFT_img[i];
                 i=i+128;
              end
              if(i==(16384+j))
                begin
                  j=j+1;
                  i=j;
                end
         end
     
     
end

// instantiate FFT IP--- for 2D_FFT--- along the y- direction
xfft_3 fft_3 (
  .aclk(clk),                                                   // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_1),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_1),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_1),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_1),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_1),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_1),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_1),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_1),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_1),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                                       // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_1),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_1),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_1),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_1),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_1),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_1),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_1)   // output wire event_data_out_channel_halt
);

endmodule 



 
