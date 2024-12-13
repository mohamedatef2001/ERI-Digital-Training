----------------------------------------------------------------------------------
-- Company: Electronics Research Institute 
-- Engineer: Mostafa Mahmoud Sayed
-- 
-- Create Date: 12/07/2024 01:27:14 PM
-- Design Name: 
-- Module Name: up_counter - Behavioral
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

entity up_counter is
    Port ( CLK      : in STD_LOGIC;
           RST      : in STD_LOGIC;
           LOAD     : in STD_LOGIC;
           in_data  : in STD_LOGIC_VECTOR (3 downto 0);
           out_data : out STD_LOGIC_VECTOR (3 downto 0));
end up_counter;

architecture Behavioral of up_counter is

signal sig_count: std_logic_vector (3 downto 0) := "0000"; 

begin

process (CLK,RST)

begin 

if(RST = '1') then

sig_count <= (others=> '0');

elsif (LOAD = '1') then 

sig_count <=  in_data;

elsif (rising_edge(CLK)) then
 
 sig_count <= std_logic_vector (unsigned (sig_count) + 1);
 
 end if;
 
end process;

out_data <= sig_count;




end Behavioral;
