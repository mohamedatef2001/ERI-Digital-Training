----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2024 12:08:27 AM
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity counter is Port (
i_data : in std_logic_vector (3 downto 0) ;
i_stop_value : in std_logic_vector (3 downto 0);
i_clk  : in std_logic ;
i_reset: in std_logic ;
i_load : in std_logic ;
o_stop : out std_logic ;
o_data : out std_logic_vector (3 downto 0) 
 );
end counter;

architecture Behavioral of counter is

signal s_counter : std_logic_vector (3 downto 0) ;
signal s_flag : std_logic;

begin
   process (i_clk , i_reset)
    begin
	 if i_reset = '0' then
	     s_counter <= (others => '0') ;
         o_data    <= (others => '0') ;
         o_stop   <= '0' ;
         s_flag   <= '1' ;
	 elsif i_clk'event and i_clk = '1' then
	     if i_load = '1' then
			 s_counter <= i_data ;
		 elsif s_counter /= i_stop_value then
			 s_counter <= s_counter +1 ;
             o_data    <= s_counter ;
          elsif s_flag = '1' then
             o_data    <= s_counter ;
             o_stop    <= '1' ;
             s_flag    <= not(s_flag) ;
         else 
           o_data    <= s_counter ;
           o_stop   <= '0' ;
		end if;
	 end if ;
	end process ;
end Behavioral;