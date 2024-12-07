----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2024 04:31:19 PM
-- Design Name: 
-- Module Name: P2S - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity P2S is Port (
i_data_p : in std_logic_vector (3 downto 0) ;
i_reset  : in std_logic ;
i_clk    : in std_logic ;
i_valid  : in std_logic ;
o_done   : out std_logic ;
o_data_s : out std_logic 
 );
end P2S;

architecture Behavioral of P2S is
signal s_counter :integer range 0  to 3 := 0;
begin
process (i_clk , i_reset )
 begin
  if i_reset = '0' then
   o_data_s <= '0'  ;
   s_counter <= 0   ;
   o_done    <= '0' ;
  elsif i_clk'event and i_clk = '1' then
  if i_valid = '1' then
   if s_counter = 4 then 
    s_counter <= 0  ;
    o_data_s <= '0' ;
    o_done  <=  '0' ;
   else
    o_data_s <= i_data_p (s_counter);
    s_counter <= s_counter +1 ;
    o_done  <=  '1' ;
   end if ;
  else
    o_data_s <= '0' ;
    s_counter <= 0 ;
    o_done  <=  '0' ;
     
    end if ;
   end if ;
 end process ;
end Behavioral;
