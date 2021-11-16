`timescale 1ns / 1ps

module top_module(clk  ,Out_Row, Out_Col);

input clk;
output reg signed [31:0] Out_Row;
output reg signed [31:0] Out_Col;
 
 wire [15:0] temp1_r1;//4 wires to see the output of the two 2D-FFTs
 wire [15:0] temp1_i1;
 wire [15:0] temp2_r2;
 wire [15:0] temp2_i2;
 wire [15:0] temp3_r3;
 wire [15:0] temp3_i3;
 wire [15:0] temp4_r4;
 wire [15:0] temp4_i4;
 wire [15:0] temp5_r5;
 wire [15:0] temp5_i5;
 wire [15:0] temp6_r6;
 wire [15:0] temp6_i6;
 wire [15:0] temp7_r7;
 wire [15:0] temp7_i7;
 wire [15:0] temp8_r8;
 wire [15:0] temp8_i8;

reg [15:0] temp1_real;//4 regs for the bit flip operation
reg [15:0] temp1_img;
reg [15:0] temp2_real;
reg [15:0] temp2_img;
reg [15:0] temp3_real;
reg [15:0] temp3_img;
reg [15:0] temp4_real;
reg [15:0] temp4_img;
reg [15:0] temp5_real;
reg [15:0] temp5_img;
reg [15:0] temp6_real;
reg [15:0] temp6_img;
reg [15:0] temp7_real;
reg [15:0] temp7_img;
reg [15:0] temp8_real;
reg [15:0] temp8_img;

reg [60:0] count;     //needed for the always block-->from where to start capturing the data

 

reg [15:0] IFFT_real[0:255];
reg [15:0] IFFT_img[0:2555];
reg [15:0] IFFT_real1[0:255];
reg [15:0] IFFT_img1[0:255];
reg [15:0] IFFT_real2[0:255];
reg [15:0] IFFT_img2[0:255];
reg [15:0] IFFT_real3[0:255];
reg [15:0] IFFT_img3[0:255];

 
 
reg signed [30:0] max, max1, max2, max3;

 

integer j,i, k, k1, k2, k3, l, p1, p2, p3, p4, m, n, u, x_1, y_1, x1, y1, x_2, y_2, x2, y2, x_3, y_3, x3, y3, x_4, y_4, x4, y4, row, col, row1, col1, row2, col2, row3, col3, a_1, b_1, a_2, a_3, a_4;
integer z,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15; 
  

initial
begin
count=0;
j=0;  k=0; k1=32; k2=64; k3=96; n=1;a_1=1; b_1=1; a_2=33; a_3=65; a_4=97; x_1=0;y_1=0; x1=0;y1=0; x_2=0;y_2=0; x2=0;y2=0; x_3=0;y_3=0; x3=0;y3=0; x_4=0;y_4=0; x4=0;y4=0;
i=0; l=0; m=0; p1=0; p2=0; p3=0; p4=0; row=0; col=0; row1=0; col1=0; row2=0; col2=0; row3=0; col3=0; max=31'b0; max1=31'b0; max2=31'b0; max3=31'b0; 
z=0; z4=0; z8=0; z12=0;
z1=32; z5=32; z9=32; z13=32;
z2=64; z6=64; z10=64; z14=64;
z3=96; z7=96; z11=96; z15=96;
end



test_design_128x128 image1 (clk, temp1_r1, temp1_i1, temp2_r2, temp2_i2, temp3_r3, temp3_i3, temp4_r4, temp4_i4);


test_design2_128x128 image2 (clk, temp5_r5, temp5_i5, temp6_r6, temp6_i6, temp7_r7, temp7_i7, temp8_r8, temp8_i8);

 

always@(posedge clk)
count = count+10;

 
reg [15:0] a1,b1,c1,d1,a2,b2,c2,d2,a3,b3,c3,d3,a4,b4,c4,d4;
wire [30:0] a1c1,a1d1,b1c1,b1d1,a2c2,a2d2,b2c2,b2d2,a3c3,a3d3,b3c3,b3d3,a4c4,a4d4,b4c4,b4d4;
wire [30:0] add1, sub1, add2, sub2, add3, sub3, add4, sub4;
 

always@(posedge clk && (count>=47960) && (i<=256))
begin
  temp1_img=temp1_i1;
  temp1_real=temp1_r1;
  temp2_img=temp2_i2;
  temp2_real=temp2_r2;
  temp3_img=temp3_i3;
  temp3_real=temp3_r3;
  temp4_img=temp4_i4;
  temp4_real=temp4_r4;
      
  temp1_img[15]=~temp1_img[15];   //performing the conjugate operation on the 1st image
  temp1_img[14]=~temp1_img[14]; temp1_img[13]=~temp1_img[13]; temp1_img[12]=~temp1_img[12]; temp1_img[11]=~temp1_img[11];
  temp1_img[10]=~temp1_img[10]; temp1_img[9]=~temp1_img[9]; temp1_img[8]=~temp1_img[8]; temp1_img[7]=~temp1_img[7];
  temp1_img[6]=~temp1_img[6]; temp1_img[5]=~temp1_img[5]; temp1_img[4]=~temp1_img[4]; temp1_img[3]=~temp1_img[3];
  temp1_img[2]=~temp1_img[2]; temp1_img[1]=~temp1_img[1]; temp1_img[0]=~temp1_img[0];  
  temp2_img[15]=~temp2_img[15];    
  temp2_img[14]=~temp2_img[14]; temp2_img[13]=~temp2_img[13]; temp2_img[12]=~temp2_img[12]; temp2_img[11]=~temp2_img[11];
  temp2_img[10]=~temp2_img[10]; temp2_img[9]=~temp2_img[9]; temp2_img[8]=~temp2_img[8]; temp2_img[7]=~temp2_img[7];
  temp2_img[6]=~temp2_img[6]; temp2_img[5]=~temp2_img[5]; temp2_img[4]=~temp2_img[4]; temp2_img[3]=~temp2_img[3];
  temp2_img[2]=~temp2_img[2]; temp2_img[1]=~temp2_img[1]; temp2_img[0]=~temp2_img[0]; 
  temp3_img[15]=~temp3_img[15];    
  temp3_img[14]=~temp3_img[14]; temp3_img[13]=~temp3_img[13]; temp3_img[12]=~temp3_img[12]; temp3_img[11]=~temp3_img[11];
  temp3_img[10]=~temp3_img[10]; temp3_img[9]=~temp3_img[9]; temp3_img[8]=~temp3_img[8]; temp3_img[7]=~temp3_img[7];
  temp3_img[6]=~temp3_img[6]; temp3_img[5]=~temp3_img[5]; temp3_img[4]=~temp3_img[4]; temp3_img[3]=~temp3_img[3];
  temp3_img[2]=~temp3_img[2]; temp3_img[1]=~temp3_img[1]; temp3_img[0]=~temp3_img[0]; 
  temp4_img[15]=~temp4_img[15];    
  temp4_img[14]=~temp4_img[14]; temp4_img[13]=~temp4_img[13]; temp4_img[12]=~temp4_img[12]; temp4_img[11]=~temp4_img[11];
  temp4_img[10]=~temp4_img[10]; temp4_img[9]=~temp4_img[9]; temp4_img[8]=~temp4_img[8]; temp4_img[7]=~temp4_img[7];
  temp4_img[6]=~temp4_img[6]; temp4_img[5]=~temp4_img[5]; temp4_img[4]=~temp4_img[4]; temp4_img[3]=~temp4_img[3];
  temp4_img[2]=~temp4_img[2]; temp4_img[1]=~temp4_img[1]; temp4_img[0]=~temp4_img[0]; 
  
  temp5_img=temp5_i5;
  temp5_real=temp5_r5;
  temp6_img=temp6_i6;
  temp6_real=temp6_r6;
  temp7_img=temp7_i7;
  temp7_real=temp7_r7;
  temp8_img=temp8_i8;
  temp8_real=temp8_r8;
  
  temp1_img=temp1_img+1;
  temp2_img=temp2_img+1;
  temp3_img=temp3_img+1;
  temp4_img=temp4_img+1;
  
  a1=temp1_real; c1=temp5_real;
  b1=temp1_img; d1=temp5_img;
  a2=temp2_real; c2=temp6_real;
  b2=temp2_img; d2=temp6_img;  
  a3=temp3_real; c3=temp7_real;
  b3=temp3_img; d3=temp7_img;
  a4=temp4_real; c4=temp8_real;
  b4=temp4_img; d4=temp8_img;
  
  i=i+1;
end

mult_gen_0 MUL1 (
  .CLK(clk),  // input wire CLK
  .A(a1),      // input wire [31 : 0] A
  .B(c1),      // input wire [31 : 0] B
  .P(a1c1)      // output wire [63 : 0] P
); 

mult_gen_0 MUL2 (
  .CLK(clk),  // input wire CLK
  .A(a1),      // input wire [31 : 0] A
  .B(d1),      // input wire [31 : 0] B
  .P(a1d1)      // output wire [63 : 0] P
);

mult_gen_0 MUL3 (
  .CLK(clk),  // input wire CLK
  .A(b1),      // input wire [31 : 0] A
  .B(c1),      // input wire [31 : 0] B
  .P(b1c1)      // output wire [63 : 0] P
);

mult_gen_0 MUL4 (
  .CLK(clk),  // input wire CLK
  .A(b1),      // input wire [31 : 0] A
  .B(d1),      // input wire [31 : 0] B
  .P(b1d1)      // output wire [63 : 0] P
);

mult_gen_0 MUL5 (
  .CLK(clk),  // input wire CLK
  .A(a2),      // input wire [31 : 0] A
  .B(c2),      // input wire [31 : 0] B
  .P(a2c2)      // output wire [63 : 0] P
); 

mult_gen_0 MUL6 (
  .CLK(clk),  // input wire CLK
  .A(a2),      // input wire [31 : 0] A
  .B(d2),      // input wire [31 : 0] B
  .P(a2d2)      // output wire [63 : 0] P
);

mult_gen_0 MUL7 (
  .CLK(clk),  // input wire CLK
  .A(b2),      // input wire [31 : 0] A
  .B(c2),      // input wire [31 : 0] B
  .P(b2c2)      // output wire [63 : 0] P
);

mult_gen_0 MUL8 (
  .CLK(clk),  // input wire CLK
  .A(b2),      // input wire [31 : 0] A
  .B(d2),      // input wire [31 : 0] B
  .P(b2d2)      // output wire [63 : 0] P
);

mult_gen_0 MUL9 (
  .CLK(clk),  // input wire CLK
  .A(a3),      // input wire [31 : 0] A
  .B(c3),      // input wire [31 : 0] B
  .P(a3c3)      // output wire [63 : 0] P
); 

mult_gen_0 MUL10 (
  .CLK(clk),  // input wire CLK
  .A(a3),      // input wire [31 : 0] A0
  .B(d3),      // input wire [31 : 0] B
  .P(a3d3)      // output wire [63 : 0] P
);

mult_gen_0 MUL11 (
  .CLK(clk),  // input wire CLK
  .A(b3),      // input wire [31 : 0] A
  .B(c3),      // input wire [31 : 0] B
  .P(b3c3)      // output wire [63 : 0] P
);

mult_gen_0 MUL12 (
  .CLK(clk),  // input wire CLK
  .A(b3),      // input wire [31 : 0] A
  .B(d3),      // input wire [31 : 0] B
  .P(b3d3)      // output wire [63 : 0] P
);

mult_gen_0 MUL13 (
  .CLK(clk),  // input wire CLK
  .A(a4),      // input wire [31 : 0] A
  .B(c4),      // input wire [31 : 0] B
  .P(a4c4)      // output wire [63 : 0] P
); 

mult_gen_0 MUL14(
  .CLK(clk),  // input wire CLK
  .A(a4),      // input wire [31 : 0] A
  .B(d4),      // input wire [31 : 0] B
  .P(a4d4)      // output wire [63 : 0] P
);

mult_gen_0 MUL15 (
  .CLK(clk),  // input wire CLK
  .A(b4),      // input wire [31 : 0] A
  .B(c4),      // input wire [31 : 0] B
  .P(b4c4)      // output wire [63 : 0] P
);

mult_gen_0 MUL16 (
  .CLK(clk),  // input wire CLK
  .A(b4),      // input wire [31 : 0] A
  .B(d4),      // input wire [31 : 0] B
  .P(b4d4)      // output wire [63 : 0] P
);
 
 assign add1=b1c1+a1d1;
 assign sub1=a1c1-b1d1; 
 assign add2=b2c2+a2d2;
 assign sub2=a2c2-b2d2;
 assign add3=b3c3+a3d3;
 assign sub3=a3c3-b3d3;
 assign add4=b4c4+a4d4;
 assign sub4=a4c4-b4d4;
 


reg [15:0] s_axis_config_tdata_16=16'h0;
reg s_axis_config_tvalid_16=0;
wire s_axis_config_tready_16;
reg [63:0] s_axis_data_tdata_16;
reg s_axis_data_tvalid_16=0;
wire s_axis_data_tready_16;
reg s_axis_data_tlast_16=0;
wire [63:0] m_axis_data_tdata_16;
wire m_axis_data_tvalid_16;
wire m_axis_data_tlast_16;
wire event_frame_started_16;
wire event_tlast_unexpected_16;
wire event_tlast_missing_16;
wire event_data_in_channel_halt_16;
wire event_status_channel_halt_16;
wire event_data_out_channel_halt_16;
wire  [30:0] out_im_16;
wire [30:0] out_re_16;
wire [30:0] in_im_16;
wire [30:0] in_re_16;

assign out_im_16 = m_axis_data_tdata_16[62:32];  //imagenory 1d_ift output
assign out_re_16 = m_axis_data_tdata_16[30:0];  // real 1d_ift  output
assign in_im_16 = s_axis_data_tdata_16[62:32];  // imagenory 1d_ift input
assign in_re_16 = s_axis_data_tdata_16[30:0];   // real 1d_ift input


always@(posedge clk && (count  == 47980 ))
    begin
        s_axis_config_tvalid_16=1;
        s_axis_config_tvalid_16=0;
        s_axis_data_tvalid_16 =1;
        //p = 0;
    end

// input to fft5
always@(posedge clk &&(count  >= 47980 )&&(p1 <= 256))
begin
    s_axis_data_tdata_16[30:0] = sub1;
    s_axis_data_tdata_16[62:32] = add1;
     p1= p1+1;
end

// instantiate fft5 for 1D-ift
xfft_4 fft_16 (
  .aclk(clk),                                                    // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_16),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_16),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_16),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_16),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_16),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_16),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_16),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_16),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_16),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_16),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_16),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_16),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_16),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_16),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_16),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_16)   // output wire event_data_out_channel_halt
);

reg [15:0] s_axis_config_tdata_17=16'h0;
reg s_axis_config_tvalid_17=0;
wire s_axis_config_tready_17;
reg [63:0] s_axis_data_tdata_17;
reg s_axis_data_tvalid_17=0;
wire s_axis_data_tready_17;
reg s_axis_data_tlast_17=0;
wire [63:0] m_axis_data_tdata_17;
wire m_axis_data_tvalid_17;
wire m_axis_data_tlast_17;
wire event_frame_started_17;
wire event_tlast_unexpected_17;
wire event_tlast_missing_17;
wire event_data_in_channel_halt_17;
wire event_status_channel_halt_17;
wire event_data_out_channel_halt_17;
wire  [30:0] out_im_17;
wire [30:0] out_re_17;
wire [30:0] in_im_17;
wire [30:0] in_re_17;

assign out_im_17 = m_axis_data_tdata_17[62:32];  //imagenory 1d_ift output
assign out_re_17 = m_axis_data_tdata_17[30:0];  // real 1d_ift  output
assign in_im_17 = s_axis_data_tdata_17[62:32];  // imagenory 1d_ift input
assign in_re_17 = s_axis_data_tdata_17[30:0];   // real 1d_ift input


always@(posedge clk && (count  == 47980 ))
    begin
        s_axis_config_tvalid_17=1;
        s_axis_config_tvalid_17=0;
        s_axis_data_tvalid_17 =1;
       // p = 0;
    end

// input to fft5
always@(posedge clk &&(count  >= 47980 )&&(p2 <= 256))
begin
    s_axis_data_tdata_17[30:0] = sub2;
    s_axis_data_tdata_17[62:32] = add2;
     p2= p2+1;
end

// instantiate fft5 for 1D-ift
xfft_4 fft_17 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_17),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_17),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_17),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_17),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_17),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_17),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_17),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_17),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_17),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_17),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_17),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_17),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_17),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_17),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_17),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_17)  // output wire event_data_out_channel_halt
);

reg [15:0] s_axis_config_tdata_18=16'h0;
reg s_axis_config_tvalid_18=0;
wire s_axis_config_tready_18;
reg [63:0] s_axis_data_tdata_18;
reg s_axis_data_tvalid_18=0;
wire s_axis_data_tready_18;
reg s_axis_data_tlast_18=0;
wire [63:0] m_axis_data_tdata_18;
wire m_axis_data_tvalid_18;
wire m_axis_data_tlast_18;
wire event_frame_started_18;
wire event_tlast_unexpected_18;
wire event_tlast_missing_18;
wire event_data_in_channel_halt_18;
wire event_status_channel_halt_18;
wire event_data_out_channel_halt_18;
wire  [30:0] out_im_18;
wire [30:0] out_re_18;
wire [30:0] in_im_18;
wire [30:0] in_re_18;

assign out_im_18 = m_axis_data_tdata_18[62:32];  //imagenory 1d_ift output
assign out_re_18 = m_axis_data_tdata_18[30:0];  // real 1d_ift  output
assign in_im_18 = s_axis_data_tdata_18[62:32];  // imagenory 1d_ift input
assign in_re_18 = s_axis_data_tdata_18[30:0];   // real 1d_ift input


always@(posedge clk && (count  == 47980 ))
    begin
        s_axis_config_tvalid_18=1;
        s_axis_config_tvalid_18=0;
        s_axis_data_tvalid_18 =1;
       // p = 0;
    end

// input to fft5
always@(posedge clk &&(count  >= 47980 )&&(p3 <= 256))
begin
    s_axis_data_tdata_18[30:0] = sub3;
    s_axis_data_tdata_18[62:32] = add3;
     p3= p3+1;
end

// instantiate fft5 for 1D-ift
xfft_4 fft_18 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_18),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_18),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_18),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_18),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_18),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_18),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_18),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_18),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_18),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_18),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_18),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_18),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_18),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_18),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_18),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_18)  // output wire event_data_out_channel_halt
);


reg [15:0] s_axis_config_tdata_19=16'h0;
reg s_axis_config_tvalid_19=0;
wire s_axis_config_tready_19;
reg [63:0] s_axis_data_tdata_19;
reg s_axis_data_tvalid_19=0;
wire s_axis_data_tready_19;
reg s_axis_data_tlast_19=0;
wire [63:0] m_axis_data_tdata_19;
wire m_axis_data_tvalid_19;
wire m_axis_data_tlast_19;
wire event_frame_started_19;
wire event_tlast_unexpected_19;
wire event_tlast_missing_19;
wire event_data_in_channel_halt_19;
wire event_status_channel_halt_19;
wire event_data_out_channel_halt_19;
wire  [30:0] out_im_19;
wire [30:0] out_re_19;
wire [30:0] in_im_19;
wire [30:0] in_re_19;

assign out_im_19 = m_axis_data_tdata_19[62:32];  //imagenory 1d_ift output
assign out_re_19 = m_axis_data_tdata_19[30:0];  // real 1d_ift  output
assign in_im_19 = s_axis_data_tdata_19[62:32];  // imagenory 1d_ift input
assign in_re_19 = s_axis_data_tdata_19[30:0];   // real 1d_ift input


always@(posedge clk && (count  == 47980 ))
    begin
        s_axis_config_tvalid_19=1;
        s_axis_config_tvalid_19=0;
        s_axis_data_tvalid_19 =1;
        //p = 0;
    end

// input to fft5
always@(posedge clk &&(count  >= 47980 )&&(p4 <= 256))
begin
    s_axis_data_tdata_19[30:0] = sub4;
    s_axis_data_tdata_19[62:32] = add4;
     p4= p4+1;
end

// instantiate fft5 for 1D-ift
xfft_4 fft_19 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_19),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_19),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_19),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_19),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_19),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_19),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_19),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_19),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_19),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_19),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_19),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_19),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_19),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_19),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_19),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_19)  // output wire event_data_out_channel_halt
);



// storing 1d output to memory
always@(posedge clk)
begin
       if((count>=51490) && (m<=256))
       
           begin
              IFFT_real[m]=out_re_16;
              IFFT_img[m]=out_im_16;
              IFFT_real1[m]=out_re_17;
              IFFT_img1[m]=out_im_17;
              IFFT_real2[m]=out_re_18;
              IFFT_img2[m]=out_im_18;
              IFFT_real3[m]=out_re_19;
              IFFT_img3[m]=out_im_19;
              m=m+1; 
           end
   
end 

 

reg [15:0] s_axis_config_tdata_20=16'h0;
reg s_axis_config_tvalid_20=0;
wire s_axis_config_tready_20;
reg [63:0] s_axis_data_tdata_20;
reg s_axis_data_tvalid_20=0;
wire s_axis_data_tready_20;
reg s_axis_data_tlast_20=0;
wire [63:0] m_axis_data_tdata_20;
wire m_axis_data_tvalid_20;
wire m_axis_data_tlast_20;
wire event_frame_started_20;
wire event_tlast_unexpected_20;
wire event_tlast_missing_20;
wire event_data_in_channel_halt_20;
wire event_status_channel_halt_20;
wire event_data_out_channel_halt_20;
wire signed [30:0] out_im_20;
wire signed[30:0] out_re_20;
wire [30:0] in_im_20;
wire [30:0] in_re_20;

assign out_im_20 = m_axis_data_tdata_20[62:32];  //imagenory 2d_ift output
assign out_re_20 = m_axis_data_tdata_20[30:0];  // real 2d_ift  output
assign in_im_20 = s_axis_data_tdata_20[62:32];  // imagenory 2d_ift input
assign in_re_20 = s_axis_data_tdata_20[30:0];   // real 2d_ift input


always@(posedge clk && (count  == 92500 ))
    begin
        s_axis_config_tvalid_20=1;
        s_axis_config_tvalid_20=0;
        s_axis_data_tvalid_20 =1;
        //u = 0;
    end



// instantiate fft6 for 2D-ift
xfft_5 fft_20 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_20),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_20),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_20),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_20),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_20),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_20),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_20),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_20),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_20),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_20),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_20),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_20),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_20),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_20),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_20),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_20)  // output wire event_data_out_channel_halt
);


reg [15:0] s_axis_config_tdata_21=16'h0;
reg s_axis_config_tvalid_21=0;
wire s_axis_config_tready_21;
reg [63:0] s_axis_data_tdata_21;
reg s_axis_data_tvalid_21=0;
wire s_axis_data_tready_21;
reg s_axis_data_tlast_21=0;
wire [63:0] m_axis_data_tdata_21;
wire m_axis_data_tvalid_21;
wire m_axis_data_tlast_21;
wire event_frame_started_21;
wire event_tlast_unexpected_21;
wire event_tlast_missing_21;
wire event_data_in_channel_halt_21;
wire event_status_channel_halt_21;
wire event_data_out_channel_halt_21;
wire signed [30:0] out_im_21;
wire signed[30:0] out_re_21;
wire [30:0] in_im_21;
wire [30:0] in_re_21;

assign out_im_21 = m_axis_data_tdata_21[62:32];  //imagenory 2d_ift output
assign out_re_21 = m_axis_data_tdata_21[30:0];  // real 2d_ift  output
assign in_im_21 = s_axis_data_tdata_21[62:32];  // imagenory 2d_ift input
assign in_re_21 = s_axis_data_tdata_21[30:0];   // real 2d_ift input


always@(posedge clk && (count  == 92500 ))
    begin
        s_axis_config_tvalid_21=1;
        s_axis_config_tvalid_21=0;
        s_axis_data_tvalid_21 =1;
        //u = 0;
    end



// instantiate fft6 for 2D-ift
xfft_5 fft_21 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_21),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_21),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_21),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_21),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_21),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_21),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_21),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_21),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_21),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_21),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_21),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_21),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_21),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_21),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_21),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_21)  // output wire event_data_out_channel_halt
);
 
 
reg [15:0] s_axis_config_tdata_22=16'h0;
reg s_axis_config_tvalid_22=0;
wire s_axis_config_tready_22;
reg [63:0] s_axis_data_tdata_22;
reg s_axis_data_tvalid_22=0;
wire s_axis_data_tready_22;
reg s_axis_data_tlast_22=0;
wire [63:0] m_axis_data_tdata_22;
wire m_axis_data_tvalid_22;
wire m_axis_data_tlast_22;
wire event_frame_started_22;
wire event_tlast_unexpected_22;
wire event_tlast_missing_22;
wire event_data_in_channel_halt_22;
wire event_status_channel_halt_22;
wire event_data_out_channel_halt_22;
wire signed [30:0] out_im_22;
wire signed[30:0] out_re_22;
wire [30:0] in_im_22;
wire [30:0] in_re_22;

assign out_im_22 = m_axis_data_tdata_22[62:32];  //imagenory 2d_ift output
assign out_re_22 = m_axis_data_tdata_22[30:0];  // real 2d_ift  output
assign in_im_22 = s_axis_data_tdata_22[62:32];  // imagenory 2d_ift input
assign in_re_22 = s_axis_data_tdata_22[30:0];   // real 2d_ift input


always@(posedge clk && (count  == 92500 ))
    begin
        s_axis_config_tvalid_22=1;
        s_axis_config_tvalid_22=0;
        s_axis_data_tvalid_22 =1;
        //u = 0;
    end



// instantiate fft6 for 2D-ift
xfft_5 fft_22 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_22),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_22),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_22),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_22),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_22),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_22),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_22),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_22),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_22),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_22),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_22),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_22),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_22),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_22),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_22),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_22)  // output wire event_data_out_channel_halt
);
 
 
reg [15:0] s_axis_config_tdata_23=16'h0;
reg s_axis_config_tvalid_23=0;
wire s_axis_config_tready_23;
reg [63:0] s_axis_data_tdata_23;
reg s_axis_data_tvalid_23=0;
wire s_axis_data_tready_23;
reg s_axis_data_tlast_23=0;
wire [63:0] m_axis_data_tdata_23;
wire m_axis_data_tvalid_23;
wire m_axis_data_tlast_23;
wire event_frame_started_23;
wire event_tlast_unexpected_23;
wire event_tlast_missing_23;
wire event_data_in_channel_halt_23;
wire event_status_channel_halt_23;
wire event_data_out_channel_halt_23;
wire signed [30:0] out_im_23;
wire signed[30:0] out_re_23;
wire [30:0] in_im_23;
wire [30:0] in_re_23;

assign out_im_23 = m_axis_data_tdata_23[62:32];  //imagenory 2d_ift output
assign out_re_23 = m_axis_data_tdata_23[30:0];  // real 2d_ift  output
assign in_im_23 = s_axis_data_tdata_23[62:32];  // imagenory 2d_ift input
assign in_re_23 = s_axis_data_tdata_23[30:0];   // real 2d_ift input


always@(posedge clk && (count  == 92500 ))
    begin
        s_axis_config_tvalid_23=1;
        s_axis_config_tvalid_23=0;
        s_axis_data_tvalid_23 =1;
        //u = 0;
    end



// instantiate fft6 for 2D-ift
xfft_5 fft_23 (
  .aclk(clk),                                                // input wire aclk
  .s_axis_config_tdata(s_axis_config_tdata_23),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid_23),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready_23),                // output wire s_axis_config_tready
  .s_axis_data_tdata(s_axis_data_tdata_23),                      // input wire [63 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid_23),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready_23),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast_23),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_axis_data_tdata_23),                      // output wire [63 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid_23),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast_23),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started_23),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected_23),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing_23),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt_23),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt_23),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt_23)  // output wire event_data_out_channel_halt
);
 
 
// input to fft6--> to get the final 2D-IFT o/p
always@(posedge clk &&(count  >= 92500 ))
begin
     if(j<=7)
         begin
            if((z<=255) && (z1<=255) && (z2<=255) && (z3<=255))
              begin
                 s_axis_data_tdata_20[15:0] <= IFFT_real[z];
                 s_axis_data_tdata_20[31:16] <= IFFT_img[z];
                 s_axis_data_tdata_21[15:0] <= IFFT_real[z1];
                 s_axis_data_tdata_21[31:16] <= IFFT_img[z1];
                 s_axis_data_tdata_22[15:0] <= IFFT_real[z2];
                 s_axis_data_tdata_22[31:16] <= IFFT_img[z2];
                 s_axis_data_tdata_23[15:0] <= IFFT_real[z3];
                 s_axis_data_tdata_23[31:16] <= IFFT_img[z3];
                 z<=z+32; z1<=z1+32; z2<=z2+32; z3<=z3+32;
              end
            if((z>=256) && (z4<256) && (z5<256) && (z6<256) && (z7<256))
              begin
                 s_axis_data_tdata_20[15:0] <= IFFT_real1[z4];
                 s_axis_data_tdata_20[31:16] <= IFFT_img1[z4];
                 s_axis_data_tdata_21[15:0] <= IFFT_real1[z5];
                 s_axis_data_tdata_21[31:16] <= IFFT_img1[z5];
                 s_axis_data_tdata_22[15:0] <= IFFT_real1[z6];
                 s_axis_data_tdata_22[31:16] <= IFFT_img1[z6];
                 s_axis_data_tdata_23[15:0] <= IFFT_real1[z7];
                 s_axis_data_tdata_23[31:16] <= IFFT_img1[z7];
                 z4<=z4+32; z5<=z5+32; z6<=z6+32; z7<=z7+32;
              end  
            if((z4>=256) && (z8<256) && (z9<256) && (z10<256) && (z11<256))
              begin
                 s_axis_data_tdata_20[15:0] <= IFFT_real2[z8];
                 s_axis_data_tdata_20[31:16] <= IFFT_img2[z8];
                 s_axis_data_tdata_21[15:0] <= IFFT_real2[z9];
                 s_axis_data_tdata_21[31:16] <= IFFT_img2[z9];
                 s_axis_data_tdata_22[15:0] <= IFFT_real2[z10];
                 s_axis_data_tdata_22[31:16] <= IFFT_img2[z10];
                 s_axis_data_tdata_23[15:0] <= IFFT_real2[z11];
                 s_axis_data_tdata_23[31:16] <= IFFT_img2[z11];
                 z8<=z8+32; z9<=z9+32; z10<=z10+32; z11<=z11+32;
              end  
            if((z8>=256) && (z12<256) && (z13<256) && (z14<256) && (z15<256))
              begin
                 s_axis_data_tdata_20[15:0] <= IFFT_real3[z12];
                 s_axis_data_tdata_20[31:16] <= IFFT_img3[z12];
                 s_axis_data_tdata_21[15:0] <= IFFT_real3[z13];
                 s_axis_data_tdata_21[31:16] <= IFFT_img3[z13];
                 s_axis_data_tdata_22[15:0] <= IFFT_real3[z14];
                 s_axis_data_tdata_22[31:16] <= IFFT_img3[z14];
                 s_axis_data_tdata_23[15:0] <= IFFT_real3[z15];
                 s_axis_data_tdata_23[31:16] <= IFFT_img3[z15];
                 z12<=z12+32; z13<=z13+32; z14<=z14+32; z15<=z15+32;
              end  
              if(z12==(256+j))
                begin
                  j=j+1; 
                  z=j; z4=j; z8=j; z12=j;
                  z1=8+j; z5=8+j; z9=8+j; z13=8+j;
                  z2=16+j; z6=16+j; z10=16+j; z14=16+j;
                  z3=24+j; z7=24+j; z11=24+j; z15=24+j;
                end
         end
    
end 
 

always@(posedge clk && (count>=96010))
begin
   if(a_1<33)
     begin
       if(b_1<129)
         begin
            
            if(out_re_20>max)
              begin
               max=out_re_20;
               x_1=a_1;
               y_1=b_1;
               if((x_1==1) && (y_1==1))
                 begin
                    x1=x_1;
                    y1=y_1;
                    row=x1-1;
                    col=y1-1;
                 end
               else if((x_1==1) && (y_1>1)) 
                 begin
                    x1=x_1;
                    y1=130-y_1;
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
                 else if((x_1>1) && (y_1==1)) 
                 begin
                    x1=130-x_1;
                    y1=y_1;
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
                 else if((x_1>1) && (y_1>1)) 
                 begin
                    x1=130-x_1;
                    y1=130-y_1;
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
              
              if(out_re_21>max1)
              begin
               max1=out_re_21;
               x_2=a_2;
               y_2=b_1;
               if((x_2==1) && (y_2==1))
                 begin
                    x2=x_2;
                    y2=y_2;
                    row1=x2-1;
                    col1=y2-1;
                 end
               else if((x_2==1) && (y_2>1)) 
                 begin
                    x2=x_2;
                    y2=130-y_2;
                    if((x2<65) && (y2<65))
                      begin
                         row1=x2-1;
                         col1=y2-1;
                      end
                    else if((x2<65) && (y2>64))
                      begin
                         row1=x2-1;
                         col1=y2-129;
                      end  
                    else if((x2>64) && (y2<65))
                      begin
                         row1=x2-129;
                         col1=y2-1;
                      end   
                    else if((x2>64) && (y2>64))
                      begin
                         row1=x2-129;
                         col1=y2-129;
                      end     
                 end 
                 else if((x_2>1) && (y_2==1)) 
                 begin
                    x2=130-x_2;
                    y2=y_2;
                    if((x2<65) && (y2<65))
                      begin
                         row1=x2-1;
                         col1=y2-1;
                      end
                    else if((x2<65) && (y2>64))
                      begin
                         row1=x2-1;
                         col1=y2-129;
                      end  
                    else if((x2>64) && (y2<65))
                      begin
                         row1=x2-129;
                         col1=y2-1;
                      end   
                    else if((x2>64) && (y2>64))
                      begin
                         row1=x2-129;
                         col1=y2-129;
                      end     
                 end  
                 else if((x_2>1) && (y_2>1)) 
                 begin
                    x2=130-x_2;
                    y2=130-y_2;
                    if((x2<65) && (y2<65))
                      begin
                         row1=x2-1;
                         col1=y2-1;
                      end
                    else if((x2<65) && (y2>64))
                      begin
                         row1=x2-1;
                         col1=y2-129;
                      end  
                    else if((x2>64) && (y2<65))
                      begin
                         row1=x2-129;
                         col1=y2-1;
                      end   
                    else if((x2>64) && (y2>64))
                      begin
                         row1=x2-129;
                         col1=y2-129;
                      end     
                 end  
              end  
              
              if(out_re_22>max2)
              begin
               max2=out_re_22;
               x_3=a_3;
               y_3=b_1;
               if((x_3==1) && (y_3==1))
                 begin
                    x3=x_3;
                    y3=y_3;
                    row2=x3-1;
                    col2=y3-1;
                 end
               else if((x_3==1) && (y_3>1)) 
                 begin
                    x3=x_3;
                    y3=130-y_3;
                    if((x3<65) && (y3<65))
                      begin
                         row2=x3-1;
                         col2=y3-1;
                      end
                    else if((x3<65) && (y3>64))
                      begin
                         row2=x3-1;
                         col2=y3-129;
                      end  
                    else if((x3>64) && (y3<65))
                      begin
                         row2=x3-129;
                         col2=y3-1;
                      end   
                    else if((x3>64) && (y3>64))
                      begin
                         row2=x3-129;
                         col2=y3-129;
                      end     
                 end 
                 else if((x_3>1) && (y_3==1)) 
                 begin
                    x3=130-x_3;
                    y3=y_3;
                    if((x3<65) && (y3<65))
                      begin
                         row2=x3-1;
                         col2=y3-1;
                      end
                    else if((x3<65) && (y3>64))
                      begin
                         row2=x3-1;
                         col2=y3-129;
                      end  
                    else if((x3>64) && (y3<65))
                      begin
                         row2=x3-129;
                         col2=y3-1;
                      end   
                    else if((x3>64) && (y3>64))
                      begin
                         row2=x3-129;
                         col2=y3-129;
                      end     
                 end  
                 else if((x_3>1) && (y_3>1)) 
                 begin
                    x3=130-x_3;
                    y3=130-y_3;
                    if((x3<65) && (y3<65))
                      begin
                         row2=x3-1;
                         col2=y3-1;
                      end
                    else if((x3<65) && (y3>64))
                      begin
                         row2=x3-1;
                         col2=y3-129;
                      end  
                    else if((x3>64) && (y3<65))
                      begin
                         row2=x3-129;
                         col2=y3-1;
                      end   
                    else if((x3>64) && (y3>64))
                      begin
                         row2=x3-129;
                         col2=y3-129;
                      end     
                 end  
              end  
              
              if(out_re_23>max3)
              begin
               max3=out_re_23;
               x_4=a_4;
               y_4=b_1;
               if((x_4==1) && (y_4==1))
                 begin
                    x4=x_4;
                    y4=y_4;
                    row3=x4-1;
                    col3=y4-1;
                 end
               else if((x_4==1) && (y_4>1)) 
                 begin
                    x4=x_4;
                    y4=130-y_4;
                    if((x4<65) && (y4<65))
                      begin
                         row3=x4-1;
                         col3=y4-1;
                      end
                    else if((x4<65) && (y4>64))
                      begin
                         row3=x4-1;
                         col3=y4-129;
                      end  
                    else if((x4>64) && (y4<65))
                      begin
                         row3=x4-129;
                         col3=y4-1;
                      end   
                    else if((x4>64) && (y4>64))
                      begin
                         row3=x4-129;
                         col3=y4-129;
                      end     
                 end 
                 else if((x_4>1) && (y_4==1)) 
                 begin
                    x4=130-x_4;
                    y4=y_4;
                    if((x4<65) && (y4<65))
                      begin
                         row3=x4-1;
                         col3=y4-1;
                      end
                    else if((x4<65) && (y4>64))
                      begin
                         row3=x4-1;
                         col3=y4-129;
                      end  
                    else if((x4>64) && (y4<65))
                      begin
                         row3=x4-129;
                         col3=y4-1;
                      end   
                    else if((x4>64) && (y4>64))
                      begin
                         row3=x4-129;
                         col3=y4-129;
                      end     
                 end  
                 else if((x_4>1) && (y_4>1)) 
                 begin
                    x4=130-x_4;
                    y4=130-y_4;
                    if((x4<65) && (y4<65))
                      begin
                         row3=x4-1;
                         col3=y4-1;
                      end
                    else if((x4<65) && (y4>64))
                      begin
                         row3=x4-1;
                         col3=y4-129;
                      end  
                    else if((x4>64) && (y4<65))
                      begin
                         row3=x4-129;
                         col3=y4-1;
                      end   
                    else if((x4>64) && (y4>64))
                      begin
                         row3=x4-129;
                         col3=y4-129;
                      end     
                 end  
              end  
              
            b_1=b_1+1;
         end
         if(b_1>128)
           begin
              a_1=a_1+1; a_2=a_2+1; a_3=a_3+1; a_4=a_4+1;
              b_1=1;
           end
         //a=a+1;
     end
    if((max>max1) && (max>max2) && (max>max3)) 
    begin
       Out_Row=row;
       Out_Col=col;
    end
    else if((max1>max) && (max1>max2) && (max1>max3)) 
    begin
       Out_Row=row1;
       Out_Col=col1;
    end
    else if((max2>max) && (max2>max1) && (max2>max3)) 
    begin
       Out_Row=row2;
       Out_Col=col2;
    end
    else if((max3>max1) && (max3>max2) && (max3>max)) 
    begin
       Out_Row=row3;
       Out_Col=col3;
    end
end

endmodule




