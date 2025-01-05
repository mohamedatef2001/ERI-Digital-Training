`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2025 05:01:41 PM
// Design Name: 
// Module Name: AXI_FIR_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AXI_FIR_tb #(parameter DATA_INPUT = 16 ,DATA__OUTPUT = 32 );
reg axi_clk_tb ;
reg axi_reset_n_tb ;
reg s_axis_valid_tb  ;
reg signed [DATA_INPUT-1:0] s_axis_data_tb;
reg m_axis_ready_tb ;
wire s_axis_ready_tb;
wire m_axis_valid_tb;
wire signed [DATA__OUTPUT-1:0] m_axis_data_tb ;

reg [DATA_INPUT-1:0] data [99:0];
//DUT
FIR_Filter DUT(
                    .axi_clk(axi_clk_tb),
                    .axi_reset_n(axi_reset_n_tb),
                    .s_axis_valid(s_axis_valid_tb),
                    .s_axis_data(s_axis_data_tb),
                    .m_axis_ready(m_axis_ready_tb),
                    .s_axis_ready(s_axis_ready_tb),
                    .m_axis_valid(m_axis_valid_tb),
                    .m_axis_data(m_axis_data_tb)    
                   );


//integer for the for loop
integer k ;
//integer for the file
integer FILE1;

//clock period
always #10 axi_clk_tb=~axi_clk_tb;

initial
begin
     //set the input sample number
     k=0;
     //load the data samples and store them in array called data
     $readmemb ("input_data.mem" , data);
     
     
     //open the file for saving the filtered data
     FILE1=$fopen("save_data" , "w");
     //set the clock
     axi_clk_tb=0; 
     #20
     //reset the filter
     axi_reset_n_tb=1'b0;
     #40
     axi_reset_n_tb=1'b1;
     #10
      s_axis_valid_tb=1'b1; 
      #10
      m_axis_ready_tb=1'b1;
       s_axis_data_tb <= data[0];
       #10
     for (k=1;k<100;k=k+1)
     begin
           @(posedge axi_clk_tb);
            s_axis_data_tb <= data[k];
            $fdisplay(FILE1,"%b",m_axis_data_tb);
            if(k==99)
            $fclose(FILE1);
     end
 end
 endmodule          
