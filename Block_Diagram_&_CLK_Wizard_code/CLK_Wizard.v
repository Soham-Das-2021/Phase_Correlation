module clk_wizard (clk_in_p,clk_in_n);

input clk_in_p;
input clk_in_n;
wire clk_out;

clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk_out),     // output clk_out1
    // Status and control signals
    .reset(1), // input reset
   // Clock in ports
    .clk_in1_p(clk_in_p),    // input clk_in1_p
    .clk_in1_n(clk_in_n));    // input clk_in1_n
    
ila_0 your_ILA (
	.clk(clk_out), // input wire clk


	.probe0(clk_out) // input wire [0:0] probe0
);    
    

endmodule
