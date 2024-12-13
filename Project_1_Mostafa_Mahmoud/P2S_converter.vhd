----------------------------------------------------------------------------------
-- Company: Electronics Research Institute 
-- Engineer: Mostafa Mahmoud Sayed 
-- 
-- Create Date: 12/07/2024 03:28:29 PM
-- Design Name: 
-- Module Name: P2S_converter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity P2S_converter is
    Port ( LOAD     : in STD_LOGIC;
           CLK      : in STD_LOGIC;
           RST      : in STD_LOGIC;
           in_data  : in STD_LOGIC_VECTOR (3 downto 0);
           out_data : out STD_LOGIC);
		   
end P2S_converter;

architecture Behavioral of P2S_converter is

signal temp : std_logic_vector (3 downto 0 );

begin
 
 process (CLK,RST) 
 
 begin 
 if(RST = '1') then
 
 out_data <= '0';
 temp     <= (others=> '0');
 
 elsif ( LOAD = '1') then
 
 temp <= in_data ;
 
 else 
 
 out_data <= temp(0);
 temp     <= std_logic_vector(shift_right(unsigned(temp),1)) ;
 
 end if;
 
 end process;
 

end Behavioral;
