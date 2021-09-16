 `timescale 1ns / 1ps

module top_module(clk  ,Out_Row, Out_Col);

input clk;
output reg signed [31:0] Out_Row;
output reg signed [31:0] Out_Col;
 
 wire [15:0] temp1_r1;//4 wires to see the output of the two 2D-FFTs
 wire [15:0] temp1_i1;
 wire [15:0] temp2_r2;
 wire [15:0] temp2_i2;

reg [15:0] temp1_real;//4 regs for the bit flip operation
reg [15:0] temp1_img;
reg [15:0] temp2_real;
reg [15:0] temp2_img;

reg [60:0] count;     //needed for the always block-->from where to start capturing the data

 

reg [30:0] IFFT_real[0:16383];
reg [30:0] IFFT_img[0:16383];

 
 
reg signed [30:0] max;

 

integer j,i, k, l, p, m, n, u, x, y, x1, y1, row, col, a1, b1;
 
  

initial
begin
count=0;
j=0;  k=0; n=1;a1=1; b1=1; x=0;y=0; x1=0;y1=0;
i=0; l=0; m=0; p=0; row=0; col=0; max=31'b0;
 
end



test_design_128x128 image1 (clk, temp1_r1, temp1_i1);


test_design2_128x128 image2 (clk, temp2_r2, temp2_i2);

 

always@(posedge clk)
count = count+10;

 
reg [15:0] a,b,c,d;
wire [30:0] ac,ad,bc,bd;
wire [30:0] add, sub;
 

always@(posedge clk && (count>=170860) && (i<=16384))
begin
  temp1_img=temp1_i1;
  temp1_real=temp1_r1;
      
  temp1_img[15]=~temp1_img[15];   //performing the conjugate operation on the 1st image
  temp1_img[14]=~temp1_img[14]; temp1_img[13]=~temp1_img[13]; temp1_img[12]=~temp1_img[12]; temp1_img[11]=~temp1_img[11];
  temp1_img[10]=~temp1_img[10]; temp1_img[9]=~temp1_img[9]; temp1_img[8]=~temp1_img[8]; temp1_img[7]=~temp1_img[7];
  temp1_img[6]=~temp1_img[6]; temp1_img[5]=~temp1_img[5]; temp1_img[4]=~temp1_img[4]; temp1_img[3]=~temp1_img[3];
  temp1_img[2]=~temp1_img[2]; temp1_img[1]=~temp1_img[1]; temp1_img[0]=~temp1_img[0];  
  temp2_img=temp2_i2;
  temp2_real=temp2_r2;
  temp1_img=temp1_img+1;
  
  a=temp1_real; c=temp2_real;
  b=temp1_img; d=temp2_img;
  
  i=i+1;
end

mult_gen_0 MUL1 (
  .CLK(clk),  // input wire CLK
  .A(a),      // input wire [31 : 0] A
  .B(c),      // input wire [31 : 0] B
  .P(ac)      // output wire [63 : 0] P
); 

mult_gen_0 MUL2 (
  .CLK(clk),  // input wire CLK
  .A(a),      // input wire [31 : 0] A
  .B(d),      // input wire [31 : 0] B
  .P(ad)      // output wire [63 : 0] P
);

mult_gen_0 MUL3 (
  .CLK(clk),  // input wire CLK
  .A(b),      // input wire [31 : 0] A
  .B(c),      // input wire [31 : 0] B
  .P(bc)      // output wire [63 : 0] P
);

mult_gen_0 MUL4 (
  .CLK(clk),  // input wire CLK
  .A(b),      // input wire [31 : 0] A
  .B(d),      // input wire [31 : 0] B
  .P(bd)      // output wire [63 : 0] P
);
 
 
 assign add=bc+ad;
 assign sub=ac-bd; 
 


 


reg [15:0] s_axis_config_tdata_5=16'h0;
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
wire  [30:0] out_im_5;
wire [30:0] out_re_5;
wire [30:0] in_im_5;
wire [30:0] in_re_5;

assign out_im_5 = m_axis_data_tdata_5[62:32];  //imagenory 1d_ift output
assign out_re_5 = m_axis_data_tdata_5[30:0];  // real 1d_ift  output
assign in_im_5 = s_axis_data_tdata_5[62:32];  // imagenory 1d_ift input
assign in_re_5 = s_axis_data_tdata_5[30:0];   // real 1d_ift input





always@(posedge clk && (count  == 170880 ))
    begin
        s_axis_config_tvalid_5=1;
        s_axis_config_tvalid_5=0;
        s_axis_data_tvalid_5 =1;
        p = 0;
    end

// input to fft5
always@(posedge clk &&(count  >= 170880 )&&(p <= 16384))
begin
    s_axis_data_tdata_5[30:0] = sub;
    s_axis_data_tdata_5[62:32] = add;
     p= p+1;
end

// instantiate fft5 for 1D-ift
xfft_4 fft_5 (
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

// storing 1d output to memory
always@(posedge clk)
begin
       if((count>=174390) && (m<=16384))
       
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
wire signed [30:0] out_im_6;
wire signed[30:0] out_re_6;
wire [30:0] in_im_6;
wire [30:0] in_re_6;

assign out_im_6 = m_axis_data_tdata_6[62:32];  //imagenory 2d_ift output
assign out_re_6 = m_axis_data_tdata_6[30:0];  // real 2d_ift  output
assign in_im_6 = s_axis_data_tdata_6[62:32];  // imagenory 2d_ift input
assign in_re_6 = s_axis_data_tdata_6[30:0];   // real 2d_ift input


always@(posedge clk && (count  == 338400 ))
    begin
        s_axis_config_tvalid_6=1;
        s_axis_config_tvalid_6=0;
        s_axis_data_tvalid_6 =1;
        //u = 0;
    end

// input to fft6--> to get the final 2D-IFT o/p
always@(posedge clk &&(count  >= 338400 ))
begin
      if(j<=128)
         begin
            if(k<16384)
              begin
                 s_axis_data_tdata_6[30:0] = IFFT_real[k];
                 s_axis_data_tdata_6[62:32] = IFFT_img[k];
                 k=k+128;
              end
              if(k==(16384+j))
                begin
                  j=j+1;
                  k=j;
                end
         end
    
end

// instantiate fft6 for 2D-ift
xfft_5 fft_6 (
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

 

always@(posedge clk && (count>=341910))
begin
   if(a1<129)
     begin
       if(b1<129)
         begin
            
            if(out_re_6>max)
              begin
               max=out_re_6;
               x=a1;
               y=b1;
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
            b1=b1+1;
         end
         if(b1>128)
           begin
              a1=a1+1;
              b1=1;
           end
         //a=a+1;
     end
    Out_Row=row;
    Out_Col=col;
end

endmodule





