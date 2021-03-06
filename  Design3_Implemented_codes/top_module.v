 `timescale 1ns / 1ps

module top_module(clk, reset, Out_Row, Out_Col);

input clk;
input reset;

//Shifted Row and Column Indices--> final result
output reg  [31:0] Out_Row;
output reg  [31:0] Out_Col;
 
(* dont_touch = "yes" *) wire [15:0] temp1_r1;//4 wires to see the output of the two 2D-FFTs
(* dont_touch = "yes" *) wire [15:0] temp1_i1;
(* dont_touch = "yes" *) wire [15:0] temp2_r2;
(* dont_touch = "yes" *) wire [15:0] temp2_i2;

(* dont_touch = "yes" *) reg [15:0] temp1_real;//4 regs for the bit flip operation
(* dont_touch = "yes" *) reg [15:0] temp1_img;
(* dont_touch = "yes" *) reg [15:0] temp2_real;
(* dont_touch = "yes" *) reg [15:0] temp2_img;

(* dont_touch = "yes" *) reg [60:0] count=0;     //needed for the always block-->from where to start capturing the data

 

(* dont_touch = "yes" *) reg [30:0] IFFT_real[0:16383];
(* dont_touch = "yes" *) reg [30:0] IFFT_img[0:16383];

 
 
(* dont_touch = "yes" *) reg signed [30:0] max=0;
(* dont_touch = "yes" *) reg flag1=0, flag2=0, flag3=0, flag4=0;
 

(* dont_touch = "yes" *) integer j=0, i=0, k=0, l=0, p=0, m=0, n=1, x=0, y=0, x1=0, y1=0, row=0, col=0, a1=1, b1=1;
 
  

/*initial
begin
count=0;
j=0;  k=0; n=1;a1=1; b1=1; x=0;y=0; x1=0;y1=0;
i=0; l=0; m=0; p=0; row=0; col=0; max=31'b0;
 
end*/



test_design_128x128 image1 (clk,reset, temp1_r1, temp1_i1);


test_design2_128x128 image2 (clk,reset, temp2_r2, temp2_i2);

 

always@(posedge clk)
begin
  if(reset)
     count = count+10;
end
 
(* dont_touch = "yes" *) reg [15:0] a,b,c,d;
(* dont_touch = "yes" *) wire [31:0] ac,ad,bc,bd;
(* dont_touch = "yes" *) wire [31:0] add, sub;

always@(posedge clk && (count==170860))
      flag3=1;
 
//Performing Conjugate on the 2D-FFT resultant matrix of the Ref. Image
always@(posedge clk && (count>=170860) && (i<=16383))
begin
 if(flag3)
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
end

//Element-by-Element Multiplication
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
 
//End of Element-by Element Multiplication

 

//Instantiating FFT IP for 1D-IFFT
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
(* dont_touch = "yes" *) wire  [30:0] out_im_5;
(* dont_touch = "yes" *) wire [30:0] out_re_5;
(* dont_touch = "yes" *) wire [30:0] in_im_5;
(* dont_touch = "yes" *) wire [30:0] in_re_5;

assign out_im_5 = m_axis_data_tdata_5[62:32];  //imagenory 1d_ift output
assign out_re_5 = m_axis_data_tdata_5[30:0];  // real 1d_ift  output
assign in_im_5 = s_axis_data_tdata_5[62:32];  // imagenory 1d_ift input
assign in_re_5 = s_axis_data_tdata_5[30:0];   // real 1d_ift input


always@(posedge clk && (count  == 170880 ))
    begin
        flag4=1;
    end


always@(posedge clk && (count  == 170890 ))
    begin
        s_axis_config_tvalid_5=1;
        s_axis_config_tvalid_5=0;
        s_axis_data_tvalid_5 =1;
    end

 
always@(posedge clk &&(count  >= 170880 )&&(p <= 16383))
begin
  if(flag4)
  begin  
    s_axis_data_tdata_5[30:0] = sub[30:0];
    s_axis_data_tdata_5[62:32] = add[30:0];
     p= p+1;
  end   
end

 
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

// storing 1d-IFFT output to memory
always@(posedge clk)
begin
       if((count>=174390) && (m<=16383))
           begin
              IFFT_real[m]=out_re_5;
              IFFT_img[m]=out_im_5;
              m=m+1;
           end
end 

 
//Instantiating FFT IP for 2D-IFFT
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
(* dont_touch = "yes" *) wire signed [30:0] out_im_6;
(* dont_touch = "yes" *) wire signed[30:0] out_re_6;
(* dont_touch = "yes" *) wire [30:0] in_im_6;
(* dont_touch = "yes" *) wire [30:0] in_re_6;

assign out_im_6 = m_axis_data_tdata_6[62:32];  //imagenory 2d_ift output
assign out_re_6 = m_axis_data_tdata_6[30:0];  // real 2d_ift  output
assign in_im_6 = s_axis_data_tdata_6[62:32];  // imagenory 2d_ift input
assign in_re_6 = s_axis_data_tdata_6[30:0];   // real 2d_ift input


always@(posedge clk && (count == 338400 ))
    begin
        flag1=1;
    end

always@(posedge clk && (count == 338410 ))
    begin
        s_axis_config_tvalid_6=1;
        s_axis_config_tvalid_6=0;
        s_axis_data_tvalid_6=1;
    end


// taking transpose of 1D-IFFT--> to give input to 2D-IFFT 
always@(posedge clk &&(count >= 338400))
begin
   if(flag1)
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
end
 
 
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

 
always@(posedge clk && (count == 341910))
    begin
        flag2=1;
    end 
 
//Performing FFT Shift to get the Shifted Row and Column Indices
always@(posedge clk && (count>=341920))
begin
  if(flag2)
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
end

/*ila_0 ILA (
	.clk(clk), // input wire clk


	.probe0(reset), // input wire [0:0]  probe0  
	.probe1(Out_Row), // input wire [31:0]  probe1 
	.probe2(Out_Col) // input wire [31:0]  probe2
);*/

endmodule

