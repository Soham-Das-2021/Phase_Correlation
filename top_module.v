//***PHASE CORRELATION---- 2D_IFFT[(2D_FFT(Ref. Image)* X (2D_FFT(Shifted Image))]
//***Simulation time = 0.512ms

`timescale 1ns / 1ps

module top_module(clk  ,Out_Row, Out_Col);

input clk;
output reg signed [31:0] Out_Row;     //Row Shift
output reg signed [31:0] Out_Col;     //Column Shift
 
 wire [31:0] temp1_r1;               //4 wires to see the output of the two 2D-FFTs
 wire [31:0] temp1_i1;
 wire [31:0] temp2_r2;
 wire [31:0] temp2_i2;

reg [31:0] temp1_real;               //4 registers for the bit flip operation
reg [31:0] temp1_img;
reg [31:0] temp2_real;
reg [31:0] temp2_img;

reg [60:0] count;                   //needed for the always block-->from where to start capturing the data

 

reg [31:0] IFFT_real[0:16383];      //storing the real part oof the 2D_IFFT output
reg [31:0] IFFT_img[0:16383];       //storing the imaginary part of the 2D_IFFT output

 
 
reg signed [31:0] max;              //Peak value in the 2D_IFFT matrix

reg [31:0] N_square=32'b01000110100000000000000000000000;        //Floating point representation of the decimal value=16384--- have to divide IFFT matrix by N^2

integer j,i, k, l, p, m, n, u, a, b, x, y, x1, y1, row, col;
 

initial
begin
count=0;
j=0;  k=0; n=1;  a=1; b=1; x=0;y=0; x1=0;y1=0;
i=0; l=0; m=0; p=0; row=0; col=0; max=32'h00000000;
end



test_design_128x128 image1 (clk, temp1_r1, temp1_i1);      //Instantiating 2D_FFT module for the Reference Image


test_design2_128x128 image2 (clk, temp2_r2, temp2_i2);     //Instantiating 2D_FFT module for the Shifted Image

 

always@(posedge clk)
count = count+10;

//***Starting the Pixel by Pixel Multipliaction***
//Floating Point Operations----> 4 multiplications, 1 subtraction & 1 addition

//1st Floating Point Multiplication--- between the 2 real parts 
reg a_tvalid=0;
wire a_tready;
reg [31:0] a_tdata;
reg b_tvalid=0;
wire b_tready;
reg [31:0] b_tdata;
wire result1_tvalid;
wire result1_tready;
wire [31:0] result1_tdata;
wire [31:0] ac;

assign ac=result1_tdata;

floating_point_0 Fp_Mul_1 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a_tvalid),                  // input wire s_axis_a_tvalid
  
  .s_axis_a_tdata(a_tdata),                    // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(b_tvalid),                  // input wire s_axis_b_tvalid
  
  .s_axis_b_tdata(b_tdata),                    // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result1_tvalid),       // output wire m_axis_result_tvalid
  
  .m_axis_result_tdata(result1_tdata)          // output wire [31 : 0] m_axis_result_tdata
);

//2nd Floating Point Multiplication--- between the 2 imaginary parts
reg c_tvalid=0;
wire c_tready;
reg [31:0] c_tdata;
reg d_tvalid=0;
wire d_tready;
reg [31:0] d_tdata;
wire result2_tvalid;
wire result2_tready;
wire [31:0] result2_tdata;
wire [31:0] bd;

assign bd=result2_tdata;
        
floating_point_0 Fp_Mul_2 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(c_tvalid),                  // input wire s_axis_a_tvalid
  
  .s_axis_a_tdata(c_tdata),                    // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(d_tvalid),                  // input wire s_axis_b_tvalid

  .s_axis_b_tdata(d_tdata),                    // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result2_tvalid),       // output wire m_axis_result_tvalid
  
  .m_axis_result_tdata(result2_tdata)          // output wire [31 : 0] m_axis_result_tdata
);

//3rd Floating Point Multiplication--- between the imaginary part of Ref. Image's 2D_FFT & real part of Shifted Image's 2D_FFT
reg e_tvalid=0;
wire e_tready;
reg [31:0] e_tdata;
reg f_tvalid=0;
wire f_tready;
reg [31:0] f_tdata;
wire result3_tvalid;
wire result3_tready;
wire [31:0] result3_tdata;
wire [31:0] bc;

assign bc=result3_tdata;

floating_point_0 Fp_Mul_3 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(e_tvalid),                  // input wire s_axis_a_tvalid
  
  .s_axis_a_tdata(e_tdata),                    // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(f_tvalid),                  // input wire s_axis_b_tvalid
  
  .s_axis_b_tdata(f_tdata),                    // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result3_tvalid),       // output wire m_axis_result_tvalid
  
  .m_axis_result_tdata(result3_tdata)          // output wire [31 : 0] m_axis_result_tdata
);

//4th Floating Point Multiplication--- between the real part of Ref. Image's 2D_FFT & imaginary part of Shifted Image's 2D_FFT
reg g_tvalid=0;
wire g_tready;
reg [31:0] g_tdata;
reg h_tvalid=0;
wire h_tready;
reg [31:0] h_tdata;
wire result4_tvalid;
wire result4_tready;
wire [31:0] result4_tdata;
wire [31:0] ad;

assign ad=result4_tdata;

floating_point_0 Fp_Mul_4 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(g_tvalid),                  // input wire s_axis_a_tvalid
  
  .s_axis_a_tdata(g_tdata),                    // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(h_tvalid),                  // input wire s_axis_b_tvalid
  .s_axis_b_tdata(h_tdata),                    // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result4_tvalid),       // output wire m_axis_result_tvalid
  
  .m_axis_result_tdata(result4_tdata)          // output wire [31 : 0] m_axis_result_tdata
);

always@(posedge clk && (count==174000))
begin
 a_tvalid=1; b_tvalid=1; c_tvalid=1; d_tvalid=1; e_tvalid=1; f_tvalid=1; g_tvalid=1; h_tvalid=1;
 i=0;
end

always@(posedge clk && (count>=174000) && (i<=16384))
begin
  temp1_img=temp1_i1;
  temp1_real=temp1_r1;
  temp1_img[31]=~temp1_img[31];   //performing the conjugate operation on the 1st image
  temp2_img=temp2_i2;
  temp2_real=temp2_r2;
  
  a_tdata=temp1_real; b_tdata=temp2_real;   //AT each clock cycle, conjugate operation is done and the required data are fed to the Floating Point Multipliers
  c_tdata=temp1_img; d_tdata=temp2_img;
  e_tdata=temp1_img; f_tdata=temp2_real;
  g_tdata=temp1_real; h_tdata=temp2_img;
  
  i=i+1;
end

 
//Floating Point Subtraction--- (ac - bd)--- Real part of the Pixel by Pixel Multiplication
reg s1_tvalid=0;
wire s1_tready;
reg [31:0] s1_tdata;
reg s2_tvalid=0;
wire s2_tready;
reg [31:0] s2_tdata;
wire sub_tvalid;
wire sub_tready;
wire [31:0] sub_tdata;
wire [31:0] sub;

assign sub=sub_tdata;

floating_point_1 Fp_Sub_1 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(s1_tvalid),                 // input wire s_axis_a_tvalid
  .s_axis_a_tdata(s1_tdata),                   // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(s2_tvalid),                 // input wire s_axis_b_tvalid
  .s_axis_b_tdata(s2_tdata),                   // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(sub_tvalid),           // output wire m_axis_result_tvalid
  .m_axis_result_tdata(sub_tdata)              // output wire [31 : 0] m_axis_result_tdata
);

//Floating Point Addition--- (bc + ad)--- Imaginary part of the Pixel by Pixel Multiplication
reg a1_tvalid=0;
wire a1_tready;
reg [31:0] a1_tdata;
reg a2_tvalid=0;
wire a2_tready;
reg [31:0] a2_tdata;
wire add_tvalid;
wire add_tready;
wire [31:0] add_tdata;
wire [31:0] add;

assign add=add_tdata;

floating_point_2 Fp_Add_1 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a1_tvalid),                 // input wire s_axis_a_tvalid
  .s_axis_a_tdata(a1_tdata),                   // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(a2_tvalid),                 // input wire s_axis_b_tvalid
  .s_axis_b_tdata(a2_tdata),                   // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(add_tvalid),           // output wire m_axis_result_tvalid
  .m_axis_result_tdata(add_tdata)              // output wire [31 : 0] m_axis_result_tdata
);

always@(posedge clk && (count==174090))
begin
 a1_tvalid=1; a2_tvalid=1; s1_tvalid=1; s2_tvalid=1; 
 l=0;
end

always@(posedge clk && (count>=174090) && (l<=16384))
begin
 s1_tdata=ac; s2_tdata=bd;
 a1_tdata=bc; a2_tdata=ad;
 l=l+1;
end

//***Starting the 2d_IFFT Operation*** 


reg [15:0] s_axis_config_tdata_5=16'h0;         //for FFT IP to perform IFFT operation, Config_tdata signal should be = '0'
reg s_axis_config_tvalid_5=0;
wire s_axis_config_tready_5;
reg [63:0] s_axis_data_tdata_5;
reg s_axis_data_tvalid_5=0;
wire s_axis_data_tready_5;
reg s_axis_data_tlast_5=0;
wire [63:0] m_axis_data_tdata_5;
wire m_axis_data_tvalid_5;
wire m_axis_data_tlast_5;
wire event_frame_started_5;
wire event_tlast_unexpected_5;
wire event_tlast_missing_5;
wire event_data_in_channel_halt_5;
wire event_status_channel_halt_5;
wire event_data_out_channel_halt_5;
wire  [31:0] out_im_5;
wire [31:0] out_re_5;
wire [31:0] in_im_5;
wire [31:0] in_re_5;

assign out_im_5 = m_axis_data_tdata_5[63:32];              //assign imaginary part of 1d_ifft output to wire
assign out_re_5 = m_axis_data_tdata_5[31:0];               //assign real part of 1d_ifft  output to wire
assign in_im_5 = s_axis_data_tdata_5[63:32];               //assign imaginary part of 1d_ifft input to wire
assign in_re_5 = s_axis_data_tdata_5[31:0];                //assign real part of 1d_ifft input to wire





always@(posedge clk && (count  == 174210 ))
    begin
        s_axis_config_tvalid_5=1;
        s_axis_config_tvalid_5=0;
        s_axis_data_tvalid_5 =1;
        p = 0;
    end

// input to FFT IP--- to get 1D_IFFT
always@(posedge clk &&(count  >= 174210 )&&(p <= 16384))
begin
    s_axis_data_tdata_5[31:0] = sub;
    s_axis_data_tdata_5[63:32] = add;
     p= p+1;
end

// instantiate FFT IP
xfft_4 fft_5 (
  .aclk(clk),                                                   // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_5),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_5),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_5),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_5),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_5),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_5),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_5),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_5),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_5),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                                       // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_5),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_5),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_5),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_5),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_5),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_5),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_5)   // output wire event_data_out_channel_halt
);

// storing 1D_IFFT output into registers
always@(posedge clk)
begin
       if((count>=179200) && (m<=16384))
       
           begin
              IFFT_real[m]=out_re_5;
              IFFT_img[m]=out_im_5;
              m=m+1;
           end
   
end 

 

reg [15:0] s_axis_config_tdata_6=16'h0;
reg s_axis_config_tvalid_6=0;
wire s_axis_config_tready_6;
reg [63:0] s_axis_data_tdata_6;
reg s_axis_data_tvalid_6=0;
wire s_axis_data_tready_6;
reg s_axis_data_tlast_6=0;
wire [63:0] m_axis_data_tdata_6;
wire m_axis_data_tvalid_6;
wire m_axis_data_tlast_6;
wire event_frame_started_6;
wire event_tlast_unexpected_6;
wire event_tlast_missing_6;
wire event_data_in_channel_halt_6;
wire event_status_channel_halt_6;
wire event_data_out_channel_halt_6;
wire signed [31:0] out_im_6;
wire signed[31:0] out_re_6;
wire [31:0] in_im_6;
wire [31:0] in_re_6;

assign out_im_6 = m_axis_data_tdata_6[63:32];  //imagenory 2d_ift output
assign out_re_6 = m_axis_data_tdata_6[31:0];  // real 2d_ift  output
assign in_im_6 = s_axis_data_tdata_6[63:32];  // imagenory 2d_ift input
assign in_re_6 = s_axis_data_tdata_6[31:0];   // real 2d_ift input


always@(posedge clk && (count  == 343100 ))
    begin
        s_axis_config_tvalid_6=1;
        s_axis_config_tvalid_6=0;
        s_axis_data_tvalid_6 =1;
        //u = 0;
    end

// input to FFT IP--- as the transpose of 1D_IFFT matrix
always@(posedge clk &&(count  >= 343100 ))
begin
      if(j<=128)
         begin
            if(k<16384)
              begin
                 s_axis_data_tdata_6[31:0] = IFFT_real[k];
                 s_axis_data_tdata_6[63:32] = IFFT_img[k];
                 k=k+128;
              end
              if(k==(16384+j))
                begin
                  j=j+1;
                  k=j;
                end
         end
    
end

// instantiate FFT IP--- to get the 2D_IFFT matrix
xfft_5 fft_6 (
  .aclk(clk),                                                   // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_6),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_6),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_6),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_6),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_6),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_6),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_6),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_6),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_6),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                                       // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_6),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_6),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_6),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_6),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_6),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_6),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_6)   // output wire event_data_out_channel_halt
);

 
//*** Performing FFT Shift and then finding the location of the Peak Value in the 128 X 128 matrix to get the Shift
always@(posedge clk && (count>=348090))
begin
   if(a<129)
     begin
       if(b<129)
         begin
            
            if(out_re_6>max)
              begin
               max=out_re_6;
               x=a;
               y=b;
               if((x==1) && (y==1))
                 begin
                    x1=x;
                    y1=y;
                    row=x1-1;
                    col=y1-1;
                 end
               else if((x==1) && (y>1)) 
                 begin
                    x1=x;
                    y1=130-y;
                    if((x1<65) && (y1<65))
                      begin
                         row=x1-1;
                         col=y1-1;
                      end
                    else if((x1<65) && (y1>64))
                      begin
                         row=x1-1;
                         col=y1-129;
                      end  
                    else if((x1>64) && (y1<65))
                      begin
                         row=x1-129;
                         col=y1-1;
                      end   
                    else if((x1>64) && (y1>64))
                      begin
                         row=x1-129;
                         col=y1-129;
                      end     
                 end 
                 else if((x>1) && (y==1)) 
                 begin
                    x1=130-x;
                    y1=y;
                    if((x1<65) && (y1<65))
                      begin
                         row=x1-1;
                         col=y1-1;
                      end
                    else if((x1<65) && (y1>64))
                      begin
                         row=x1-1;
                         col=y1-129;
                      end  
                    else if((x1>64) && (y1<65))
                      begin
                         row=x1-129;
                         col=y1-1;
                      end   
                    else if((x1>64) && (y1>64))
                      begin
                         row=x1-129;
                         col=y1-129;
                      end     
                 end  
                 else if((x>1) && (y>1)) 
                 begin
                    x1=130-x;
                    y1=130-y;
                    if((x1<65) && (y1<65))
                      begin
                         row=x1-1;
                         col=y1-1;
                      end
                    else if((x1<65) && (y1>64))
                      begin
                         row=x1-1;
                         col=y1-129;
                      end  
                    else if((x1>64) && (y1<65))
                      begin
                         row=x1-129;
                         col=y1-1;
                      end   
                    else if((x1>64) && (y1>64))
                      begin
                         row=x1-129;
                         col=y1-129;
                      end     
                 end  
              end  
            b=b+1;
         end
         if(b>128)
           begin
              a=a+1;
              b=1;
           end
     end
    Out_Row=row;
    Out_Col=col;
end

endmodule




