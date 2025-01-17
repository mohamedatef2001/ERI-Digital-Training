`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2024 03:50:37 AM
// Design Name: 
// Module Name: FIR Filter
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
module send_recive_image #(parameter DATA__WIDTH = 32 )(
input axi_clk,
input axi_reset_n,

//AXI4-S slave I/O
input s_axis_valid,
input signed [DATA__WIDTH-1:0] s_axis_data,
output s_axis_ready,

//AXI4-S master I/O
input  m_axis_ready,
output reg  m_axis_valid,
output reg signed [DATA__WIDTH-1:0] m_axis_data
 );
 
 integer i=0 ;
  
  
 assign s_axis_ready = m_axis_ready;


 
always@(posedge axi_clk )
begin
      if(!axi_reset_n)
       begin 
             m_axis_data <= 0 ;
       end
            
     else if(s_axis_valid & s_axis_ready)
       begin 
             for(i=0;i<4;i=i+1)
               m_axis_data[i*8+:8] <= 255-s_axis_data[i*8+:8]; 
              
        end
 end 
        
//condition for send and receive        
always@(posedge axi_clk or negedge axi_reset_n)
 begin
     if(!axi_reset_n)
        begin
          m_axis_valid <= 0 ;
        end
        
      else
          m_axis_valid <= s_axis_valid  ;
      
 end


  
 endmodule
        
        
        
        
        
        
