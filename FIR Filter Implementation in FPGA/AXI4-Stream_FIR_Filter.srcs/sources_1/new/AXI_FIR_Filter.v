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
module FIR_Filter #(parameter DATA_INPUT = 16 ,DATA__OUTPUT = 32 )(
input axi_clk,
input axi_reset_n,

//AXI4-S slave I/O
input s_axis_valid,
input signed [DATA_INPUT-1:0] s_axis_data,
output s_axis_ready,

//AXI4-S master I/O
input  m_axis_ready,
output reg  m_axis_valid,
output reg signed [DATA__OUTPUT-1:0] m_axis_data
 );
 
 
//Tthis array is used to store samples and shift them
  reg signed [DATA_INPUT-1:0] s_samples [0:6]; 
  //this array is used to store the coff
  wire signed [DATA_INPUT-1:0] b [0:7];
  integer i=0 ;
  
  
 assign s_axis_ready = m_axis_ready;
 
 //filter coff
 assign b[0] = 'b00010000;
 assign b[1] = 'b00010000;
 assign b[2] = 'b00010000;
 assign b[3] = 'b00010000;
 assign b[4] = 'b00010000;
 assign b[5] = 'b00010000;
 assign b[6] = 'b00010000;
 assign b[7] = 'b00010000;

 

 
always@(posedge axi_clk or negedge axi_reset_n)
begin
      if(!axi_reset_n)
       begin 
                 s_samples[0] <= 0;
                 s_samples[1] <= 0;
                 s_samples[2] <= 0;
                 s_samples[3] <= 0;
                 s_samples[4] <= 0;
                 s_samples[5] <= 0;
                 s_samples[6] <= 0;
       end
            
     else if(s_axis_valid && s_axis_ready)
       begin 
              s_samples[0] <= s_axis_data; 
              s_samples[1] <= s_samples[0];
              s_samples[2] <= s_samples[1];
              s_samples[3] <= s_samples[2];
              s_samples[4] <= s_samples[3];
              s_samples[5] <= s_samples[4];
              s_samples[6] <= s_samples[5];
              
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
          m_axis_valid <= s_axis_valid && s_axis_ready ;
      
 end
 
 //output logic
 always@(*)
  begin
  if(s_axis_valid && s_axis_ready)
  begin
      m_axis_data = b[0]*s_axis_data 
     +b[1]*s_samples[0]
     +b[2]*s_samples[1]
     +b[3]*s_samples[2]
     +b[4]*s_samples[3]
     +b[5]*s_samples[4]
     +b[6]*s_samples[5]
     +b[7]*s_samples[6];    
   end  
 else 
 m_axis_data = 0;
   
  end
  
 endmodule
        
        
        
        
        
        
