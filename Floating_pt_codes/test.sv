//***Test Bench***

`timescale 1ns / 1ps

module test_16();
reg clk;
wire signed [31:0] Out_Row;
wire signed [31:0] Out_Col;
 
integer fd , fd1, fd2, fd3, j;
reg[40:0] count1;
 
top_module uut(clk, Out_Row, Out_Col);

initial
begin
clk =1; j=0;
end

always #5 clk = ~clk ;

initial begin
count1 = 0;
//fd = $fopen ("C:/Users/Soham_Das/Desktop/fft_related/fft_128x128/out_1d_128x128.csv", "w");
   // $fdisplay(fd, "\n**************************Ignoring miss match due to floationg point number as it is already mentioned as limitation of design************************\n\n\n");
    //$fclose(fd);
end
 
always @(posedge clk )
count1 =count1+10;

/*always @(posedge clk )
begin

if((count1 >=1339290 )&&(count1 <=1503130 ))
if(j<168340)
begin
$fdisplay (fd3, "  %0.08f, %0.08f ",  $bitstoshortreal(Out_Real), $bitstoshortreal(Out_Img));
//$fdisplay (fd2, "  %0.08f, %0.08f ",  $bitstoshortreal(Out_Real), $bitstoshortreal(Out_Img));
end
if(count1>=1503130)
$fclose(fd3);
end */
endmodule
