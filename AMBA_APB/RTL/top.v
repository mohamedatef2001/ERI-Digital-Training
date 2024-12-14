module TOP #(parameter WIDTH=8)(
  input  I_PCLK,
  input  I_PRESETn,
  input  I_transfer,
  input  I_READ_WRITE,
  input  [WIDTH-1:0] I_apb_write_paddr,
  input  [WIDTH-1:0] I_apb_write_data,
  input  [WIDTH-1:0] I_apb_read_paddr,
  output [WIDTH-1:0] o_apb_read_data_out
  );
  
  wire S_PWRITE ;
  wire S_PREADY ;
  wire S_PSEL1  ;
  wire S_PENABLE;
  wire [WIDTH-1:0] S_PADDR;
  wire [WIDTH-1:0] S_PWDATA;
  wire [WIDTH-1:0] S_PRDATA;
  
  MASTER DUT_MASTER (
  .i_PCLK(I_PCLK),
  .i_PRESETn(I_PRESETn),
  .i_transfer(I_transfer),
  .i_READ_WRITE(I_READ_WRITE),
  .i_PREADY(S_PREADY),
  .i_apb_write_paddr(I_apb_write_paddr),
  .i_apb_write_data(I_apb_write_data),
  .i_apb_read_paddr(I_apb_read_paddr),
  .o_apb_read_data_out(o_apb_read_data_out),
  .o_pwdata(S_PWDATA),
  .o_paddr(S_PADDR),
  .o_PWRITE(S_PWRITE),
  .o_PSEL1(S_PSEL1),
  .i_prdata(S_PRDATA),
  .o_PENABLE(S_PENABLE)
  );
  
  
  MEMORY DUT_MEMORY (
  .i_PWRITE(S_PWRITE),
  .i_PRESETn(I_PRESETn),
  .i_PSEL1(S_PSEL1),
  .i_PENABLE(S_PENABLE),
  .i_paddr(S_PADDR),
  .i_pwdata(S_PWDATA),
  .o_prdata(S_PRDATA),
  .o_PREADY(S_PREADY)
  );
  
endmodule
