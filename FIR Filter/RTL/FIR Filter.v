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

module FIR_Filter (input_data,CLK,RST,ENABLE,output_data);

//FIR  coff world width
parameter N1=8;
//input data word width
parameter N2=16;
//output data word bits
parameter N3=32;
//this array is used to store the coff
wire signed [N1-1:0] b [0:7];

//filter coff
assign b[0] = 'b00010000;
assign b[1] = 'b00010000;
assign b[2] = 'b00010000;
assign b[3] = 'b00010000;
assign b[4] = 'b00010000;
assign b[5] = 'b00010000;
assign b[6] = 'b00010000;
assign b[7] = 'b00010000;

//input data
input signed [N2-1:0] input_data;
//oitput data samples
//output signed [N2-1:0] sampleT;
//clock
input CLK;
//Enable filte
input ENABLE;
//input reset
input RST;
//filtered data
output signed [N3-1:0] output_data;


//Tthis array is used to store samples and to shift them
reg signed [N2-1:0] samples [0:6];

//this equation implement the filter
assign output_data = b[0]*input_data
                     +b[1]*samples[0]
                     +b[2]*samples[1]
                     +b[3]*samples[2]
                     +b[4]*samples[3]
                     +b[5]*samples[4]
                     +b[6]*samples[5]
                     +b[7]*samples[6];
                     
always @(posedge CLK)
begin
     //reset the filter
     if (RST == 'b1)
     begin
          samples[0]<=0;
          samples[1]<=0;
          samples[2]<=0;
          samples[3]<=0;
          samples[4]<=0;
          samples[5]<=0;
          samples[6]<=0;
     end
                   
     else if(ENABLE=='b1 && RST=='b0)  
     begin
          samples[0]<=input_data;
          samples[1]<=samples[0];
          samples[2]<=samples[1];
          samples[3]<=samples[2];
          samples[4]<=samples[3];
          samples[5]<=samples[4];
          samples[6]<=samples[5];
      end
      
 end
 
 // assign output
// assign sampleT=samples[0];
       
endmodule

