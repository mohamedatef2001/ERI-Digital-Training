module MEMORY #(parameter WIDTH=8) (
input i_PWRITE,
input i_PRESETn,
input i_PSEL1,
input i_PENABLE,
input [WIDTH-1:0] i_paddr,
input [WIDTH-1:0] i_pwdata,
output reg [WIDTH-1:0] o_prdata,
output reg o_PREADY
);

reg [7:0] mem [0:7] ;
integer i;

always@(*) 
begin
  o_prdata = 0;
  o_PREADY = 0;
  
  if (~i_PRESETn)
    for(i=0;i<=7;i=i+1)
    mem[i] = 0;
  else if (i_PSEL1 && i_PENABLE && i_PWRITE)
   begin
    mem[i_paddr] = i_pwdata;
    o_PREADY = 1;
   end
  else if (i_PSEL1 && i_PENABLE && ! i_PWRITE)
   begin
    o_prdata = mem[i_paddr];
    o_PREADY = 1;
   end
  else 
   begin
    o_prdata = 0;
    o_PREADY = 0;
   end
    
 end
 endmodule
 

