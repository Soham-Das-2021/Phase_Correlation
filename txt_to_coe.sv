//Test Bench
//***Converting decimal nos.(Image data) into 32 bit Single Precision Floating pOint binary nos. 

`timescale 1ns / 1ps

module test_16();
reg clk;

integer fd , fd1, fd_2,fd2, fd_3,fd3, fd_4,fd4, fd_5,fd5, fd_6,fd6, fd_7,fd7, fd_8,fd8, fd_9,fd9, fd_10,fd10, fd_11,fd11;
reg[40:0] count1;

test_design_16x16 uut(clk);

initial
clk =1;
real  out , out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, line;
real captured_outputs,captured_outputs2,captured_outputs3,captured_outputs4,captured_outputs5,captured_outputs6,captured_outputs7,captured_outputs8,captured_outputs9,captured_outputs10, captured_outputs11;
reg eof;
//initial
//eof = $feof(fd);
//reg [31:0] captured_outputs[0:16383];
always #5 clk = ~clk ;
initial begin
count1 = 0;
fd = $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_10.txt", "r");         //open text file that is to be read
fd1 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_10.txt", "w"); //open text file where 32 bit binary nos. will be written

/*fd_2 = $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_0.txt", "r");
fd2 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_0.txt", "w");

fd_3 = $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_1.txt", "r");
fd3 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_1.txt", "w");

fd_4 = $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_2.txt", "r");
fd4 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_2.txt", "w");

fd_5= $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_3.txt", "r");
fd5 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_3.txt", "w");

fd_6= $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_4.txt", "r");
fd6 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_4.txt", "w");

fd_7 = $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_5.txt", "r");
fd7 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_5.txt", "w");

fd_8= $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_6.txt", "r");
fd8 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_6.txt", "w");

fd_9 = $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_7.txt", "r");
fd9 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_7.txt", "w");

fd_10= $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_8.txt", "r");
fd10 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_8.txt", "w");

fd_11 = $fopen ("C:/Users/HP/Desktop/txt_to_coe/img_9.txt", "r");
fd11 =      $fopen ("C:/Users/HP/Desktop/txt_to_coe/image_9.txt", "w");*/
 
   if (fd == 0) begin               // If outputs file is not found
      $display("data_file handle was NULL"); //simulation monitor command
      $finish;
    end
    while(!$feof(fd))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out = $fscanf(fd, "%f\n", captured_outputs);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs); 
   
     $display (" %b" , $shortrealtobits(captured_outputs));
     $fdisplay (fd1, "  %b,",  $shortrealtobits(captured_outputs));   //coverting to binary nos. and writing them onto the text file
   end
   
  /* while(!$feof(fd_2))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out2 = $fscanf(fd_2, "%f\n", captured_outputs2);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs2); 
   
     $display (" %b" , $shortrealtobits(captured_outputs2));
     $fdisplay (fd2, "  %b,",  $shortrealtobits(captured_outputs2)); 
   end
   
    while(!$feof(fd_3))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out3 = $fscanf(fd_3, "%f\n", captured_outputs3);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs3); 
   
     $display (" %b" , $shortrealtobits(captured_outputs3));
     $fdisplay (fd3, "  %b,",  $shortrealtobits(captured_outputs3)); 
   end
   
    while(!$feof(fd_4))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out4 = $fscanf(fd_4, "%f\n", captured_outputs4);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs4); 
   
     $display (" %b" , $shortrealtobits(captured_outputs4));
     $fdisplay (fd4, "  %b,",  $shortrealtobits(captured_outputs4)); 
   end
   
    while(!$feof(fd_5))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out5 = $fscanf(fd_5, "%f\n", captured_outputs5);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs5); 
   
     $display (" %b" , $shortrealtobits(captured_outputs5));
     $fdisplay (fd5, "  %b,",  $shortrealtobits(captured_outputs5)); 
   end
   
    while(!$feof(fd_6))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out6 = $fscanf(fd_6, "%f\n", captured_outputs6);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs6); 
   
     $display (" %b" , $shortrealtobits(captured_outputs6));
     $fdisplay (fd6, "  %b,",  $shortrealtobits(captured_outputs6)); 
   end
   
    while(!$feof(fd_7))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out7 = $fscanf(fd_7, "%f\n", captured_outputs7);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs7); 
   
     $display (" %b" , $shortrealtobits(captured_outputs7));
     $fdisplay (fd7, "  %b,",  $shortrealtobits(captured_outputs7)); 
   end
   
    while(!$feof(fd_8))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out8 = $fscanf(fd_8, "%f\n", captured_outputs8);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs8); 
   
     $display (" %b" , $shortrealtobits(captured_outputs8));
     $fdisplay (fd8, "  %b,",  $shortrealtobits(captured_outputs8)); 
   end
   
    while(!$feof(fd_9))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out9 = $fscanf(fd_9, "%f\n", captured_outputs9);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs9); 
   
     $display (" %b" , $shortrealtobits(captured_outputs9));
     $fdisplay (fd9, "  %b,",  $shortrealtobits(captured_outputs9)); 
   end
   
    while(!$feof(fd_10))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out10 = $fscanf(fd_10, "%f\n", captured_outputs10);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs10); 
   
     $display (" %b" , $shortrealtobits(captured_outputs10));
     $fdisplay (fd10, "  %b,",  $shortrealtobits(captured_outputs10)); 
   end
   
    while(!$feof(fd_11))
    begin
    //$fgets(line,fd);
    $display ("line:%f",line);
    out11 = $fscanf(fd_11, "%f\n", captured_outputs11);     //Outputs line text
    $display ("Line :[ _ outputs: %f]" , captured_outputs11); 
   
     $display (" %b" , $shortrealtobits(captured_outputs11));
     $fdisplay (fd11, "  %b,",  $shortrealtobits(captured_outputs11)); 
   end*/
   end 
   
endmodule

