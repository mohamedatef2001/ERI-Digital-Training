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
i_0    : in std_logic ;
i_1    : in std_logic ;
i_2    : in std_logic ;
i_3    : in std_logic ;
i_clk  : in std_logic ;
i_reset: in std_logic ;
i_load : in std_logic ;
o_q0   : out std_logic ;
o_q1   : out std_logic ;
o_q2   : out std_logic ;
o_q3   : out std_logic 
 );
end counter;

architecture Behavioral of counter is

signal s_counter : std_logic_vector (3 downto 0) ;

begin
   process (i_clk , i_reset)
    begin
	 if i_reset = '0' then
	     s_counter <= (others => '0') ;
         o_q0 <= '0' ;
         o_q1 <= '0' ;
         o_q2 <= '0' ; 
         o_q3 <= '0' ;
	 elsif i_clk'event and i_clk = '1' then
	     if i_load = '1' then
			 s_counter <= (i_3 & i_2 &i_1 &  i_0 );
		 else
			 s_counter <= s_counter +1 ;
             (o_q3,o_q2,o_q1,o_q0) <= s_counter ;
		end if;
	 end if ;
	end process ;
end Behavioral;