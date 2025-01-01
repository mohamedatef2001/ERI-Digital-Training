module MASTER #(parameter WIDTH = 8 )(
  input  i_PCLK,
  input  i_PRESETn,
  input  i_transfer,
  input  i_READ_WRITE,
  input  i_PREADY,
  input  [WIDTH-1:0] i_apb_write_paddr,
  input  [WIDTH-1:0] i_apb_write_data,
  input  [WIDTH-1:0] i_apb_read_paddr,
  input  [WIDTH-1:0] i_prdata,
  output reg [WIDTH-1:0] o_apb_read_data_out,
  output reg [WIDTH-1:0] o_pwdata,
  output reg [WIDTH-1:0] o_paddr,
  output reg o_PWRITE,
  output reg o_PSEL1,
  output reg o_PENABLE
  
 );


 parameter      IDEAL  = 2'b00 ,
                SETUP  = 2'b01 ,
                ACCESS = 2'b11 ;
                
 reg [1:0] s_current_state , s_next_state ;
             
always@(posedge i_PCLK or negedge i_PRESETn)
begin 
  if(!i_PRESETn)
    s_current_state <= IDEAL ;
  else
    s_current_state <= s_next_state ;
end 
          

always@(*)
begin
 case(s_current_state)
  IDEAL : begin
    if (i_transfer)
      s_next_state = SETUP ;
    else
      s_next_state = IDEAL ; 
          end
          
  SETUP : begin
    s_next_state = ACCESS ; 
          end
          
  ACCESS : begin 
    if (~i_PREADY) 
      s_next_state = ACCESS ; 
    else if (i_PREADY && i_transfer )
      s_next_state = SETUP ; 
    else
       s_next_state = IDEAL ; 
         end
         
    default :  s_next_state = IDEAL ; 
    
  endcase 
end

always@(*) 
begin
  case(s_current_state)
  IDEAL : begin
     o_apb_read_data_out = 'd0;
     o_pwdata = 0;
     o_paddr  = 0;
     o_PWRITE = 0;
     o_PSEL1  = 0;
     o_PENABLE = 0;
         end
         
  SETUP: begin
     o_PSEL1 = 'd1;
       end
       
  
  ACCESS : begin 
     o_PENABLE = 'd1; 
     if (i_READ_WRITE) // Write
       begin
         o_PWRITE = 'd1 ;
         o_paddr  = i_apb_write_paddr;
         o_pwdata = i_apb_write_data;
       end
      else
        begin
         o_PWRITE = 'd0 ;
         o_paddr  = i_apb_read_paddr;
         o_apb_read_data_out = i_prdata ;
         
        end
      end
    default : begin
        o_apb_read_data_out = 'd0;
        o_pwdata = 'd0;
        o_paddr  = 'd0;
        o_PWRITE = 'd0;
        o_PSEL1  = 'd0;
        o_PENABLE = 'd0;
             end
  endcase
end
endmodule
      
     
     
      
                
                
                
                
                
                
                      
